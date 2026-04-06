import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_spacing.dart';
import '../../data/models/food_model.dart';

/// A card for displaying food items on the restaurant detail screen, with an add button.
class MenuItemCard extends StatelessWidget {
  final FoodModel food;
  final VoidCallback? onAdd;

  const MenuItemCard({
    super.key,
    required this.food,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Food image
        Container(
          height: 161,
          width: 190,
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
            child: Image.network(
              food.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.cardBackground,
                child: const Icon(
                  Icons.restaurant,
                  color: AppColors.textSecondary,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xl),
        // Food details column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xs),
              Text(
                food.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                food.price,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              // Add button
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: onAdd,
                  child: Container(
                    width: AppSpacing.addButtonSize,
                    height: AppSpacing.addButtonSize,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
