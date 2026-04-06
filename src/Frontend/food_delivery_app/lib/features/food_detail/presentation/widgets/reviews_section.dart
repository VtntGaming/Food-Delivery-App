import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/review.dart';
import 'review_card.dart';

class ReviewsSection extends StatelessWidget {
  final List<Review> reviews;

  const ReviewsSection({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Đánh giá',
              style: AppTheme.titleMediumBold,
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    'Xem Thêm',
                    style: AppTheme.linkStyle,
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reviews.length > 2 ? 2 : reviews.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return ReviewCard(review: reviews[index]);
          },
        ),
      ],
    );
  }
}
