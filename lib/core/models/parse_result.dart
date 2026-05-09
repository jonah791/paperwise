import 'package:freezed_annotation/freezed_annotation.dart';

part 'parse_result.freezed.dart';

@freezed
class ParseResult with _$ParseResult {
  const factory ParseResult({
    required String markdown,
    required String title,
    @Default([]) List<String> imagePaths,
    @Default('') String contentListJson,
    @Default(0) int startPage,
    @Default(0) int endPage,
  }) = _ParseResult;
}

@freezed
class ParseProgress with _$ParseProgress {
  const factory ParseProgress({
    required int currentBatch,
    required int totalBatches,
    @Default(0) int currentPage,
    @Default(0) int totalPages,
  }) = _ParseProgress;
}
