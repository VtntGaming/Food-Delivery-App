import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/food_item.dart';

class FoodDetailHeader extends StatelessWidget {
  final FoodItem foodItem;
  final VoidCallback onFavoritePressed;

  const FoodDetailHeader({
    super.key,
    required this.foodItem,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          foodItem.imageUrl,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
          cacheWidth: 500,
          cacheHeight: 300,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: double.infinity,
              height: 300,
              color: AppTheme.disabledColor,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: double.infinity,
              height: 300,
              color: AppTheme.disabledColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.image_not_supported, size: 48),
                    const SizedBox(height: 8),
                    Text(
                      'Không thể tải hình ảnh',
                      style: AppTheme.bodySmallRegular,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Positioned(
          top: 16,
          left: 16,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: GestureDetector(
            onTap: onFavoritePressed,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.favorite_border,
                color: AppTheme.errorColor,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
              ),
            ),
            height: 60,
          ),
        ),
      ],
    );
  }
}
