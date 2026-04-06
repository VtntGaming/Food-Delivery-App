import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({Key? key}) : super(key: key);

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Đơn hàng', style: theme.textStyles.appBarTitle),
        backgroundColor: theme.colors.primary,
        leading: BackButton(color: Colors.white, onPressed: () => Navigator.of(context).maybePop()),
      ),
      body: Padding(
        padding: theme.spacing.screenPadding,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text('#${1234 + index} - Nguyễn Văn A', style: theme.textStyles.title),
                subtitle: Text('Trạng thái: Đang chế biến', style: theme.textStyles.title.copyWith(fontWeight: FontWeight.w400)),
                trailing: Text('${(index + 1) * 50}.000đ', style: theme.textStyles.value),
                onTap: () => Navigator.of(context).pushNamed('/orders/detail'),
              ),
            );
          },
        ),
      ),
    );
  }
}
