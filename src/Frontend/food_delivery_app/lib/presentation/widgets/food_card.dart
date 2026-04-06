import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_spacing.dart';
import '../../data/models/food_model.dart';

/// A card widget displaying a food item with image, name, and price.
class FoodCard extends StatelessWidget {
  final FoodModel food;
  final VoidCallback? onTap;

  const FoodCard({
    super.key,
    required this.food,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSpacing.foodCardHeight,
        decoration: BoxDecoration(
          borderRadius: AppRadius.cardRadius,
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: AppRadius.cardRadius,
          child: Stack(
            children: [
              // Food image
              Positioned.fill(
                child: Image.network(
                  food.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.cardBackground,
                    child: const Icon(
                      Icons.restaurant,
                      color: AppColors.textSecondary,
                      size: 32,
                    ),
                  ),
                ),
              ),
              // Gradient overlay for text readability
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 50,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                    ),
                  ),
                ),
              ),
              // Food name
              Positioned(
                left: AppSpacing.xs,
                bottom: 20,
                right: AppSpacing.xxs,
                child: Text(
                  food.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Price
              Positioned(
                left: AppSpacing.xs,
                bottom: AppSpacing.xs,
                child: Text(
                  food.price,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
