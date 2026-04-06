import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'widgets/stat_card.dart';
import 'widgets/chart_placeholder.dart';
import 'widgets/action_button.dart';

class AdminDashboardScreen extends StatelessWidget {
  static const routeName = '/admin-dashboard';

  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: theme.colors.scaffoldBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: 'Quay lại',
        ),
        title: Text('Quản trị', style: theme.textStyles.appBarTitle),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          return SingleChildScrollView(
            padding: theme.spacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: theme.spacing.xs.horizontal, // use horizontal value
                  runSpacing: theme.spacing.xs.vertical,
                  children: const [
                    StatCard(title: 'Đơn mới', value: '24', icon: Icons.receipt_long),
                    StatCard(title: 'Doanh số hôm nay', value: '5,200,000đ', icon: Icons.attach_money),
                    StatCard(title: 'Bình luận mới', value: '12', icon: Icons.comment),
                  ],
                ),

                const SizedBox(height: 16),

                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: isWide ? 220 : 180),
                  child: const ChartPlaceholder(),
                ),

                const SizedBox(height: 16),

                // Use Row on wide screens and Column on narrow screens to avoid
                // Expanded inside an unbounded vertical SingleChildScrollView.
                if (isWide) ...[
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          label: 'Danh sách món',
                          backgroundColor: theme.colors.accentButton,
                          onPressed: () => Navigator.of(context).pushNamed('/menu-list'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ActionButton(
                          label: 'Đơn hàng',
                          backgroundColor: theme.colors.secondaryButton,
                          onPressed: () => Navigator.of(context).pushNamed('/orders'),
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  SizedBox(
                    width: double.infinity,
                    child: ActionButton(
                      label: 'Danh sách món',
                      backgroundColor: theme.colors.accentButton,
                      onPressed: () => Navigator.of(context).pushNamed('/menu-list'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ActionButton(
                      label: 'Đơn hàng',
                      backgroundColor: theme.colors.secondaryButton,
                      onPressed: () => Navigator.of(context).pushNamed('/orders'),
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: Text('Xem báo cáo hôm nay', style: theme.textStyles.buttonPrimary),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
