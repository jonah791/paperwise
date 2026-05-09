import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:logging/logging.dart';

final _log = Logger('PageCounter');

class PageCounter {
  static Future<int> getPageCount(String pdfPath) async {
    try {
      final bytes = await File(pdfPath).readAsBytes();
      final document = PdfDocument(inputBytes: bytes);
      final count = document.pages.count;
      document.dispose();
      _log.info('getPageCount: $pdfPath → $count pages');
      return count;
    } catch (e) {
      _log.warning('getPageCount failed: $pdfPath → $e');
      return 0;
    }
  }
}
