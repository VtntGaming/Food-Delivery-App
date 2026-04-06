import 'package:flutter/material.dart';
import '../config/theme/app_theme.dart';
import '../models/order_model.dart';
import '../screens/order_detail_screen.dart';
import '../screens/order_history_empty_screen.dart';
import '../screens/order_history_screen.dart';
import '../screens/notifications_empty_screen.dart';
import '../screens/notifications_screen.dart';

/// Demo app to showcase all screens
class DemoNavigationPage extends StatefulWidget {
  const DemoNavigationPage({Key? key}) : super(key: key);

  @override
  State<DemoNavigationPage> createState() => _DemoNavigationPageState();
}

class _DemoNavigationPageState extends State<DemoNavigationPage> {
  late OrderDetail _sampleOrderDetail;

  @override
  void initState() {
    super.initState();
    _initializeSampleData();
  }

  void _initializeSampleData() {
    _sampleOrderDetail = OrderDetail(
      order: Order(
        id: '123456789',
        restaurantName: 'test.url',
        restaurantUrl: 'https://example.com',
        orderDate: DateTime.now(),
        totalPrice: 65000,
        shippingFee: 15000,
        foodPrice: 50000,
        status: 'delivering',
        description: 'Cơm chiên, nước ngọt',
      ),
      recipientName: 'Nguyen Van A',
      recipientPhone: '0123456789',
      location: 'TP.HCM',
      deliveryTime: '10:10',
      deliveryDate: DateTime(2026, 4, 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Demo Navigation'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('Màn hình Đơn hàng'),
            _buildNavButton(
              'Order History - With Items',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OrderHistoryScreen(),
                ),
              ),
            ),
            _buildNavButton(
              'Order History - Empty State',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OrderHistoryEmptyScreen(),
                ),
              ),
            ),
            _buildNavButton(
              'Order Detail',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderDetailScreen(
                    orderDetail: _sampleOrderDetail,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingL),
            _buildSectionTitle('Màn hình Thông báo'),
            _buildNavButton(
              'Notifications - With Items',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationsScreen(),
                ),
              ),
            ),
            _buildNavButton(
              'Notifications - Empty State',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationsEmptyScreen(),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingL),
            _buildSectionTitle('Thông tin'),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '✓ Clean Architecture',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingXS),
                  Text(
                    '✓ Reusable Widgets',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingXS),
                  Text(
                    '✓ Centralized Theme',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingXS),
                  Text(
                    '✓ Responsive Design',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingXS),
                  Text(
                    '✓ Const Constructors',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppTheme.spacingM,
        top: AppTheme.spacingM,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimary,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildNavButton(
    String label, {
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingM),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          padding: const EdgeInsets.symmetric(
            vertical: AppTheme.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
