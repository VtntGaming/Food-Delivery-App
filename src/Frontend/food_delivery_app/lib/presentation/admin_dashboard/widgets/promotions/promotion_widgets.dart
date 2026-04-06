import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/theme.dart';
import '../common/app_widgets.dart';

class PromotionModel {
  final String id;
  final String code;
  final String discount;
  final String validUntil;
  final String type;

  PromotionModel({
    required this.id,
    required this.code,
    required this.discount,
    required this.validUntil,
    required this.type,
  });
}

class PromotionCard extends StatelessWidget {
  final PromotionModel promotion;
  final VoidCallback? onDelete;

  const PromotionCard({
    Key? key,
    required this.promotion,
    this.onDelete,
  }) : super(key: key);

  Color _getDiscountColor(String type) {
    if (type.contains('GIAM')) return AppTheme.accentOrange;
    if (type.contains('FREE')) return AppTheme.successGreen;
    return AppTheme.accentRed;
  }

  @override
  Widget build(BuildContext context) {
    final discountColor = _getDiscountColor(promotion.type);

    return AppCard(
      padding: const EdgeInsets.all(AppTheme.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promotion.code,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppTheme.xs),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.sm,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: discountColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      ),
                      child: Text(
                        promotion.type,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: discountColor,
                              fontSize: 10,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.md,
                  vertical: AppTheme.sm,
                ),
                decoration: BoxDecoration(
                  color: discountColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Text(
                  promotion.discount,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: discountColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.md),
          AppDivider(padding: EdgeInsets.zero),
          const SizedBox(height: AppTheme.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HSD',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textGrey,
                        ),
                  ),
                  const SizedBox(height: AppTheme.xs),
                  Text(
                    promotion.validUntil,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              AppButton(
                label: 'Xóa',
                onPressed: onDelete ?? () {},
                backgroundColor: AppTheme.accentRed,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.md,
                  vertical: AppTheme.sm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PromotionsSection extends StatelessWidget {
  final List<PromotionModel> promotions;
  final VoidCallback? onDeletePromotion;
  final VoidCallback? onAddPromotion;

  const PromotionsSection({
    Key? key,
    required this.promotions,
    this.onDeletePromotion,
    this.onAddPromotion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (promotions.isEmpty)
          const AppEmptyState(
            message: 'Không có khuyến mãi',
            icon: Icons.local_offer_outlined,
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: promotions.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppTheme.md),
            itemBuilder: (context, index) {
              return PromotionCard(
                promotion: promotions[index],
                onDelete: onDeletePromotion,
              );
            },
          ),
      ],
    );
  }
}
