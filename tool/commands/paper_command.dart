import '../../lib/core/models/paper.dart' show Paper, PaperStatus;
import '../cli_helpers.dart' show println, bold, cyan, printError, printSuccess, printJson, green, yellow, red;
import '../cli_state.dart' show loadPapersIndex, savePapersIndex, deletePaperCache;

const _help = 'papers list [--status S] [--json] | papers delete <id>';

void paperCommand(List<String> args) {
  if (args.isEmpty || args[0] == 'list') {
    _listPapers(args);
  } else if (args[0] == 'delete') {
    if (args.length < 2) {
      printError('Usage: papers delete <id>');
      return;
    }
    _deletePaper(args[1]);
  } else {
    printError('Unknown: ${args[0]}\n$_help');
  }
}

void _listPapers(List<String> args) {
  final statusFilter = args.contains('--status')
      ? args[args.indexOf('--status') + 1]
      : null;
  final asJson = args.contains('--json');

  final papers = loadPapersIndex();
  if (papers.isEmpty) {
    println('No papers imported.');
    return;
  }

  List<Map<String, dynamic>> filtered = papers;
  if (statusFilter != null) {
    filtered = papers.where((p) => p['status'] == statusFilter).toList();
  }

  if (asJson) {
    printJson(filtered);
    return;
  }

  println('${bold("Papers")} (${filtered.length}/${papers.length}):\n');
  for (var i = 0; i < filtered.length; i++) {
    final p = filtered[i];
    final status = p['status'] as String? ?? 'unknown';
    final statusColor = switch (status) {
      'parsed' || 'translated' => green(status),
      'error' => red(status),
      _ => yellow(status),
    };
    println('  [${i + 1}] ${bold(p['title'] ?? 'untitled')}');
    println('       ${cyan("ID")}: ${p['id']} | ${cyan("Status")}: $statusColor | ${cyan("Source")}: ${p['source']}');
    final imported = p['importedAt'] as String?;
    if (imported != null) {
      println('       ${cyan("Imported")}: ${imported.substring(0, 10)}');
    }
    println('');
  }
}

void _deletePaper(String id) {
  final papers = loadPapersIndex();
  final before = papers.length;
  papers.removeWhere((p) => p['id'] == id);
  if (papers.length == before) {
    printError('Paper not found: $id');
    return;
  }
  savePapersIndex(papers);
  deletePaperCache(id);
  printSuccess('Deleted paper: $id');
}
