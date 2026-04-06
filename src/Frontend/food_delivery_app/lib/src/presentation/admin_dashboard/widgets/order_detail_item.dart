import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class OrderDetailItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String qty;

  const OrderDetailItem({Key? key, required this.imageUrl, required this.title, required this.qty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(imageUrl, width: 40, height: 40, fit: BoxFit.cover),
        ),
        const SizedBox(width: AppSpacing.medium),
        Expanded(
          child: Text(title, style: AppTextStyles.cardSubtitle),
        ),
        Text(qty, style: AppTextStyles.cardSubtitle),
      ],
    );
  }
}
