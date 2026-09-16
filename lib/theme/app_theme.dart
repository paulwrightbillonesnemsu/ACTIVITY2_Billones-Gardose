import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colors pulled directly from the Figma CSS export.
class AppColors {
  static const primary = Color(0xFF3525CD);
  static const primaryLight = Color(0xFFEAEDFF);
  static const textDark = Color(0xFF1B1B24);
  static const textGray = Color(0xFF464555);
  static const textWhite = Color(0xFFFFFFFF);
  static const textWhiteSoft = Color(0xFFE7E7F4);
  static const border = Color(0xFFC7C4D8);
  static const navBg = Color(0xFFFCF8FF);

  // Dark-mode equivalents (kept close to the same hue/contrast ratios).
  static const darkBackground = Color(0xFF121218);
  static const darkSurface = Color(0xFF1E1E29);
  static const darkNavBg = Color(0xFF1B1B24);
  static const darkBorder = Color(0xFF3A3947);
}

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.textDark,
      displayColor: AppColors.textDark,
    ),
    dividerColor: AppColors.border,
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    dividerColor: AppColors.darkBorder,
  );
}
