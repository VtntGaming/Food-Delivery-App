import 'package:flutter/material.dart';

class AppColors {
  final Color primary;
  final Color scaffoldBackground;
  final Color card;
  final Color accentButton;
  final Color secondaryButton;
  final Color mutedText;

  AppColors({
    required this.primary,
    required this.scaffoldBackground,
    required this.card,
    required this.accentButton,
    required this.secondaryButton,
    required this.mutedText,
  });
}

class AppTextStyles {
  final TextStyle appBarTitle;
  final TextStyle title;
  final TextStyle value;
  final TextStyle buttonPrimary;

  AppTextStyles({
    required this.appBarTitle,
    required this.title,
    required this.value,
    required this.buttonPrimary,
  });
}

class AxisSpacing {
  final double horizontal;
  final double vertical;
  const AxisSpacing({required this.horizontal, required this.vertical});
}

class AppSpacing {
  final EdgeInsets screenPadding;
  final AxisSpacing xs;

  const AppSpacing({required this.screenPadding, required this.xs});
}

class AppTheme {
  final AppColors colors;
  final AppTextStyles textStyles;
  final AppSpacing spacing;

  AppTheme({required this.colors, required this.textStyles, required this.spacing});

  static AppTheme of(BuildContext context) {
    final theme = Theme.of(context);
    // Light default theme mapping - adjust to match design tokens
    final colors = AppColors(
      primary: const Color(0xFF08107A),
      scaffoldBackground: const Color(0xFFF6F6F6),
      card: Colors.white,
      accentButton: const Color(0xFF8B1F1F),
      secondaryButton: const Color(0xFF7A3A00),
      mutedText: Colors.grey.shade600,
    );

    final textStyles = AppTextStyles(
      appBarTitle: theme.textTheme.titleLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      title: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
      value: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
      buttonPrimary: theme.textTheme.labelLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
    );

    final spacing = const AppSpacing(screenPadding: EdgeInsets.all(16), xs: AxisSpacing(horizontal: 12, vertical: 12));

    return AppTheme(colors: colors, textStyles: textStyles, spacing: spacing);
  }
}
