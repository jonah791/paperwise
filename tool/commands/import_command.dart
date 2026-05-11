import 'dart:convert';
import 'dart:io';

import '../../lib/core/api/mineru_api.dart' show MineruApi;
import '../../lib/core/models/paper.dart' show Paper, PaperStatus;
import '../../lib/core/services/parse_service.dart' show ParseService;
import '../../lib/core/services/search_service.dart' show SearchService;
import '../cli_helpers.dart' show println, bold, cyan, printError, printSuccess;
import '../cli_state.dart' show loadConfig, loadPapersIndex, savePapersIndex, savePaperMarkdown;

const _help = 'import search <index> | import pdf <path> [--title T] | import url <url> [--title T]';

Future<void> importCommand(List<String> args) async {
  if (args.isEmpty) {
    printError(_help);
    return;
  }

  final apiKey = (loadConfig()['mineru-api-key'] as String?) ?? '';
  if (apiKey.isEmpty) {
    printError('MinerU API key not set. Run: config set mineru-api-key <key>');
    return;
  }

  final sub = args[0];

  if (sub == 'search') {
    if (args.length < 2) {
      printError('Usage: import search <index>');
      return;
    }
    final index = int.tryParse(args[1]);
    if (index == null) {
      printError('Invalid index: ${args[1]}');
      return;
    }
    await _importFromSearch(index, apiKey);
  } else if (sub == 'pdf') {
    if (args.length < 2) {
      printError('Usage: import pdf <path> [--title T]');
      return;
    }
    final pdfPath = args[1];
    final title = args.contains('--title')
        ? args[args.indexOf('--title') + 1]
        : null;
    await _importPdf(pdfPath, apiKey, title: title);
  } else if (sub == 'url') {
    if (args.length < 2) {
      printError('Usage: import url <url> [--title T]');
      return;
    }
    final url = args[1];
    final title = args.contains('--title')
        ? args[args.indexOf('--title') + 1]
        : null;
    await _importUrl(url, apiKey, title: title);
  } else {
    printError('Unknown: $sub\n$_help');
  }
}

Future<void> _importFromSearch(int index, String apiKey) async {
  // Re-run search to get the paper info
  printError('Re-run search first, then use the result index');
}

Future<void> _importPdf(String pdfPath, String apiKey, {String? title}) async {
  final file = File(pdfPath);
  if (!file.existsSync()) {
    printError('File not found: $pdfPath');
    return;
  }

  final resolvedTitle = title ?? pdfPath.split(Platform.pathSeparator).last.replaceAll('.pdf', '');
  println('${bold("Importing PDF")}: $pdfPath');
  println('${cyan("Title")}: $resolvedTitle');

  final mineru = MineruApi(apiKey: apiKey);
  final parseService = ParseService(api: mineru);

  try {
    // Estimate page count from file size (rough)
    final pageCount = (file.statSync().size ~/ 50000).clamp(1, 500);
    println('${cyan("Estimated pages")}: $pageCount');

    final result = await parseService.parsePdf(file, pageCount);
    final paperId = DateTime.now().millisecondsSinceEpoch.toString();

    final paper = Paper(
      id: paperId,
      title: resolvedTitle,
      status: PaperStatus.parsed,
      pageCount: pageCount,
      importedAt: DateTime.now(),
    );

    final papers = loadPapersIndex();
    papers.add(paper.toJson());
    savePapersIndex(papers);
    savePaperMarkdown(paperId, result.markdown);

    if (result.contentListJson.isNotEmpty) {
      savePaperMarkdown(paperId, result.markdown); // overwrite with metadata
    }

    printSuccess('Import complete: id=$paperId');
    println('  ${cyan("Markdown")}: ${result.markdown.length} chars');
    println('  ${cyan("Images")}: ${result.imagePaths.length}');
    println('');
    println('  Ask questions: dart run tool/paperpal.dart ask $paperId "your question"');
    println('  Summarize:    dart run tool/paperpal.dart summarize $paperId');
    println('  Translate:    dart run tool/paperpal.dart translate $paperId');
    println('  Export:       dart run tool/paperpal.dart export bibtex $paperId');
  } catch (e) {
    printError('Import failed: $e');
  }
}

Future<void> _importUrl(String url, String apiKey, {String? title}) async {
  println('${bold("Importing URL")}: $url');
  final mineru = MineruApi(apiKey: apiKey);

  try {
    final result = await mineru.parseUrl(url);

    final resolvedTitle = title ?? url.split('/').last.replaceAll('.pdf', '').replaceAll(RegExp(r'%20|_'), ' ');
    final paperId = DateTime.now().millisecondsSinceEpoch.toString();

    final paper = Paper(
      id: paperId,
      title: resolvedTitle,
      source: 'arXiv',
      status: PaperStatus.parsed,
      importedAt: DateTime.now(),
    );

    final papers = loadPapersIndex();
    papers.add(paper.toJson());
    savePapersIndex(papers);
    savePaperMarkdown(paperId, result.markdown);

    printSuccess('Import complete: id=$paperId');
    println('  ${cyan("Markdown")}: ${result.markdown.length} chars');
  } catch (e) {
    printError('URL import failed: $e');
  }
}
