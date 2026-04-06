import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF003366);
  static const Color primaryDark = Color(0xFF001F40);
  static const Color accentColor = Color.fromARGB(204, 0, 0, 128);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(0xFFF5F5F5);
  static const Color errorColor = Color(0xFFFF0000);
  static const Color textPrimary = Color(0xFF0C0C0D);
  static const Color textSecondary = Color(0xFF333333);
  static const Color textHint = Color(0xFF595959);
  static const Color dividerColor = Color(0xFFD1D5DB);
  static const Color cardBackground = Color(0xFFE8E8E8);

  // Spacing
  static const double spacingXXS = 4.0;
  static const double spacingXS = 8.0;
  static const double spacingS = 12.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;

  // Icon Sizes
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;

  // Header height
  static const double headerHeight = 108.0;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _titleLarge,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      textTheme: TextTheme(
        headlineSmall: _headlineSmall,
        titleLarge: _titleLarge,
        titleMedium: _titleMedium,
        bodyLarge: _bodyLarge,
        bodyMedium: _bodyMedium,
        bodySmall: _bodySmall,
        labelLarge: _labelLarge,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingM,
            vertical: spacingS,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusM),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingM,
            vertical: spacingS,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusM),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingM,
          vertical: spacingS,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusM),
          borderSide: const BorderSide(color: dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusM),
          borderSide: const BorderSide(color: dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusM),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
      ),
      dividerColor: dividerColor,
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
        space: 1,
      ),
    );
  }

  // Text Styles
  static const TextStyle _headlineSmall = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    fontFamily: 'Inter',
    height: 1.0,
  );

  static const TextStyle _titleLarge = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: 'Inter',
    height: 1.0,
  );

  static const TextStyle _titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textSecondary,
    fontFamily: 'BeVietnamPro',
    height: 1.2,
  );

  static const TextStyle _bodyLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    fontFamily: 'BeVietnamPro',
    height: 1.2,
  );

  static const TextStyle _bodyMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    fontFamily: 'Inter',
    height: 1.4,
  );

  static const TextStyle _bodySmall = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: textHint,
    fontFamily: 'Inter',
    height: 1.4,
  );

  static const TextStyle _labelLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textSecondary,
    fontFamily: 'Inter',
    height: 1.0,
  );

  // Text style getters for reuse
  static TextStyle get headerTitle => _headlineSmall;
  static TextStyle get tabLabel => _titleMedium;
  static TextStyle get orderLabel => _bodyLarge;
  static TextStyle get priceText => _bodyMedium;
  static TextStyle get hintText => _bodySmall;
}
