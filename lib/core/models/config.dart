import 'package:flutter/material.dart' as m;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

enum AppThemeMode { system, light, dark }

extension AppThemeModeX on AppThemeMode {
  m.ThemeMode toFlutterThemeMode() {
    return switch (this) {
      AppThemeMode.system => m.ThemeMode.system,
      AppThemeMode.light => m.ThemeMode.light,
      AppThemeMode.dark => m.ThemeMode.dark,
    };
  }

  static AppThemeMode fromFlutter(m.ThemeMode mode) {
    return switch (mode) {
      m.ThemeMode.system => AppThemeMode.system,
      m.ThemeMode.light => AppThemeMode.light,
      m.ThemeMode.dark => AppThemeMode.dark,
    };
  }
}

@freezed
class AppConfig with _$AppConfig {
  const factory AppConfig({
    @Default('deepseek') String defaultProvider,
    @Default('deepseek-v4-flash') String llmModel,
    @Default('https://api.deepseek.com') String llmApiBase,
    @Default('') String mineruApiEndpoint,
    @Default('') String mineruApiKey,
    @Default(true) bool autoTranslate,
    @Default(false) bool forceDarkMode,
    @Default(AppThemeMode.system) AppThemeMode themeMode,
    @Default(16.0) double fontSize,
    @Default(50) int batchSize,
    @Default(7) int logRetentionDays,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
}
