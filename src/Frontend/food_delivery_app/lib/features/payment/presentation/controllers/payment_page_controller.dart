import 'package:flutter/foundation.dart';

import '../../domain/entities/payment_method_entity.dart';

typedef PaymentConfirmCallback = void Function(PaymentMethodEntity method);

class PaymentPageController extends ChangeNotifier {
  PaymentPageController({PaymentConfirmCallback? onConfirm})
    : _onConfirm = onConfirm;

  final PaymentConfirmCallback? _onConfirm;

  static const List<PaymentMethodEntity> _methods = [
    PaymentMethodEntity(
      id: 'momo',
      name: 'Ví Momo',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/ae4431b9-1b71-433c-9ab4-863daf1a77f9',
    ),
    PaymentMethodEntity(
      id: 'zalopay',
      name: 'Ví ZaloPay',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/ba9d6c93-6619-4348-a91b-e0b83ef7295e',
    ),
    PaymentMethodEntity(
      id: 'vietqr',
      name: 'VietQR',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/b5a89da1-cd43-4896-a8dc-8eededfc5c30',
    ),
    PaymentMethodEntity(
      id: 'cod',
      name: 'COD',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/65e4a1c1-676b-4626-b2d0-926a3e96a113',
    ),
  ];

  String _selectedMethodId = _methods.first.id;

  List<PaymentMethodEntity> get methods => _methods;
  String get selectedMethodId => _selectedMethodId;

  PaymentMethodEntity get selectedMethod {
    return _methods.firstWhere((method) => method.id == _selectedMethodId);
  }

  void selectMethod(String id) {
    if (_selectedMethodId == id) {
      return;
    }

    _selectedMethodId = id;
    notifyListeners();
  }

  void confirmSelection() {
    _onConfirm?.call(selectedMethod);
  }
}
