import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

final class AppTextStyles {
  AppTextStyles._();

  static TextStyle get inputHint => GoogleFonts.beVietnamPro(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: AppColors.hintText,
  );

  static TextStyle get inputText => GoogleFonts.beVietnamPro(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: AppColors.inputText,
  );

  static TextStyle get buttonText => GoogleFonts.beVietnamPro(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle get linkText => GoogleFonts.beVietnamPro(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );

  static TextStyle get secondaryText => GoogleFonts.beVietnamPro(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
  );

  static TextStyle get errorText => GoogleFonts.beVietnamPro(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
  );

  static TextStyle get fieldErrorText => GoogleFonts.beVietnamPro(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
  );

  static TextStyle get titleOnPrimary => GoogleFonts.beVietnamPro(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );

  static TextStyle get buttonPrimary => GoogleFonts.beVietnamPro(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnPrimary,
    height: 1.3,
  );

  static TextStyle get searchHint => GoogleFonts.beVietnamPro(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textHint,
    height: 1.2,
  );

  static TextStyle get contactName => GoogleFonts.beVietnamPro(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get contactPhone => GoogleFonts.beVietnamPro(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    height: 1.2,
  );

  static TextStyle get addressLine => GoogleFonts.beVietnamPro(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    height: 1.2,
  );

  static TextStyle get addNewAddress => GoogleFonts.beVietnamPro(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: const Color(0x91000000),
    height: 1.2,
  );
}
