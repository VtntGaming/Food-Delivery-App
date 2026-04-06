import 'package:flutter/material.dart';

import 'app_colors.dart';

final class AppTextStyles {
  AppTextStyles._();

  static const TextStyle titleOnPrimary = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );

  static const TextStyle buttonPrimary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnPrimary,
    height: 1.3,
  );

  static const TextStyle searchHint = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textHint,
    height: 1.2,
  );

  static const TextStyle contactName = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle contactPhone = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    height: 1.2,
  );

  static const TextStyle addressLine = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    height: 1.2,
  );

  static const TextStyle addNewAddress = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Color(0x91000000),
    height: 1.2,
  );
}
