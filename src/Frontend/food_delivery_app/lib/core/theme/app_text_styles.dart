import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
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
}
