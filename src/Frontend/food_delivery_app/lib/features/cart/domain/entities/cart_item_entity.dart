class CartItemEntity {
  const CartItemEntity({
    required this.id,
    required this.name,
    required this.unitPrice,
    required this.quantity,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final int unitPrice;
  final int quantity;
  final String imageUrl;

  int get subtotal => unitPrice * quantity;

  CartItemEntity copyWith({
    String? id,
    String? name,
    int? unitPrice,
    int? quantity,
    String? imageUrl,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
