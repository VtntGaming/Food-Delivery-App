import 'package:flutter/material.dart';
import '../../domain/entities/favorite_item.dart';
import '../widgets/favorites_app_bar.dart';
import '../widgets/favorite_item_card.dart';

class FavoritesScreen extends StatefulWidget {
  final List<FavoriteItem> favorites;

  const FavoritesScreen({
    super.key,
    required this.favorites,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<FavoriteItem> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = List.from(widget.favorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const FavoritesAppBar(),
      body: _favorites.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: _favorites.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return FavoriteItemCard(
                  item: _favorites[index],
                  onDelete: () => _handleDeleteFavorite(index),
                  onDetails: () => _handleViewDetails(_favorites[index]),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Chưa có item yêu thích',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _handleDeleteFavorite(int index) {
    setState(() {
      _favorites.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã xóa khỏi yêu thích')),
    );
  }

  void _handleViewDetails(FavoriteItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Xem chi tiết: ${item.name}')),
    );
  }
}
