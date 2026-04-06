import 'package:flutter/material.dart';
import '../config/theme/app_theme.dart';
import '../models/order_model.dart' as order_models;
import '../widgets/common_widgets.dart';

class NotificationItemWidget extends StatelessWidget {
  final order_models.AppNotification notification;
  final VoidCallback onTap;

  const NotificationItemWidget({
    Key? key,
    required this.notification,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppTheme.spacingXS),
        padding: const EdgeInsets.all(AppTheme.spacingM),
        decoration: BoxDecoration(
          color: notification.isRead ? AppTheme.backgroundColor : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
                fontFamily: 'BeVietnamPro',
              ),
            ),
            const SizedBox(height: AppTheme.spacingXS),
            Text(
              notification.message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
                fontFamily: 'BeVietnamPro',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppTheme.spacingXS),
            Text(
              notification.formattedDate,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppTheme.textHint,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<order_models.AppNotification> notifications;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    notifications = [
      order_models.AppNotification(
        id: '1',
        title: 'Đơn hàng của bạn đang được giao',
        message: 'Đơn hàng #123456789 đang được giao tới bạn',
        type: 'delivery',
        createdAt: DateTime.now(),
        isRead: false,
      ),
      order_models.AppNotification(
        id: '2',
        title: 'Cửa hàng A đang sale 50%',
        message: 'Khám phá các ưu đãi độc quyền từ cửa hàng yêu thích của bạn',
        type: 'promo',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      order_models.AppNotification(
        id: '3',
        title: 'Đã giao hàng thành công',
        message: 'Đơn hàng #987654321 đã được giao thành công',
        type: 'delivery',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ];
  }

  void _markAllAsRead() {
    setState(() {
      notifications = notifications.map((n) => n.copyWith(isRead: true)).toList();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã đánh dấu tất cả là đã đọc'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onNotificationTap(order_models.AppNotification notification) {
    if (!notification.isRead) {
      setState(() {
        notifications = notifications.map((n) {
          if (n.id == notification.id) {
            return n.copyWith(isRead: true);
          }
          return n;
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          AppHeader(
            title: 'Thông báo',
            onBackPressed: () => Navigator.of(context).pop(),
            trailing: SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: AppTheme.spacingM,
              right: AppTheme.spacingM,
              left: AppTheme.spacingM,
              bottom: AppTheme.spacingS,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đã đọc: ${notifications.where((n) => n.isRead).length}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textHint,
                    fontFamily: 'BeVietnamPro',
                  ),
                ),
                GestureDetector(
                  onTap: _markAllAsRead,
                  child: Text(
                    'Đánh dấu tất cả là đã đọc',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondary,
                      fontFamily: 'Inter',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: AppTheme.dividerColor,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationItemWidget(
                  notification: notification,
                  onTap: () => _onNotificationTap(notification),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
