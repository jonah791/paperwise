import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

final _log = Logger('MineruApi');

class MineruApi {
  final String baseUrl;
  final String? apiKey;
  late final Dio _dio;

  MineruApi({required this.baseUrl, this.apiKey}) {
    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 300),
      sendTimeout: const Duration(seconds: 120),
      headers: {
        if (apiKey != null && apiKey!.isNotEmpty)
          'Authorization': 'Bearer $apiKey',
      },
    ));
    _dio.interceptors.add(_HttpsInterceptor());
  }

  Future<String> parsePdf({
    required File pdfFile,
    int startPage = 0,
    int endPage = 99999,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        pdfFile.path,
        filename: pdfFile.path.split(Platform.pathSeparator).last,
      ),
      'start_page_id': startPage.toString(),
      'end_page_id': endPage.toString(),
    });

    String url;
    if (baseUrl.endsWith('/file_parse')) {
      url = baseUrl;
    } else {
      url = '$baseUrl/file_parse';
    }

    try {
      final response = await _dio.post(url, data: formData);
      _log.info('parsePdf: pages=$startPage-$endPage, status=${response.statusCode}');
      return response.data.toString();
    } on DioException catch (e) {
      _log.warning('parsePdf failed: pages=$startPage-$endPage, '
          '${e.response?.statusCode} ${e.message}');
      rethrow;
    }
  }

  Future<String> parsePdfWithZip({
    required File pdfFile,
    int startPage = 0,
    int endPage = 99999,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        pdfFile.path,
        filename: pdfFile.path.split(Platform.pathSeparator).last,
      ),
      'start_page_id': startPage.toString(),
      'end_page_id': endPage.toString(),
    });

    final url = baseUrl.endsWith('/file_parse')
        ? baseUrl
        : '$baseUrl/file_parse';

    try {
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(responseType: ResponseType.bytes),
      );
      _log.info('parsePdfWithZip: pages=$startPage-$endPage, '
          'size=${response.data.length} bytes');
      return String.fromCharCodes(response.data);
    } on DioException catch (e) {
      _log.warning('parsePdfWithZip failed: pages=$startPage-$endPage, '
          '${e.response?.statusCode} ${e.message}');
      rethrow;
    }
  }
}

class _HttpsInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final host = options.uri.host;
    if (!host.contains('localhost') && options.uri.scheme != 'https') {
      handler.reject(DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
        error: 'HTTPS is required for security',
      ));
      return;
    }
    handler.next(options);
  }
}
