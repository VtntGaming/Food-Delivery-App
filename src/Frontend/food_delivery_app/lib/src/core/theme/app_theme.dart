import 'package:flutter/material.dart';

/// Centralized theme, colors, text styles and spacing used across the app.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF000080); // deep navy from design
  static const Color background = Colors.white;
  static const Color card = Color(0xFFD9D9D9);
  static const Color text = Color(0xFF000000);
  static const Color buttonText = Colors.white;
}

class AppSpacing {
  AppSpacing._();

  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double cardVertical = 18.0;
}

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle titleBold = TextStyle(
    fontFamily: 'BeVietnamPro',
    fontWeight: FontWeight.w700,
    fontSize: 30,
    color: AppColors.buttonText,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'BeVietnamPro',
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.text,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: AppColors.text,
  );

  static const TextStyle buttonLabel = TextStyle(
    fontFamily: 'BeVietnamPro',
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.buttonText,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData light() => ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: const TextTheme(
          titleLarge: AppTextStyles.titleBold,
          bodyLarge: AppTextStyles.cardSubtitle,
          bodyMedium: AppTextStyles.cardSubtitle,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
