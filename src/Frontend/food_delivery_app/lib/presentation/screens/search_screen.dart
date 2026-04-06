import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_spacing.dart';
import '../../data/models/restaurant_model.dart';
import '../../data/models/user_model.dart';
import '../widgets/address_header.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/app_search_bar.dart';
import '../widgets/restaurant_card.dart';
import 'restaurant_detail_screen.dart';

/// Restaurant search screen - shows a list of restaurants.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const _imageBaseUrl = 'https://www.figma.com/api/mcp/asset/';

  static const List<RestaurantModel> _restaurants = [
    RestaurantModel(
      id: '1',
      name: 'Mì cay SaSin Lê Văn Việt',
      imageUrl: '${_imageBaseUrl}5257ef81-4b0b-4803-a83d-3412aabae642',
    ),
    RestaurantModel(
      id: '2',
      name: 'Hồng Trà Ngô Gia Lê Văn Việt',
      imageUrl: '${_imageBaseUrl}b83163cb-f726-41d8-8ed5-68eb983ff370',
    ),
    RestaurantModel(
      id: '3',
      name: 'Phở Thìn Lò Đúc',
      imageUrl: '${_imageBaseUrl}76dd162c-da8a-47a7-86ee-62ba15a16d2e',
    ),
    RestaurantModel(
      id: '4',
      name: 'Cơm Gà Xối Mỡ 312',
      imageUrl: '${_imageBaseUrl}9dd60a01-876e-402a-8a02-d01112286353',
    ),
    RestaurantModel(
      id: '5',
      name: 'Mì Trộn Mẹ Xoài',
      imageUrl: '${_imageBaseUrl}5257ef81-4b0b-4803-a83d-3412aabae642',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
                    // Address
                    AddressHeader(address: UserModel.mockUser.address),
                    const SizedBox(height: AppSpacing.md),
                    // Search bar
                    AppSearchBar(
                      hintText: 'Tìm kiếm nhà hàng...',
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    // Section title
                    const Text(
                      'Nhà hàng gần bạn',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Restaurant list
                    ..._restaurants.map((restaurant) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: RestaurantCard(
                            restaurant: restaurant,
                            onTap: () => _navigateToDetail(context),
                          ),
                        )),
                    const SizedBox(height: AppSpacing.xl),
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

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RestaurantDetailScreen()),
    );
  }

  static void _noop(int _) {}
}
