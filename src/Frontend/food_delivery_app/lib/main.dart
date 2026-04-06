import 'package:flutter/material.dart';
import 'config/app_theme.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/restaurant_detail_screen.dart';
import 'presentation/screens/search_screen.dart';

void main() {
  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(),
      routes: {
        '/search': (_) => const SearchScreen(),
        '/restaurant-detail': (_) => const RestaurantDetailScreen(),
      },
    );
  }
}
