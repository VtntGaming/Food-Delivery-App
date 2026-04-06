import 'package:flutter/material.dart';

import '../features/address/data/repositories/address_repository_impl.dart';
import '../features/address/domain/usecases/get_saved_addresses_usecase.dart';
import '../features/address/presentation/controllers/address_page_controller.dart';
import '../features/address/presentation/pages/address_page.dart';
import '../features/cart/presentation/controllers/cart_page_controller.dart';
import '../features/cart/presentation/pages/cart_page.dart';
import '../features/payment/domain/entities/payment_method_entity.dart';
import '../features/payment/presentation/controllers/payment_page_controller.dart';
import '../features/payment/presentation/pages/payment_page.dart';

enum _OrderStep { address, cart, payment }

class OrderFlowPage extends StatefulWidget {
  const OrderFlowPage({super.key});

  @override
  State<OrderFlowPage> createState() => _OrderFlowPageState();
}

class _OrderFlowPageState extends State<OrderFlowPage> {
  late final AddressPageController _addressController;
  late final CartPageController _cartController;
  late final PaymentPageController _paymentController;

  _OrderStep _currentStep = _OrderStep.address;

  @override
  void initState() {
    super.initState();
    _addressController = AddressPageController(
      getSavedAddressesUseCase: GetSavedAddressesUseCase(
        const AddressRepositoryImpl(),
      ),
      onConfirm: _goToCart,
      onAddNewAddress: _showAddAddressMessage,
    );
    _cartController = CartPageController(onConfirm: (_) => _goToPayment());
    _paymentController = PaymentPageController(onConfirm: _onPaymentConfirmed);
  }

  void _goToCart() {
    setState(() {
      _currentStep = _OrderStep.cart;
    });
  }

  void _goToPayment() {
    setState(() {
      _currentStep = _OrderStep.payment;
    });
  }

  void _showAddAddressMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tính năng thêm địa chỉ sẽ sớm cập nhật.')),
    );
  }

  void _onPaymentConfirmed(PaymentMethodEntity method) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã chọn phương thức: ${method.name}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      child: switch (_currentStep) {
        _OrderStep.address => AddressPage(
          key: const ValueKey('address'),
          controller: _addressController,
        ),
        _OrderStep.cart => CartPage(
          key: const ValueKey('cart'),
          controller: _cartController,
          onBack: () {
            setState(() {
              _currentStep = _OrderStep.address;
            });
          },
        ),
        _OrderStep.payment => PaymentPage(
          key: const ValueKey('payment'),
          controller: _paymentController,
          onBack: () {
            setState(() {
              _currentStep = _OrderStep.cart;
            });
          },
        ),
      },
    );
  }
}
