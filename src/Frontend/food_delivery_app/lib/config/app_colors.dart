import 'package:flutter/material.dart';

/// App color palette sourced from Figma designs.
abstract class AppColors {
  // Primary
  static const Color primary = Color(0xFF00A6FF);
  static const Color primaryOverlay = Color(0xA300A6FF); // 64% opacity

  // Backgrounds
  static const Color background = Color(0xFFF5F7FA);
  static const Color cardBackground = Color(0xFFF1F1F1);
  static const Color white = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF666666);

  // Shadows
  static const Color shadowColor = Color(0x40000000); // 25% black
  static const Color shadowSoft = Color(0x1A000000); // 10% black

  // Dividers
  static const Color border = Color(0xFF000000);
}
