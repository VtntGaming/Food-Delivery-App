import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'presentation/admin_dashboard/pages/admin_dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery Admin',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const AdminDashboardPage(),
    );
  }
}

