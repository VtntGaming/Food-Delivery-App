import 'package:flutter/material.dart';
import '../config/theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class NotificationsEmptyScreen extends StatelessWidget {
  const NotificationsEmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          AppHeader(
            title: 'Thông báo',
            onBackPressed: () => Navigator.of(context).pop(),
            trailing: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.more_vert,
                color: Colors.white,
                size: AppTheme.iconSizeL,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: AppTheme.spacingM,
              right: AppTheme.spacingM,
              left: AppTheme.spacingM,
            ),
            child: GestureDetector(
              onTap: () {},
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
          ),
          const SizedBox(height: AppTheme.spacingL),
          const Expanded(
            child: EmptyStateWidget(
              message: 'Bạn không có thông báo mới.',
              icon: Icons.notifications_none,
            ),
          ),
        ],
      ),
    );
  }
}
