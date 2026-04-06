import 'package:flutter/foundation.dart';

import '../../domain/entities/cart_item_entity.dart';

typedef CartConfirmCallback = void Function(double totalAmount);

class CartPageController extends ChangeNotifier {
  CartPageController({
    CartConfirmCallback? onConfirm,
    List<CartItemEntity>? seedItems,
  }) : _onConfirm = onConfirm,
       _items = List<CartItemEntity>.from(seedItems ?? _defaultItems);

  final CartConfirmCallback? _onConfirm;
  final List<CartItemEntity> _items;

  static const List<CartItemEntity> _defaultItems = [
    CartItemEntity(
      id: 'pho',
      name: 'Phở',
      unitPrice: 45000,
      quantity: 1,
      imageUrl:
          'https://www.figma.com/api/mcp/asset/a5ca3b1e-ea46-4b8c-ac35-53b126d08fd4',
    ),
    CartItemEntity(
      id: 'pizza',
      name: 'Pizza',
      unitPrice: 250000,
      quantity: 1,
      imageUrl:
          'https://www.figma.com/api/mcp/asset/17669695-d631-40f7-82b6-9db020c689e4',
    ),
  ];

  List<CartItemEntity> get items => List.unmodifiable(_items);

  bool get hasItems => _items.isNotEmpty;

  int get totalAmount {
    return _items.fold<int>(0, (sum, item) => sum + item.subtotal);
  }

  void increaseQuantity(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index < 0) {
      return;
    }

    final item = _items[index];
    _items[index] = item.copyWith(quantity: item.quantity + 1);
    notifyListeners();
  }

  void decreaseQuantity(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index < 0) {
      return;
    }

    final item = _items[index];
    if (item.quantity <= 1) {
      return;
    }

    _items[index] = item.copyWith(quantity: item.quantity - 1);
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void confirmOrder() {
    if (!hasItems) {
      return;
    }
    _onConfirm?.call(totalAmount.toDouble());
  }
}
