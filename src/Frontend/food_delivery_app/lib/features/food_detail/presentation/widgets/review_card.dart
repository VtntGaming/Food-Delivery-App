import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.borderColor),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
      ),
      padding: const EdgeInsets.all(AppTheme.paddings16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < review.rating.toInt() ? Icons.star : Icons.star_border,
                color: AppTheme.accentColor,
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            review.comment,
            style: AppTheme.bodySmallRegular,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            review.authorName,
            style: AppTheme.bodyMediumRegular,
          ),
        ],
      ),
    );
  }
}
