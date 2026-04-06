import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/payment_method_entity.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  final PaymentMethodEntity method;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.s(context, 10)),
      child: Container(
        padding: EdgeInsets.all(AppDimensions.s(context, 10)),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.s(context, 10)),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: AppDimensions.s(context, 2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppDimensions.s(context, 6),
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Image.network(
                    method.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, _, __) {
                      return const Center(
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: AppColors.textSecondary,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.s(context, 8)),
            Text(
              method.name,
              style: TextStyle(
                fontSize: AppDimensions.s(context, 16),
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
