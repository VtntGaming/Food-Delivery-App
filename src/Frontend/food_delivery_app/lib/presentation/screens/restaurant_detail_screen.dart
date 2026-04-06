import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_spacing.dart';
import '../../data/models/food_model.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/menu_item_card.dart';

/// Restaurant detail screen - shows restaurant info and menu items.
class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({super.key});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  static const _headerImageUrl =
      'https://www.figma.com/api/mcp/asset/5257ef81-4b0b-4803-a83d-3412aabae642';
  static const _foodImageBaseUrl =
      'https://www.figma.com/api/mcp/asset/';

  static const List<FoodModel> _menuItems = [
    FoodModel(
      id: '1',
      name: 'Mì kim chi thập cẩm',
      price: '70.000Đ',
      imageUrl: '${_foodImageBaseUrl}b83163cb-f726-41d8-8ed5-68eb983ff370',
    ),
    FoodModel(
      id: '2',
      name: 'Mì kim chi bò mỹ',
      price: '70.000Đ',
      imageUrl: '${_foodImageBaseUrl}76dd162c-da8a-47a7-86ee-62ba15a16d2e',
    ),
  ];

  static const String _restaurantName =
      'Mì cay SaSin Lê Văn Việt - 442 Lê Văn Việt';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppSpacing.detailHeaderHeight,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            _headerImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: AppColors.primaryOverlay,
                            ),
                          ),
                          Positioned(
                            top: AppSpacing.md,
                            left: AppSpacing.md,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.white.withValues(alpha: 0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: AppColors.textPrimary,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenHorizontal,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSpacing.md),
                          const Text(
                            _restaurantName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: 1.2,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          const Row(
                            children: [
                              Icon(Icons.restaurant_menu,
                                  color: AppColors.textPrimary, size: 28),
                              SizedBox(width: AppSpacing.md),
                              Text(
                                'Menu',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          ..._menuItems.map((food) => Padding(
                                padding:
                                    const EdgeInsets.only(bottom: AppSpacing.xxl),
                                child: MenuItemCard(
                                  food: food,
                                  onAdd: () {},
                                ),
                              )),
                          const SizedBox(height: AppSpacing.xl),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const AppBottomNavBar(
              currentIndex: 0,
              onTap: _noop,
            ),
          ],
        ),
      ),
    );
  }

  static void _noop(int _) {}
}
