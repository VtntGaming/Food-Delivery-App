import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class MenuManagementScreen extends StatelessWidget {
  const MenuManagementScreen({Key? key}) : super(key: key);

  static const routeName = '/menu-list';

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách món', style: theme.textStyles.appBarTitle),
        backgroundColor: theme.colors.primary,
        leading: BackButton(color: Colors.white, onPressed: () => Navigator.of(context).maybePop()),
      ),
      body: Padding(
        padding: theme.spacing.screenPadding,
        child: ListView.separated(
          itemCount: 8,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Container(width: 56, height: 56, color: Colors.grey.shade200),
                title: Text('Tên món #${index + 1}', style: theme.textStyles.title),
                subtitle: Text('Giá: 30.000đ', style: theme.textStyles.title.copyWith(fontWeight: FontWeight.w400)),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
