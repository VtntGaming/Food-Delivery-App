import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/cart_item_entity.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  final CartItemEntity item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.s(context, 12)),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppDimensions.s(context, 8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.s(context, 6)),
            child: Image.network(
              item.imageUrl,
              width: AppDimensions.s(context, 120),
              height: AppDimensions.s(context, 94),
              fit: BoxFit.cover,
              errorBuilder: (context, _, __) {
                return Container(
                  width: AppDimensions.s(context, 120),
                  height: AppDimensions.s(context, 94),
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.fastfood,
                    color: AppColors.textSecondary,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: AppDimensions.s(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Món: ${item.name}',
                  style: TextStyle(
                    fontSize: AppDimensions.s(context, 16),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppDimensions.s(context, 6)),
                Text(
                  'Giá: ${formatVnd(item.unitPrice)}',
                  style: TextStyle(
                    fontSize: AppDimensions.s(context, 16),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppDimensions.s(context, 6)),
                Row(
                  children: [
                    Text(
                      'Số lượng',
                      style: TextStyle(
                        fontSize: AppDimensions.s(context, 14),
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: AppDimensions.s(context, 8)),
                    _StepButton(icon: Icons.remove, onTap: onDecrease),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: AppDimensions.s(context, 6),
                      ),
                      width: AppDimensions.s(context, 32),
                      height: AppDimensions.s(context, 28),
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Text(
                        '${item.quantity}',
                        style: TextStyle(
                          fontSize: AppDimensions.s(context, 14),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    _StepButton(icon: Icons.add, onTap: onIncrease),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: onRemove,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      minimumSize: Size.zero,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.s(context, 6),
                        vertical: AppDimensions.s(context, 2),
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Xoá',
                      style: TextStyle(
                        fontSize: AppDimensions.s(context, 14),
                        fontWeight: FontWeight.w700,
                      ),
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

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.s(context, 4)),
      child: Container(
        width: AppDimensions.s(context, 24),
        height: AppDimensions.s(context, 24),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.s(context, 4)),
        ),
        child: Icon(
          icon,
          size: AppDimensions.s(context, 16),
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
