import 'package:flutter/material.dart';
import '../config/theme/app_theme.dart';
import '../models/order_model.dart';
import '../widgets/common_widgets.dart';

class OrderHistoryItemWidget extends StatelessWidget {
  final Order order;
  final VoidCallback onViewDetails;

  const OrderHistoryItemWidget({
    Key? key,
    required this.order,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingXS,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppTheme.radiusS),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: AppTheme.dividerColor,
                    child: const Icon(
                      Icons.restaurant,
                      color: AppTheme.textHint,
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID Đơn hàng: ${order.id}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingXS),
                      Text(
                        'Tên đơn hàng: ${order.restaurantName}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                          fontFamily: 'BeVietnamPro',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingM),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.formattedDate,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                    fontFamily: 'Inter',
                  ),
                ),
                GestureDetector(
                  onTap: onViewDetails,
                  child: Text(
                    'Xem chi tiết',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondary,
                      fontFamily: 'BeVietnamPro',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int _activeTabIndex = 0;
  final _tabs = ['Đang giao', 'Đã giao', 'Giỏ hàng'];
  late List<Order> _orders;

  @override
  void initState() {
    super.initState();
    _initializeOrders();
  }

  void _initializeOrders() {
    _orders = [
      Order(
        id: '123456789',
        restaurantName: 'test restaurant 1',
        restaurantUrl: 'https://example.com',
        orderDate: DateTime.now().subtract(const Duration(hours: 5)),
        totalPrice: 65000,
        shippingFee: 15000,
        foodPrice: 50000,
        status: 'delivering',
        description: 'Some description here',
      ),
      Order(
        id: '123456789',
        restaurantName: 'test restaurant 2',
        restaurantUrl: 'https://example.com',
        orderDate: DateTime(2026, 1, 1),
        totalPrice: 65000,
        shippingFee: 15000,
        foodPrice: 50000,
        status: 'delivered',
        description: 'Some description here',
      ),
      Order(
        id: '123456789',
        restaurantName: 'test restaurant 3',
        restaurantUrl: 'https://example.com',
        orderDate: DateTime(2025, 4, 1),
        totalPrice: 65000,
        shippingFee: 15000,
        foodPrice: 50000,
        status: 'delivered',
        description: 'Some description here',
      ),
      Order(
        id: '123454589',
        restaurantName: 'test restaurant 4',
        restaurantUrl: 'https://example.com',
        orderDate: DateTime(2025, 2, 25),
        totalPrice: 65000,
        shippingFee: 15000,
        foodPrice: 50000,
        status: 'delivered',
        description: 'Some description here',
      ),
    ];
  }

  List<Order> get _filteredOrders {
    switch (_activeTabIndex) {
      case 0:
        return _orders.where((o) => o.isDelivering).toList();
      case 1:
        return _orders.where((o) => o.isDelivered).toList();
      default:
        return [];
    }
  }

  void _clearHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa lịch sử'),
        content: const Text('Bạn có chắc muốn xóa toàn bộ lịch sử đơn hàng?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã xóa lịch sử')),
              );
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  void _onViewDetails(Order order) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Xem chi tiết đơn hàng ${order.id}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          AppHeader(
            title: 'Lịch sử đơn hàng',
            onBackPressed: () => Navigator.of(context).pop(),
            trailing: GestureDetector(
              onTap: _clearHistory,
              child: Text(
                'Xóa lịch sử',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'BeVietnamPro',
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          _buildTabBar(),
          Expanded(
            child: _filteredOrders.isEmpty
                ? const EmptyStateWidget(
              message: 'Không có đơn hàng nào trong danh mục này',
              icon: Icons.shopping_bag_outlined,
            )
                : ListView.builder(
              padding: const EdgeInsets.only(top: AppTheme.spacingM),
              itemCount: _filteredOrders.length,
              itemBuilder: (context, index) {
                final order = _filteredOrders[index];
                return OrderHistoryItemWidget(
                  order: order,
                  onViewDetails: () => _onViewDetails(order),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppTheme.backgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM,
              vertical: AppTheme.spacingS,
            ),
            child: Row(
              children: List.generate(
                _tabs.length,
                (index) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _activeTabIndex = index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingXS,
                        vertical: AppTheme.spacingXS,
                      ),
                      child: Column(
                        children: [
                          Text(
                            _tabs[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _activeTabIndex == index
                                  ? AppTheme.textSecondary
                                  : AppTheme.textHint,
                              fontFamily: 'BeVietnamPro',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (_activeTabIndex == index)
                            Container(
                              height: 2,
                              margin: const EdgeInsets.only(
                                  top: AppTheme.spacingXS),
                              color: AppTheme.textSecondary,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: AppTheme.dividerColor,
          ),
        ],
      ),
    );
  }
}
