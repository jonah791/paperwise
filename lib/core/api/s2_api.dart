import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import '../models/search_result.dart';

final _log = Logger('S2Api');

class S2Api {
  final Dio _dio;

  S2Api() : _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    baseUrl: 'https://api.semanticscholar.org/graph/v1',
  ));

  Future<List<SearchResult>> search(String query, {int limit = 10}) async {
    try {
      final response = await _dio.get(
        '/paper/search',
        queryParameters: {
          'query': query,
          'limit': limit,
          'fields': 'title,authors,year,abstract,externalIds,openAccessPdf,citationCount',
        },
      );

      final data = response.data;
      if (data == null || data['data'] == null) return [];

      final results = <SearchResult>[];
      for (final paper in data['data']) {
        final authors = (paper['authors'] as List?)
                ?.map((a) => a['name'] as String? ?? '')
                .where((n) => n.isNotEmpty)
                .toList() ??
            [];

        final pdfUrl = paper['openAccessPdf']?['url'] as String? ?? '';
        final externalIds = paper['externalIds'] as Map<String, dynamic>?;

        results.add(SearchResult(
          title: paper['title'] as String? ?? '',
          authors: authors,
          year: paper['year'] as int? ?? 0,
          abstract: (paper['abstract'] as String? ?? ''),
          pdfUrl: pdfUrl,
          doi: externalIds?['DOI'] as String? ?? '',
          source: 'Semantic Scholar',
          citationCount: paper['citationCount'] as int? ?? 0,
        ));
      }

      _log.info('search: "$query" → ${results.length} results from S2');
      return results;
    } on DioException catch (e) {
      _log.warning('search failed: "$query" → ${e.message}');
      return [];
    }
  }
}
