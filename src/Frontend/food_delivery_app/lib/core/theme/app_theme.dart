import 'package:flutter/material.dart';

import 'app_colors.dart';

final class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.scaffoldBackground,
      ),
      splashFactory: InkRipple.splashFactory,
      visualDensity: VisualDensity.standard,
    );
  }
}
