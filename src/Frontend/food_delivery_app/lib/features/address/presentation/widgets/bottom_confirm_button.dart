import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/text_style_scaler.dart';

class BottomConfirmButton extends StatelessWidget {
  const BottomConfirmButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
  });

  final String label;
  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final scale = AppDimensions.scaleFor(context);

    return SizedBox(
      height: AppDimensions.s(context, AppDimensions.bottomButtonHeight),
      width: double.infinity,
      child: Material(
        color: enabled
            ? AppColors.primary
            : AppColors.primary.withValues(alpha: 0.55),
        child: InkWell(
          onTap: enabled ? onPressed : null,
          child: SafeArea(
            top: false,
            minimum: EdgeInsets.only(bottom: AppDimensions.s(context, 8)),
            child: Center(
              child: Text(
                label,
                style: scaleTextStyle(AppTextStyles.buttonPrimary, scale),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
