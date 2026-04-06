import 'package:flutter/material.dart';

import 'package:food_delivery_app/core/constants/app_assets.dart';
import 'package:food_delivery_app/core/theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.showBorder = true});

  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final logoSize = screenWidth * 0.62;

    return Container(
      width: logoSize,
      height: logoSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        border: showBorder
            ? Border.all(color: AppColors.primary, width: 3.5)
            : null,
      ),
      child: ClipOval(
        child: Image.asset(AppAssets.logoNomNom, fit: BoxFit.cover),
      ),
    );
  }
}
