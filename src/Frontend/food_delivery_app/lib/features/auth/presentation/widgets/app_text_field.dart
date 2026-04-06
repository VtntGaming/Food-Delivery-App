import 'package:flutter/material.dart';

import 'package:food_delivery_app/core/theme/app_colors.dart';
import 'package:food_delivery_app/core/theme/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.errorText,
    this.keyboardType,
  });

  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? errorText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (errorText != null) ...[
          Text(errorText!, style: AppTextStyles.fieldErrorText),
          const SizedBox(height: 3),
        ],
        Container(
          decoration: BoxDecoration(color: AppColors.primaryWithOpacity),
          padding: const EdgeInsets.all(5),
          child: Container(
            color: AppColors.white,
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: AppTextStyles.inputText,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.inputHint,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
