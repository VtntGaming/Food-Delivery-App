import 'package:flutter/material.dart';
import '../../domain/entities/user_review.dart';
import '../widgets/reviews_app_bar.dart';
import '../widgets/user_review_card.dart';

class ReviewsScreen extends StatefulWidget {
  final List<UserReview> reviews;

  const ReviewsScreen({
    super.key,
    required this.reviews,
  });

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  late List<UserReview> _reviews;

  @override
  void initState() {
    super.initState();
    _reviews = List.from(widget.reviews);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ReviewsAppBar(),
      body: _reviews.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: _reviews.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return UserReviewCard(
                  review: _reviews[index],
                  onEdit: () => _handleEditReview(index),
                  onDelete: () => _handleDeleteReview(index),
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
            Icons.rate_review_outlined,
            size: 64,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Bạn chưa viết đánh giá nào',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _handleEditReview(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Chỉnh sửa: ${_reviews[index].restaurantName}')),
    );
  }

  void _handleDeleteReview(int index) {
    final reviewName = _reviews[index].restaurantName;
    setState(() {
      _reviews.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã xóa đánh giá về $reviewName')),
    );
  }
}
