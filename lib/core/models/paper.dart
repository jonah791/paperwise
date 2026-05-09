import 'package:freezed_annotation/freezed_annotation.dart';

part 'paper.freezed.dart';

@freezed
class Paper with _$Paper {
  const factory Paper({
    required String id,
    required String title,
    required List<String> authors,
    required int year,
    required String source,
    @Default('') String abstract,
    @Default('') String pdfPath,
    @Default('') String markdownPath,
    @Default('') String translatedPath,
    @Default('') String doi,
    @Default(PaperStatus.importing) PaperStatus status,
    @Default(0) int pageCount,
    @Default(0) DateTime? importedAt,
    @Default(0) DateTime? lastReadAt,
    @Default([]) List<String> tags,
  }) = _Paper;
}

enum PaperStatus {
  importing,
  downloading,
  parsing,
  parsed,
  translating,
  translated,
  error,
}
