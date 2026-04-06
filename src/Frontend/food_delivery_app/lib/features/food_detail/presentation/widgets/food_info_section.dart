import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/food_item.dart';

class FoodInfoSection extends StatelessWidget {
  final FoodItem foodItem;

  const FoodInfoSection({
    super.key,
    required this.foodItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                foodItem.name,
                style: AppTheme.titleLargeBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${foodItem.price}đ',
              style: AppTheme.titleLargeBold,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _RatingStars(rating: foodItem.rating),
            const SizedBox(width: 8),
            Text(
              '${foodItem.rating} • ${foodItem.reviewCount} đánh giá',
              style: AppTheme.ratingStyle,
            ),
          ],
        ),
      ],
    );
  }
}

class _RatingStars extends StatelessWidget {
  final double rating;

  const _RatingStars({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating.toInt() ? Icons.star : Icons.star_border,
          color: AppTheme.accentColor,
          size: 16,
        ),
      ),
    );
  }
}
