/// App-wide constants and string values
class AppStrings {
  // Headers
  static const String headerNotifications = 'Thông báo';
  static const String headerOrderHistory = 'Lịch sử đơn hàng';
  static const String headerOrderDetail = 'Chi tiết đơn hàng';

  // Buttons & Actions
  static const String markAllAsRead = 'Đánh dấu tất cả là đã đọc';
  static const String clearHistory = 'Xóa lịch sử';
  static const String addAddress = 'Thêm địa chỉ';
  static const String viewDetails = 'Xem chi tiết';
  static const String rateOrder = 'Đánh giá';
  static const String reorder = 'Đặt lại';

  // Tab Labels
  static const String tabDelivering = 'Đang giao';
  static const String tabDelivered = 'Đã giao';
  static const String tabCart = 'Giỏ hàng';

  // Empty States
  static const String emptyNotifications = 'Bạn không có thông báo mới.';
  static const String emptyOrderHistory =
      'Bạn chưa có đơn hàng nào.\nMua sắm ngay để hưởng các ưu đãi độc quyền.';
  static const String emptyOrdersInTab = 'Không có đơn hàng nào trong danh mục này';

  // Order Detail Labels
  static const String orderId = 'ID Đơn hàng:';
  static const String restaurantName = 'Tên đơn hàng:';
  static const String deliverTo = 'Giao đến:';
  static const String deliveryTime = 'Thời gian giao:';
  static const String description = 'Mô tả:';
  static const String foodPrice = 'Giá tiền:';
  static const String shippingFee = 'Phí ship:';
  static const String totalPrice = 'Tổng tiền:';
  static const String notes = 'Ghi chú:';
  static const String notesHint = 'Ghi chú tại đây......';
  static const String recipientName = 'Tên người nhận:';
  static const String recipientPhone = 'Số điện thoại:';
  static const String location = 'Địa điểm:';

  // Dialog & Messages
  static const String clearHistoryTitle = 'Xóa lịch sử';
  static const String clearHistoryMessage =
      'Bạn có chắc muốn xóa toàn bộ lịch sử đơn hàng?';
  static const String clear = 'Xóa';
  static const String cancel = 'Hủy';
  static const String historyCleared = 'Đã xóa lịch sử';

  // Status Messages
  static const String delivering = 'Đang giao hàng';
  static const String delivered = 'Đã giao hàng thành công';
  static const String cancelled = 'Đã hủy';

  // Time Formatting
  static const String minutesAgo = 'phút trước';
  static const String hoursAgo = 'giờ trước';
  static const String daysAgo = 'ngày trước';

  // Notification Types
  static const String notificationDelivery = 'Delivery';
  static const String notificationPromo = 'Promo';
  static const String notificationOrder = 'Order';

  // Read Status
  static const String readCount = 'Đã đọc:';
}

/// App-wide constants for UI sizing
class AppConstants {
  // Animation durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // List pagination
  static const int defaultPageSize = 20;
  static const int maxNotificationsToDisplay = 50;

  // Validation
  static const int minNoteLength = 0;
  static const int maxNoteLength = 500;
  static const int phoneNumberLength = 10;

  // Retry logic
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  // DateTime
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
}

/// Order status constants
class OrderStatus {
  static const String pending = 'pending';
  static const String confirmed = 'confirmed';
  static const String preparing = 'preparing';
  static const String delivering = 'delivering';
  static const String delivered = 'delivered';
  static const String cancelled = 'cancelled';

  static String getDisplayName(String status) {
    switch (status.toLowerCase()) {
      case delivering:
        return 'Đang giao hàng';
      case delivered:
        return 'Đã giao hàng';
      case cancelled:
        return 'Đã hủy';
      case pending:
        return 'Chờ xác nhận';
      case confirmed:
        return 'Đã xác nhận';
      case preparing:
        return 'Đang chuẩn bị';
      default:
        return 'Không xác định';
    }
  }

  static bool isActive(String status) {
    return status.toLowerCase() == pending ||
        status.toLowerCase() == confirmed ||
        status.toLowerCase() == preparing ||
        status.toLowerCase() == delivering;
  }
}

/// Notification type constants
class NotificationType {
  static const String delivery = 'delivery';
  static const String promo = 'promo';
  static const String order = 'order';
  static const String system = 'system';

  static String getDisplayIcon(String type) {
    switch (type.toLowerCase()) {
      case delivery:
        return '🚗';
      case promo:
        return '🎉';
      case order:
        return '📦';
      case system:
        return 'ℹ️';
      default:
        return '📬';
    }
  }
}
