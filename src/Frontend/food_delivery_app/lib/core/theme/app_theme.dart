import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      error: AppColors.error,
      surface: AppColors.background,
    ),
    textTheme: GoogleFonts.beVietnamProTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(),
        minimumSize: const Size(150, 50),
        textStyle: GoogleFonts.beVietnamPro(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
