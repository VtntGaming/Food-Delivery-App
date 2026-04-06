import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_spacing.dart';
import '../../data/models/food_model.dart';
import '../../data/models/user_model.dart';
import '../widgets/address_header.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/app_search_bar.dart';
import '../widgets/food_card.dart';
import '../widgets/promo_banner.dart';
import '../widgets/user_header.dart';
import 'restaurant_detail_screen.dart';
import 'search_screen.dart';

/// Home screen - main landing page of the food delivery app.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _bannerUrl =
      'https://www.figma.com/api/mcp/asset/1fdd11f2-b1d0-4597-b938-70330c3a8653';
  static const _avatarUrl =
      'https://www.figma.com/api/mcp/asset/0820b9a9-ae85-44fd-947c-68c0d9e63ccd';
  static const _foodImageBaseUrl =
      'https://www.figma.com/api/mcp/asset/';

  static const List<FoodModel> _foodItems = [
    FoodModel(
      id: '1',
      name: 'Mì kim chi thập cẩm',
      price: '75.000Đ',
      imageUrl: '${_foodImageBaseUrl}58afe9b7-e3e5-40a8-b4f5-6bd71f2778e5',
    ),
    FoodModel(
      id: '2',
      name: 'Phở bò',
      price: '50.000Đ',
      imageUrl: '${_foodImageBaseUrl}8ff4d9ea-6473-401d-a9cb-0bcf4637fb91',
    ),
    FoodModel(
      id: '3',
      name: 'Mì trộn thập cẩm',
      price: '40.000Đ',
      imageUrl: '${_foodImageBaseUrl}c7be5841-514b-4196-ad4c-6bbebec58d41',
    ),
    FoodModel(
      id: '4',
      name: 'Cơm gà xối mỡ',
      price: '45.000Đ',
      imageUrl: '${_foodImageBaseUrl}180e9112-47b5-4ea9-96be-56df55674475',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    // User header
                    UserHeader(
                      userName: UserModel.mockUser.name,
                      avatarUrl: _avatarUrl,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Address
                    AddressHeader(address: UserModel.mockUser.address),
                    const SizedBox(height: AppSpacing.sm),
                    // Search bar
                    AppSearchBar(
                      hintText: 'Tìm món ăn, tên quán...',
                      readOnly: true,
                      onTap: () => _navigateToSearch(context),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Promo banner
                    PromoBanner(
                      imageUrl: _bannerUrl,
                      onTap: () {},
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    // Section title
                    const Text(
                      'Món ngon gần bạn',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Food grid (2 columns)
                    _buildFoodGrid(),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
            AppBottomNavBar(
              currentIndex: 0,
              onTap: _onNavTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final halfWidth =
            (constraints.maxWidth - AppSpacing.md) / 2;
        return Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: _foodItems.map((food) {
            return SizedBox(
              width: halfWidth,
              child: FoodCard(
                food: food,
                onTap: () => _navigateToDetail(context),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _navigateToSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SearchScreen()),
    );
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RestaurantDetailScreen()),
    );
  }

  void _onNavTap(int index) {
    if (index == 1) {
      // Cart tab — placeholder
    } else if (index == 2) {
      // Orders tab — placeholder
    } else if (index == 3) {
      // Menu tab — placeholder
    }
  }
}
