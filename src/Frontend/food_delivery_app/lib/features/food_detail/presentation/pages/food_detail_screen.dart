import 'package:flutter/material.dart';
import '../../domain/entities/food_item.dart';
import '../widgets/food_detail_header.dart';
import '../widgets/food_info_section.dart';
import '../widgets/description_section.dart';
import '../widgets/reviews_section.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodItem foodItem;

  const FoodDetailScreen({
    super.key,
    required this.foodItem,
  });

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FoodDetailHeader(
              foodItem: widget.foodItem,
              onFavoritePressed: _handleFavoritePressed,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  FoodInfoSection(foodItem: widget.foodItem),
                  const SizedBox(height: 24),
                  DescriptionSection(description: widget.foodItem.description),
                  const SizedBox(height: 24),
                  ReviewsSection(reviews: widget.foodItem.reviews),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleFavoritePressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to favorites')),
    );
  }
}
