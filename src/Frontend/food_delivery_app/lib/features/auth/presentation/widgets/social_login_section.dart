import 'package:flutter/material.dart';

import 'package:food_delivery_app/core/constants/app_assets.dart';
import 'package:food_delivery_app/core/theme/app_colors.dart';
import 'package:food_delivery_app/core/theme/app_text_styles.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({
    super.key,
    this.onGooglePressed,
    this.onFacebookPressed,
  });

  final VoidCallback? onGooglePressed;
  final VoidCallback? onFacebookPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Đăng nhập bằng bên thứ 3', style: AppTextStyles.secondaryText),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialButton(
              assetPath: AppAssets.icGoogle,
              onPressed: onGooglePressed,
            ),
            const SizedBox(width: 50),
            _SocialButton(
              assetPath: AppAssets.icFacebook,
              onPressed: onFacebookPressed,
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.assetPath, this.onPressed});

  final String assetPath;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        color: AppColors.primary,
        padding: const EdgeInsets.all(4),
        child: Image.asset(assetPath, fit: BoxFit.cover),
      ),
    );
  }
}
