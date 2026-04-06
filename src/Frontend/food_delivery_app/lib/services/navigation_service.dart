import 'package:flutter/material.dart';
import '../models/order_model.dart';

/// Service to manage navigation to screens
class ScreenNavigationService {
  static Future<dynamic> navigateToOrderDetail(
    BuildContext context,
    OrderDetail orderDetail,
  ) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _OrderDetailScreenImporter(orderDetail),
      ),
    );
  }

  static Future<dynamic> navigateToOrderHistory(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _OrderHistoryScreenImporter(),
      ),
    );
  }

  static Future<dynamic> navigateToOrderHistoryEmpty(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _OrderHistoryEmptyScreenImporter(),
      ),
    );
  }

  static Future<dynamic> navigateToNotifications(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _NotificationsScreenImporter(),
      ),
    );
  }

  static Future<dynamic> navigateToNotificationsEmpty(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _NotificationsEmptyScreenImporter(),
      ),
    );
  }
}

// Lazy imports to keep file small
class _OrderDetailScreenImporter extends StatelessWidget {
  final OrderDetail orderDetail;
  const _OrderDetailScreenImporter(this.orderDetail);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadOrderDetailScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return snapshot.data as Widget;
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Future<dynamic> _loadOrderDetailScreen() async {
    // Dynamic import to reduce initial load
    final module = await _loadOrderDetailFromFile();
    return module;
  }

  Future<Widget> _loadOrderDetailFromFile() async {
    // This would normally be dynamic import
    // For now, we return the widget directly
    return _getOrderDetailScreen();
  }

  Widget _getOrderDetailScreen() {
    // Placeholder - in real app, this would be a lazy-loaded module
    // import '../screens/order_detail_screen.dart';
    // return OrderDetailScreen(orderDetail: orderDetail);
    return Placeholder();
  }
}

class _OrderHistoryScreenImporter extends StatelessWidget {
  const _OrderHistoryScreenImporter();

  @override
  Widget build(BuildContext context) {
    // import '../screens/order_history_screen.dart';
    // return const OrderHistoryScreen();
    return const Placeholder();
  }
}

class _OrderHistoryEmptyScreenImporter extends StatelessWidget {
  const _OrderHistoryEmptyScreenImporter();

  @override
  Widget build(BuildContext context) {
    // import '../screens/order_history_empty_screen.dart';
    // return const OrderHistoryEmptyScreen();
    return const Placeholder();
  }
}

class _NotificationsScreenImporter extends StatelessWidget {
  const _NotificationsScreenImporter();

  @override
  Widget build(BuildContext context) {
    // import '../screens/notifications_screen.dart';
    // return const NotificationsScreen();
    return const Placeholder();
  }
}

class _NotificationsEmptyScreenImporter extends StatelessWidget {
  const _NotificationsEmptyScreenImporter();

  @override
  Widget build(BuildContext context) {
    // import '../screens/notifications_empty_screen.dart';
    // return const NotificationsEmptyScreen();
    return const Placeholder();
  }
}
