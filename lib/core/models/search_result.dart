import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result.freezed.dart';

@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    required String title,
    required List<String> authors,
    required int year,
    required String abstract,
    required String pdfUrl,
    required String source,
    @Default('') String doi,
    @Default(0) int citationCount,
  }) = _SearchResult;
}
