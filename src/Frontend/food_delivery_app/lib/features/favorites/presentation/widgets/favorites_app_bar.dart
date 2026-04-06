import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme.dart';

class FavoritesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavoritesAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(107);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.darkHeaderColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      title: const Text(
        'Danh sách yêu thích',
        style: TextStyle(
          fontFamily: 'BeVietnamPro',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }
}
