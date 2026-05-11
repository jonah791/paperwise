import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/models/config.dart';

extension AppThemeModeX on AppThemeMode {
  ThemeMode toFlutterThemeMode() {
    return switch (this) {
      AppThemeMode.system => ThemeMode.system,
      AppThemeMode.light => ThemeMode.light,
      AppThemeMode.dark => ThemeMode.dark,
    };
  }
}

class AppTheme {
  AppTheme._();

  static ColorScheme _darkColors() {
    return const ColorScheme.dark(
      primary: Color(0xFFE8B84B),
      onPrimary: Color(0xFF1A1025),
      secondary: Color(0xFF9B6DF7),
      onSecondary: Color(0xFFFFFFFF),
      surface: Color(0xFF120C1F),
      onSurface: Color(0xFFEDE4D8),
    );
  }

  static ColorScheme _lightColors() {
    return const ColorScheme.light(
      primary: Color(0xFFC28A2C),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF6D28D9),
      onSecondary: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1A1025),
    );
  }

  static TextTheme _textTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final Color textColor =
        isDark ? const Color(0xFFEDE4D8) : const Color(0xFF1A1025);

    return TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineLarge: GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleLarge: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleMedium: GoogleFonts.playfairDisplay(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleSmall: GoogleFonts.playfairDisplay(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }

  static CardThemeData _cardTheme(Brightness brightness) {
    final Color borderColor = brightness == Brightness.dark
        ? const Color(0xFFE8B84B).withValues(alpha: 0.1)
        : const Color(0xFFC28A2C).withValues(alpha: 0.1);

    return CardThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor),
      ),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
    );
  }

  static InputDecorationTheme _inputTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final Color fillColor = isDark ? const Color(0xFF120C1F) : const Color(0xFFF5F0EB);
    final Color borderColor = isDark
        ? const Color(0xFFE8B84B).withValues(alpha: 0.3)
        : const Color(0xFFC28A2C).withValues(alpha: 0.3);
    final Color focusedColor =
        isDark ? const Color(0xFFE8B84B) : const Color(0xFFC28A2C);

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: focusedColor, width: 2),
      ),
    );
  }

  static ElevatedButtonThemeData _buttonTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final Color gold =
        isDark ? const Color(0xFFE8B84B) : const Color(0xFFC28A2C);
    final Color onGold =
        isDark ? const Color(0xFF1A1025) : const Color(0xFFFFFFFF);

    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: gold,
        foregroundColor: onGold,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static ThemeData _base(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final ColorScheme colors = isDark ? _darkColors() : _lightColors();
    final Color scaffoldBg =
        isDark ? const Color(0xFF07050D) : const Color(0xFFFFFBF3);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colors,
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: _textTheme(brightness),
      cardTheme: _cardTheme(brightness),
      inputDecorationTheme: _inputTheme(brightness),
      elevatedButtonTheme: _buttonTheme(brightness),
      dividerTheme: DividerThemeData(
        color: colors.onSurface.withValues(alpha: 0.12),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: scaffoldBg,
        foregroundColor: colors.onSurface,
      ),
      navigationRailTheme: const NavigationRailThemeData(
        labelType: NavigationRailLabelType.all,
      ),
    );
  }

  static ThemeData get light => _base(Brightness.light);
  static ThemeData get dark => _base(Brightness.dark);
}
