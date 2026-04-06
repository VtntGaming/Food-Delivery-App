import 'package:flutter/material.dart';
import 'config/theme/app_theme.dart';
import 'features/food_detail/presentation/pages/food_detail_screen.dart';
import 'features/food_detail/domain/entities/food_item.dart';
import 'features/food_detail/domain/entities/review.dart';
import 'features/favorites/presentation/pages/favorites_screen.dart';
import 'features/favorites/domain/entities/favorite_item.dart';
import 'features/reviews/presentation/pages/reviews_screen.dart';
import 'features/reviews/domain/entities/user_review.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Delivery App'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailScreen(
                      foodItem: _getSampleFoodItem(),
                    ),
                  ),
                );
              },
              child: const Text('Food Detail Screen'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesScreen(
                      favorites: _getSampleFavorites(),
                    ),
                  ),
                );
              },
              child: const Text('Favorites Screen'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewsScreen(
                      reviews: _getSampleReviews(),
                    ),
                  ),
                );
              },
              child: const Text('Reviews Screen'),
            ),
          ],
        ),
      ),
    );
  }

  FoodItem _getSampleFoodItem() {
    return FoodItem(
      id: '1',
      name: 'Phở Tái',
      imageUrl:
          'https://images.unsplash.com/photo-1520072959219-c595dc870360?w=500&q=80',
      price: 70000,
      rating: 4.5,
      reviewCount: 120,
      description:
          'Phở bò truyền thống với nước dùng ninh 12 giờ. Thịt bò tươi ngon, noodles dai mềm vừa phải. Một tô phở hoàn hảo cho bữa ăn sáng hoặc trưa.',
      reviews: [
        Review(
          id: '1',
          authorName: 'Nguyễn Văn A',
          rating: 4,
          comment: 'Ngon cực, nước dùng đậm vị!',
        ),
        Review(
          id: '2',
          authorName: 'Trần Thị B',
          rating: 3,
          comment: 'Giá hơi cao.',
        ),
      ],
    );
  }

  List<FavoriteItem> _getSampleFavorites() {
    return [
      FavoriteItem(
        id: '1',
        name: 'Pizza',
        imageUrl:
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&q=80',
        price: 250000,
        rating: 4.5,
      ),
      FavoriteItem(
        id: '2',
        name: 'Hamburger',
        imageUrl:
            'https://images.unsplash.com/photo-1550547990-5343a03be7f3?w=300&q=80',
        price: 50000,
        rating: 3.5,
      ),
    ];
  }

  List<UserReview> _getSampleReviews() {
    return [
      UserReview(
        id: '1',
        restaurantName: 'Phở bò - Bếp Cương Quán',
        rating: 4,
        comment: 'Món ăn ngon, nước dùng đậm đà!',
        date: '12/03/2026',
      ),
      UserReview(
        id: '2',
        restaurantName: 'Bún bò Huế - Huế Xưa',
        rating: 5,
        comment: 'Nước dùng đậm đà!',
        date: '21/03/2026',
      ),
      UserReview(
        id: '3',
        restaurantName: 'Khô gà - Mi Xê',
        rating: 2,
        comment: 'Ít, nhiều lá chanhchanh, vị nhạt',
        date: '01/04/2026',
      ),
    ];
  }
}
