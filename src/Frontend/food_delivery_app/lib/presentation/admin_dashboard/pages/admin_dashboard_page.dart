import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/theme.dart';
import 'package:food_delivery_app/config/constants.dart';
import '../widgets/common/app_widgets.dart';
import '../widgets/dashboard/statistics_widgets.dart';
import '../widgets/users/user_widgets.dart';
import '../widgets/promotions/promotion_widgets.dart';
import '../widgets/favorites/favorite_widgets.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _currentIndex = 0;

  // Sample data
  late List<AdminUserModel> _users;
  late List<PromotionModel> _promotions;
  late List<FavoriteModel> _favorites;

  @override
  void initState() {
    super.initState();
    _initializeSampleData();
  }

  void _initializeSampleData() {
    _users = [
      AdminUserModel(
        id: '1',
        name: 'Nguyễn Văn A',
        email: 'nguyenvana@gmail.com',
        role: 'Vai trò: Khách hàng',
      ),
      AdminUserModel(
        id: '2',
        name: 'Lê Thị B',
        email: 'lethib@gmail.com',
        role: 'Vai trò: Chủ quán',
      ),
      AdminUserModel(
        id: '3',
        name: 'Trần Văn C',
        email: 'tranvanc@gmail.com',
        role: 'Vai trò: Khách hàng',
      ),
    ];

    _promotions = [
      PromotionModel(
        id: '1',
        code: 'GIAMX0K',
        discount: 'Giảm: 30000',
        validUntil: 'HSD: 2026-4-4',
        type: 'GIAMX0K',
      ),
      PromotionModel(
        id: '2',
        code: 'FREESHIP',
        discount: 'Giảm: 15000',
        validUntil: 'HSD: 2026-7-4',
        type: 'FREESHIP',
      ),
      PromotionModel(
        id: '3',
        code: 'GIAMX0K',
        discount: 'Giảm: 100k',
        validUntil: 'HSD: 2026-4-25',
        type: 'GIAMX0K',
      ),
    ];

    _favorites = [
      FavoriteModel(
        id: '1',
        name: 'Bò ăn nhanh',
        imageUrl: '',
        category: 'Thức ăn nhanh',
      ),
      FavoriteModel(
        id: '2',
        name: 'Lẩu',
        imageUrl: '',
        category: 'Nhà hàng',
      ),
      FavoriteModel(
        id: '3',
        name: 'Trà Sữa',
        imageUrl: '',
        category: 'Đồ uống',
      ),
      FavoriteModel(
        id: '4',
        name: 'Pizza',
        imageUrl: '',
        category: 'Ý',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final crossAxisCount = isMobile ? 2 : 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.dashboardTitle),
        elevation: 0,
      ),
      body: _buildBody(crossAxisCount),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBody(int crossAxisCount) {
    switch (_currentIndex) {
      case 0:
        return _buildDashboardTab();
      case 1:
        return _buildUsersTab();
      case 2:
        return _buildPromotionsTab();
      case 3:
        return _buildFavoritesTab(crossAxisCount);
      default:
        return _buildDashboardTab();
    }
  }

  Widget _buildDashboardTab() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final crossAxisCount = isMobile ? 3 : 4;

    return SingleChildScrollView(
      child: Column(
        children: [
          DashboardSection(
            title: AppConstants.dashboardSubtitle,
            padding: const EdgeInsets.all(AppTheme.md),
            children: [
              GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppTheme.md,
                crossAxisSpacing: AppTheme.md,
                childAspectRatio: 0.8, // Giảm tỷ lệ để có thêm chiều cao, tránh overflow
                children: [
                  StatisticCard(
                    label: AppConstants.totalUsers,
                    value: '1,234',
                    icon: Icons.people_outline,
                    iconBackgroundColor: AppTheme.primaryDark,
                  ),
                  StatisticCard(
                    label: AppConstants.totalRestaurants,
                    value: '567',
                    icon: Icons.store_outlined,
                    iconBackgroundColor: AppTheme.accentOrange,
                  ),
                  StatisticCard(
                    label: AppConstants.totalOrders,
                    value: '8,901',
                    icon: Icons.receipt_outlined,
                    iconBackgroundColor: AppTheme.successGreen,
                  ),
                ],
              ),
            ],
          ),
          DashboardSection(
            title: 'Thống kê gần đây',
            padding: const EdgeInsets.all(AppTheme.md),
            children: [
              TimelineCard(
                title: 'Đơn hàng mới',
                description: '12 đơn hàng được đặt hôm nay',
                date: 'Hôm nay lúc 10:30 AM',
              ),
              const SizedBox(height: AppTheme.md),
              TimelineCard(
                title: 'Người dùng mới',
                description: '5 người dùng mới đăng ký',
                date: 'Hôm nay lúc 08:15 AM',
              ),
              const SizedBox(height: AppTheme.md),
              TimelineCard(
                title: 'Nhà hàng mới',
                description: '2 nhà hàng mới được thêm',
                date: 'Hôm qua lúc 03:45 PM',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUsersTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSectionHeader(
              title: AppConstants.usersTitle,
              subtitle: AppConstants.userListSubtitle,
            ),
            const SizedBox(height: AppTheme.lg),
            UsersSection(
              users: _users,
              onEditUser: () => _showSnackbar('Chỉnh sửa người dùng'),
              onDeleteUser: () => _showSnackbar('Xóa người dùng'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionsTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSectionHeader(
              title: AppConstants.promotionsTitle,
              subtitle: AppConstants.promotionListSubtitle,
            ),
            const SizedBox(height: AppTheme.lg),
            PromotionsSection(
              promotions: _promotions,
              onDeletePromotion: () => _showSnackbar('Xóa khuyến mãi'),
              onAddPromotion: () => _showSnackbar('Thêm khuyến mãi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesTab(int crossAxisCount) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final gridCount = isMobile ? 2 : 3;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSectionHeader(
              title: AppConstants.favoritesTitle,
              subtitle: AppConstants.favoriteSubtitle,
            ),
            const SizedBox(height: AppTheme.lg),
            FavoritesSection(
              items: _favorites,
              onDeleteFavorite: () => _showSnackbar('Xóa yêu thích'),
              crossAxisCount: gridCount,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: 'Bảng Điều Khiển',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Người Dùng',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_offer_outlined),
          activeIcon: Icon(Icons.local_offer),
          label: 'Danh mục',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          activeIcon: Icon(Icons.favorite),
          label: 'Yêu thích',
        ),
      ],
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppTheme.md),
        backgroundColor: AppTheme.primaryDark,
      ),
    );
  }
}
