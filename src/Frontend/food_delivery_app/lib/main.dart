import 'package:flutter/material.dart';

import 'app/order_flow_page.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery',
      theme: AppTheme.light,
      home: const OrderFlowPage(),
    );
  }
}
