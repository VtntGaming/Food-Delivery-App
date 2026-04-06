import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String price;
  final String status;
  final VoidCallback? onTap;

  const OrderCard({
    Key? key,
    required this.orderId,
    required this.customerName,
    required this.price,
    required this.status,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.medium),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(orderId, style: AppTextStyles.cardTitle),
                  const SizedBox(height: AppSpacing.small),
                  Text(customerName, style: AppTextStyles.cardSubtitle),
                  const SizedBox(height: AppSpacing.small),
                  Text('Giá: $price', style: AppTextStyles.cardSubtitle),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(status, style: AppTextStyles.cardSubtitle),
            )
          ],
        ),
      ),
    );
  }
}
