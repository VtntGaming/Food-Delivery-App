class Order {
  final String id;
  final String restaurantName;
  final String restaurantUrl;
  final DateTime orderDate;
  final double totalPrice;
  final double shippingFee;
  final double foodPrice;
  final String status;
  final String? description;
  final String? deliveryNote;

  Order({
    required this.id,
    required this.restaurantName,
    required this.restaurantUrl,
    required this.orderDate,
    required this.totalPrice,
    required this.shippingFee,
    required this.foodPrice,
    required this.status,
    this.description,
    this.deliveryNote,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      restaurantName: json['restaurantName'] as String,
      restaurantUrl: json['restaurantUrl'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      shippingFee: (json['shippingFee'] as num).toDouble(),
      foodPrice: (json['foodPrice'] as num).toDouble(),
      status: json['status'] as String,
      description: json['description'] as String?,
      deliveryNote: json['deliveryNote'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'restaurantName': restaurantName,
    'restaurantUrl': restaurantUrl,
    'orderDate': orderDate.toIso8601String(),
    'totalPrice': totalPrice,
    'shippingFee': shippingFee,
    'foodPrice': foodPrice,
    'status': status,
    'description': description,
    'deliveryNote': deliveryNote,
  };
}

class OrderDetail {
  final Order order;
  final String recipientName;
  final String recipientPhone;
  final String location;
  final String deliveryTime;
  final DateTime deliveryDate;

  OrderDetail({
    required this.order,
    required this.recipientName,
    required this.recipientPhone,
    required this.location,
    required this.deliveryTime,
    required this.deliveryDate,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      order: Order.fromJson(json['order']),
      recipientName: json['recipientName'] as String,
      recipientPhone: json['recipientPhone'] as String,
      location: json['location'] as String,
      deliveryTime: json['deliveryTime'] as String,
      deliveryDate: DateTime.parse(json['deliveryDate'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'order': order.toJson(),
    'recipientName': recipientName,
    'recipientPhone': recipientPhone,
    'location': location,
    'deliveryTime': deliveryTime,
    'deliveryDate': deliveryDate.toIso8601String(),
  };
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final String type;
  final DateTime createdAt;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.isRead = false,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
    'type': type,
    'createdAt': createdAt.toIso8601String(),
    'isRead': isRead,
  };

  AppNotification copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }
}

extension OrderExtension on Order {
  String get formattedDate {
    return '${orderDate.day}/${orderDate.month}/${orderDate.year}';
  }

  String get formattedPrice {
    return '${totalPrice.toStringAsFixed(0)}VND';
  }

  bool get isDelivered => status.toLowerCase() == 'delivered';
  bool get isDelivering => status.toLowerCase() == 'delivering';
  bool get isCancelled => status.toLowerCase() == 'cancelled';
}

extension NotificationExtension on AppNotification {
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inHours < 1) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    }
  }

  bool get isDeliveryNotification => type.toLowerCase().contains('delivery');
  bool get isPromoNotification => type.toLowerCase().contains('promo');
}
