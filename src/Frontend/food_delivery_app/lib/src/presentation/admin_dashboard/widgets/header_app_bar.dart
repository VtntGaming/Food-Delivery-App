import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class HeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const HeaderAppBar({Key? key, required this.title, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = 112.0;
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: onBack ?? () => Navigator.maybePop(context),
              ),
            ),
            Center(
              child: Text(
                title,
                style: AppTextStyles.titleBold,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(112);
}
