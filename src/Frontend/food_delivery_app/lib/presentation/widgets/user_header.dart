import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_spacing.dart';

/// Displays the user's avatar and name at the top of the home screen.
class UserHeader extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final VoidCallback? onAvatarTap;

  const UserHeader({
    super.key,
    required this.userName,
    required this.avatarUrl,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onAvatarTap,
          child: Container(
            width: AppSpacing.avatarSize,
            height: AppSpacing.avatarSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.network(
                avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.primaryOverlay,
                  child: const Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            userName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
