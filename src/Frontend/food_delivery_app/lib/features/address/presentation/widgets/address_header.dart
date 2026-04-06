import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/text_style_scaler.dart';

class AddressHeader extends StatelessWidget {
  const AddressHeader({super.key, required this.title, this.onBack});

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final scale = AppDimensions.scaleFor(context);
    final horizontal = AppDimensions.s(
      context,
      AppDimensions.horizontalPadding,
    );

    return Container(
      height: AppDimensions.s(context, AppDimensions.headerHeight),
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontal,
        AppDimensions.s(context, 34),
        horizontal,
        AppDimensions.s(context, 12),
      ),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.textOnPrimary,
              minimumSize: Size(
                AppDimensions.s(context, 36),
                AppDimensions.s(context, 36),
              ),
              padding: EdgeInsets.zero,
            ),
            icon: Icon(Icons.arrow_back, size: AppDimensions.s(context, 34)),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: AppDimensions.s(context, 36)),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: scaleTextStyle(AppTextStyles.titleOnPrimary, scale),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
