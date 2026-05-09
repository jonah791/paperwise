import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

@freezed
sealed class AppError with _$AppError {
  const factory AppError.network({
    int? statusCode,
    required String message,
    @Default(true) bool retryable,
  }) = NetworkError;

  const factory AppError.api({
    required String code,
    required String message,
  }) = ApiError;

  const factory AppError.parse({
    required int failedBatches,
    required int totalBatches,
  }) = ParseError;

  const factory AppError.config({
    required String message,
  }) = ConfigError;

  const factory AppError.unknown({
    required String message,
  }) = UnknownError;
}
