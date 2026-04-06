import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/theme.dart';
import '../common/app_widgets.dart';

class FavoriteModel {
  final String id;
  final String name;
  final String imageUrl;
  final String category;

  FavoriteModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
  });
}

class FavoriteItemCard extends StatelessWidget {
  final FavoriteModel item;
  final VoidCallback? onDelete;

  const FavoriteItemCard({
    Key? key,
    required this.item,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radiusLg),
                topRight: Radius.circular(AppTheme.radiusLg),
              ),
            ),
            child: item.imageUrl.isNotEmpty
                ? Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppTheme.textLightGrey,
                        size: AppTheme.iconMd,
                      ),
                    ),
                  )
                : Center(
                    child: Icon(
                      Icons.image_outlined,
                      color: AppTheme.textLightGrey,
                      size: AppTheme.iconMd,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppTheme.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppTheme.xs),
                Text(
                  item.category,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textGrey,
                      ),
                ),
                const SizedBox(height: AppTheme.md),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: 'Xóa',
                    onPressed: onDelete ?? () {},
                    backgroundColor: AppTheme.accentRed,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.sm,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritesGridView extends StatelessWidget {
  final List<FavoriteModel> items;
  final VoidCallback? onDeleteFavorite;
  final int crossAxisCount;

  const FavoritesGridView({
    Key? key,
    required this.items,
    this.onDeleteFavorite,
    this.crossAxisCount = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const AppEmptyState(
        message: 'Không có danh mục yêu thích',
        icon: Icons.favorite_border_outlined,
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: AppTheme.md,
        crossAxisSpacing: AppTheme.md,
        childAspectRatio: 0.65, // Giảm tỉ lệ để tăng chiều cao cho card, tránh overflow
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return FavoriteItemCard(
          item: items[index],
          onDelete: onDeleteFavorite,
        );
      },
    );
  }
}

class FavoritesSection extends StatelessWidget {
  final List<FavoriteModel> items;
  final VoidCallback? onDeleteFavorite;
  final int crossAxisCount;

  const FavoritesSection({
    Key? key,
    required this.items,
    this.onDeleteFavorite,
    this.crossAxisCount = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FavoritesGridView(
      items: items,
      onDeleteFavorite: onDeleteFavorite,
      crossAxisCount: crossAxisCount,
    );
  }
}
