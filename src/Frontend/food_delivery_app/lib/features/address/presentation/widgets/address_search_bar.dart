import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/text_style_scaler.dart';

class AddressSearchBar extends StatelessWidget {
  const AddressSearchBar({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scale = AppDimensions.scaleFor(context);

    return Container(
      height: AppDimensions.s(context, AppDimensions.searchBarHeight),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.s(context, 24)),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(
          AppDimensions.s(context, AppDimensions.borderRadius),
        ),
      ),
      child: Text(
        label,
        style: scaleTextStyle(AppTextStyles.searchHint, scale),
      ),
    );
  }
}
