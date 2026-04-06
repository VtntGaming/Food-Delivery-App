import 'package:flutter/material.dart';
import '../config/theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class OrderHistoryEmptyScreen extends StatefulWidget {
  const OrderHistoryEmptyScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryEmptyScreen> createState() =>
      _OrderHistoryEmptyScreenState();
}

class _OrderHistoryEmptyScreenState extends State<OrderHistoryEmptyScreen> {
  int _activeTabIndex = 0;
  final _tabs = ['Đang giao', 'Đã giao', 'Giỏ hàng'];

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
              onTap: () {},
              child: Text(
                'Xóa lịch sử',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'BeVietnamPro',
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          _buildTabBar(),
          const SizedBox(height: AppTheme.spacingL),
          const Expanded(
            child: EmptyStateWidget(
              message:
              'Bạn chưa có đơn hàng nào.\nMua sắm ngay để hưởng các ưu đãi độc quyền.',
              icon: Icons.shopping_bag_outlined,
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
