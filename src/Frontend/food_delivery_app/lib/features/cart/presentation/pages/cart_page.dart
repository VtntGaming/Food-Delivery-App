import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../address/presentation/widgets/address_header.dart';
import '../../../address/presentation/widgets/bottom_confirm_button.dart';
import '../controllers/cart_page_controller.dart';
import '../widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, required this.controller, this.onBack});

  final CartPageController controller;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: Column(
            children: [
              AddressHeader(title: 'Giỏ hàng của bạn', onBack: onBack),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.s(
                      context,
                      AppDimensions.horizontalPadding,
                    ),
                    vertical: AppDimensions.s(context, 12),
                  ),
                  child: controller.hasItems
                      ? ListView.separated(
                          itemCount: controller.items.length,
                          separatorBuilder: (_, __) =>
                              SizedBox(height: AppDimensions.s(context, 16)),
                          itemBuilder: (context, index) {
                            final item = controller.items[index];
                            return CartItemCard(
                              item: item,
                              onIncrease: () =>
                                  controller.increaseQuantity(item.id),
                              onDecrease: () =>
                                  controller.decreaseQuantity(item.id),
                              onRemove: () => controller.removeItem(item.id),
                            );
                          },
                        )
                      : const _EmptyCartView(),
                ),
              ),
              _TotalBar(amount: controller.totalAmount),
              BottomConfirmButton(
                label: 'Xác nhận đặt hàng',
                enabled: controller.hasItems,
                onPressed: controller.confirmOrder,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TotalBar extends StatelessWidget {
  const _TotalBar({required this.amount});

  final int amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.s(context, AppDimensions.horizontalPadding),
        AppDimensions.s(context, 8),
        AppDimensions.s(context, AppDimensions.horizontalPadding),
        AppDimensions.s(context, 8),
      ),
      child: Row(
        children: [
          Text(
            'Tổng tiền:',
            style: TextStyle(
              fontSize: AppDimensions.s(context, 28),
              fontWeight: FontWeight.w700,
              color: const Color(0xCCFF0004),
            ),
          ),
          SizedBox(width: AppDimensions.s(context, 10)),
          Expanded(
            child: Container(
              height: AppDimensions.s(context, 42),
              alignment: Alignment.center,
              color: AppColors.surfaceMuted,
              child: Text(
                formatVnd(amount),
                style: TextStyle(
                  fontSize: AppDimensions.s(context, 20),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCartView extends StatelessWidget {
  const _EmptyCartView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Giỏ hàng đang trống',
        style: TextStyle(
          fontSize: AppDimensions.s(context, 18),
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
