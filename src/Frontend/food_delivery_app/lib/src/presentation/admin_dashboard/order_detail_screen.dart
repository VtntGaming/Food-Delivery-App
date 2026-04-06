import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết đơn hàng', style: theme.textStyles.appBarTitle),
        backgroundColor: theme.colors.primary,
        leading: BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: theme.spacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('#1234', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 8),
                    Text('Nguyễn Văn A'),
                    SizedBox(height: 8),
                    Text('Tổng: 55.000đ'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Danh sách món', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(leading: CircleAvatar(), title: Text('Trà sữa x2'), subtitle: Text('')),
                  ListTile(leading: CircleAvatar(), title: Text('Bánh mì x1'), subtitle: Text('')),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Cập nhật trạng thái'),
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
