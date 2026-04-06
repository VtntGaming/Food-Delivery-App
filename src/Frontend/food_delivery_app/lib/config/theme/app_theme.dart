import 'package:flutter/material.dart';

class AppTheme {
  static const double paddings16 = 16.0;
  static const double paddings12 = 12.0;
  static const double paddings8 = 8.0;
  static const double paddings4 = 4.0;

  static const double radius8 = 8.0;
  static const double radius12 = 12.0;

  static const Color primaryColor = Colors.deepPurple;
  static const Color accentColor = Color(0xFFFFA000);
  static const Color backgroundColor = Colors.white;
  static const Color errorColor = Color(0xFFFF4D4F);
  static const Color darkTextColor = Color(0xFF333333);
  static const Color lightTextColor = Color(0xFF555555);
  static const Color borderColor = Color(0xFFD1D5DB);
  static const Color disabledColor = Color(0xFFF5F5F5);
  static const Color darkHeaderColor = Color(0xFF000080);

  static const TextStyle titleLargeBold = TextStyle(
    fontFamily: 'BeVietnamPro',
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle titleMediumBold = TextStyle(
    fontFamily: 'BeVietnamPro',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle titleSmallBold = TextStyle(
    fontFamily: 'BeVietnamPro',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyLargeBold = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1F1F1F),
  );

  static const TextStyle bodyLargeRegular = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: Color(0xFF555555),
  );

  static const TextStyle bodyMediumRegular = TextStyle(
    fontFamily: 'BeVietnamPro',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle bodySmallRegular = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Color(0xFF333333),
  );

  static const TextStyle ratingStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: Color(0xFFFFA000),
  );

  static const TextStyle linkStyle = TextStyle(
    fontFamily: 'BeVietnamPro',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle errorStyle = TextStyle(
    fontFamily: 'BeVietnamPro',
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: Color(0xFFFF4D4F),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Inter',
      appBarTheme: AppBarTheme(
        backgroundColor: darkHeaderColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          fontFamily: 'BeVietnamPro',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: titleLargeBold,
        displayMedium: titleMediumBold,
        displaySmall: titleSmallBold,
        bodyLarge: bodyLargeRegular,
        bodyMedium: bodyMediumRegular,
        bodySmall: bodySmallRegular,
      ),
    );
  }
}
