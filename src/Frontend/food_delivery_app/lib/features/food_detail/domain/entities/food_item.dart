import './review.dart';

import 'review.dart';

class FoodItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double rating;
  final int reviewCount;
  final String description;
  final List<Review> reviews;

  FoodItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.reviews,
  });
}
