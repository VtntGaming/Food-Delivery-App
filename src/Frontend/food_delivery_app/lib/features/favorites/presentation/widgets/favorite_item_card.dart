import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/favorite_item.dart';

class FavoriteItemCard extends StatelessWidget {
  final FavoriteItem item;
  final VoidCallback onDelete;
  final VoidCallback onDetails;

  const FavoriteItemCard({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onDetails,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  color: AppTheme.disabledColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    cacheWidth: 150,
                    cacheHeight: 150,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppTheme.disabledColor,
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 32),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: AppTheme.titleMediumBold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Giá: ${item.price}đ',
                      style: AppTheme.bodyLargeBold,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < item.rating.toInt()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: AppTheme.accentColor,
                              size: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.rating.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: onDetails,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              onTap: onDelete,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: AppTheme.errorColor,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Xóa yêu thích',
                    style: AppTheme.errorStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
