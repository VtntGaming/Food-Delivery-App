import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class MenuItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MenuItemCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imageUrl,
              width: 90,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppSpacing.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.cardTitle),
                const SizedBox(height: AppSpacing.small),
                Text('Giá: $price', style: AppTextStyles.cardSubtitle),
                const SizedBox(height: AppSpacing.small),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onEdit,
                      child: Row(
                        children: const [
                          Icon(Icons.edit_outlined, size: 18),
                          SizedBox(width: 6),
                          Text('Sửa', style: AppTextStyles.cardSubtitle),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: onDelete,
                      child: Row(
                        children: const [
                          Icon(Icons.delete_outline, size: 18),
                          SizedBox(width: 6),
                          Text('Xóa', style: AppTextStyles.cardSubtitle),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
