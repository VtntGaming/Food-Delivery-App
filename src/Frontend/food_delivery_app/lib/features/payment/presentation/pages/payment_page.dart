import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../address/presentation/widgets/address_header.dart';
import '../../../address/presentation/widgets/bottom_confirm_button.dart';
import '../controllers/payment_page_controller.dart';
import '../widgets/payment_method_tile.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key, required this.controller, this.onBack});

  final PaymentPageController controller;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final width = MediaQuery.sizeOf(context).width;
        final crossAxisCount = width > 560 ? 3 : 2;

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: Column(
            children: [
              AddressHeader(
                title: 'Các phương thức thanh toán',
                onBack: onBack,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppDimensions.s(context, AppDimensions.horizontalPadding),
                    AppDimensions.s(context, 18),
                    AppDimensions.s(context, AppDimensions.horizontalPadding),
                    AppDimensions.s(context, 24),
                  ),
                  child: GridView.builder(
                    itemCount: controller.methods.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: AppDimensions.s(context, 22),
                      crossAxisSpacing: AppDimensions.s(context, 18),
                      childAspectRatio: 0.92,
                    ),
                    itemBuilder: (context, index) {
                      final method = controller.methods[index];
                      return PaymentMethodTile(
                        method: method,
                        isSelected: controller.selectedMethodId == method.id,
                        onTap: () => controller.selectMethod(method.id),
                      );
                    },
                  ),
                ),
              ),
              BottomConfirmButton(
                label: 'Lựa chọn phương thức\nthanh toán',
                onPressed: controller.confirmSelection,
              ),
            ],
          ),
        );
      },
    );
  }
}
