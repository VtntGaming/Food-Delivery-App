import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/text_style_scaler.dart';

class AddressContactRow extends StatelessWidget {
  const AddressContactRow({
    super.key,
    required this.name,
    required this.phone,
    this.isSelected = false,
  });

  final String name;
  final String phone;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final scale = AppDimensions.scaleFor(context);
    final rowGap = AppDimensions.s(context, 14);

    return Row(
      children: [
        Expanded(
          child: _AddressInfoCard(
            text: name,
            textStyle: scaleTextStyle(AppTextStyles.contactName, scale),
            isSelected: isSelected,
            alignment: Alignment.centerLeft,
          ),
        ),
        SizedBox(width: rowGap),
        Expanded(
          child: _AddressInfoCard(
            text: phone,
            textStyle: scaleTextStyle(AppTextStyles.contactPhone, scale),
            isSelected: false,
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
    );
  }
}

class _AddressInfoCard extends StatelessWidget {
  const _AddressInfoCard({
    required this.text,
    required this.textStyle,
    required this.isSelected,
    required this.alignment,
  });

  final String text;
  final TextStyle textStyle;
  final bool isSelected;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.s(context, AppDimensions.infoCardHeight),
      alignment: alignment,
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(
          AppDimensions.s(context, AppDimensions.borderRadius),
        ),
        border: isSelected
            ? Border.all(
                width: AppDimensions.s(context, 1.4),
                color: AppColors.primary,
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.s(context, 10)),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textStyle,
        ),
      ),
    );
  }
}
