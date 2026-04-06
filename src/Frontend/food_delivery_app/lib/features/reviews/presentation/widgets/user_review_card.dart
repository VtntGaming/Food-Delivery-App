import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/user_review.dart';

class UserReviewCard extends StatelessWidget {
  final UserReview review;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const UserReviewCard({
    super.key,
    required this.review,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      padding: const EdgeInsets.all(AppTheme.paddings16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.restaurantName,
            style: AppTheme.bodyLargeBold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < review.rating.toInt() ? Icons.star : Icons.star_border,
                color: AppTheme.accentColor,
                size: 14,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            review.comment,
            style: AppTheme.bodySmallRegular,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: onDelete,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: AppTheme.errorColor,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Xóa',
                            style: AppTheme.errorStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: onEdit,
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: AppTheme.errorColor,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Sửa',
                            style: AppTheme.errorStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                review.date,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF0C0C0D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
