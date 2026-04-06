import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/text_style_scaler.dart';

class AddNewAddressTile extends StatelessWidget {
  const AddNewAddressTile({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scale = AppDimensions.scaleFor(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.s(context, 8)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.s(context, 6),
          vertical: AppDimensions.s(context, 6),
        ),
        child: Text(
          label,
          style: scaleTextStyle(AppTextStyles.addNewAddress, scale),
        ),
      ),
    );
  }
}
