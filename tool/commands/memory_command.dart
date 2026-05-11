import '../cli_helpers.dart' show println, bold, cyan, printError, printSuccess, printJson;
import '../cli_state.dart' show loadMemories, saveMemories;

const _help = 'memory list [--json] | memory prune';

void memoryCommand(List<String> args) {
  if (args.isEmpty) {
    printError(_help);
    return;
  }

  final sub = args[0];

  if (sub == 'list') {
    final asJson = args.contains('--json');
    final memories = loadMemories();
    if (memories.isEmpty) {
      println('No memories.');
      return;
    }

    if (asJson) {
      printJson(memories);
      return;
    }

    println('${bold("Memories")} (${memories.length}):\n');
    for (var i = 0; i < memories.length; i++) {
      final m = memories[i];
      println('  [${i + 1}] ${m['summary'] ?? ''}');
      println('       ${cyan("ID")}: ${m['id']} | ${cyan("Paper")}: ${m['paperId'] ?? '-'}');
      if (m['timestamp'] != null) {
        println('       ${cyan("When")}: ${(m['timestamp'] as String).substring(0, 19)}');
      }
      println('');
    }
  } else if (sub == 'prune') {
    final cutoff = DateTime.now().subtract(const Duration(days: 30));
    final memories = loadMemories();
    final before = memories.length;
    memories.removeWhere((m) {
      final ts = DateTime.tryParse(m['timestamp'] as String? ?? '');
      return ts != null && ts.isBefore(cutoff);
    });
    saveMemories(memories);
    final removed = before - memories.length;
    printSuccess('Pruned $removed memories, ${memories.length} remaining.');
  } else {
    printError('Unknown: $sub\n$_help');
  }
}
