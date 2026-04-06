# Code Usage Guide

## Quick Start

### Basic Button Usage
```dart
import 'package:flutter/material.dart';
import 'config/exports.dart';
import 'presentation/exports.dart';

// Primary button
AppButton(
  label: 'Xác nhận',
  onPressed: () => print('Clicked'),
)

// Secondary button
AppButton(
  label: 'Hủy',
  onPressed: () {},
  backgroundColor: AppTheme.textGrey,
)

// Outlined button
AppButton(
  label: 'Tùy chọn',
  onPressed: () {},
  isOutlined: true,
  backgroundColor: AppTheme.accentOrange,
)

// Icon button
AppIconButton(
  icon: Icons.add,
  onPressed: () {},
  color: AppTheme.white,
  backgroundColor: AppTheme.accentOrange,
)
```

### Card Component
```dart
AppCard(
  padding: const EdgeInsets.all(AppTheme.md),
  backgroundColor: AppTheme.white,
  onTap: () => print('Card tapped'),
  child: Column(
    children: [
      Text('Card Title'),
      SizedBox(height: AppTheme.md),
      Text('Card content here'),
    ],
  ),
)
```

### Section Header
```dart
AppSectionHeader(
  title: 'Người Dùng',
  subtitle: 'Danh sách tất cả người dùng',
  onSeeAll: () => print('See all'),
  titleStyle: Theme.of(context).textTheme.headlineSmall,
)
```

### Empty State
```dart
AppEmptyState(
  message: 'Không có dữ liệu',
  icon: Icons.inbox_outlined,
  onRetry: () => _loadData(),
)
```

## Using Dashboard Components

### Statistics Card
```dart
StatisticCard(
  label: 'Tổng Người Dùng',
  value: '1,234',
  icon: Icons.people_outline,
  iconBackgroundColor: AppTheme.primaryDark,
)
```

### Timeline Card
```dart
TimelineCard(
  title: 'Đơn hàng mới',
  description: '12 đơn hàng được đặt hôm nay',
  date: 'Hôm nay lúc 10:30 AM',
)
```

## Using User Management

### Single User Display
```dart
UserListTile(
  user: UserModel(
    id: '1',
    name: 'Nguyễn Văn A',
    email: 'nguyenvana@gmail.com',
    role: 'Khách hàng',
  ),
  onEdit: () => _editUser(),
  onDelete: () => _deleteUser(),
)
```

### User List
```dart
UsersSection(
  users: _userList,
  onEditUser: () => _editUser(),
  onDeleteUser: () => _deleteUser(),
)
```

## Using Promotions

### Single Promotion
```dart
PromotionCard(
  promotion: PromotionModel(
    id: '1',
    code: 'GIAMX0K',
    discount: 'Giảm: 30000',
    validUntil: 'HSD: 2026-4-4',
    type: 'GIAMX0K',
  ),
  onDelete: () => _deletePromotion(),
)
```

### Promotion List
```dart
PromotionsSection(
  promotions: _promotionList,
  onDeletePromotion: () => _deletePromotion(),
  onAddPromotion: () => _addPromotion(),
)
```

## Using Favorites

### Single Favorite Item
```dart
FavoriteItemCard(
  item: FavoriteModel(
    id: '1',
    name: 'Bò ăn nhanh',
    imageUrl: 'https://example.com/image.jpg',
    category: 'Thức ăn nhanh',
  ),
  onDelete: () => _deleteFavorite(),
)
```

### Grid of Favorites
```dart
FavoritesGridView(
  items: _favoriteList,
  onDeleteFavorite: () => _deleteFavorite(),
  crossAxisCount: 2, // Adaptive based on screen
)
```

## Theme Usage

### Accessing Colors
```dart
Container(
  color: AppTheme.primaryDark,      // Main color
  child: Text(
    'Text',
    style: TextStyle(color: AppTheme.white),
  ),
)

// Accent colors
AppTheme.accentOrange    // For action buttons
AppTheme.accentRed       // For destructive actions
AppTheme.successGreen    // For positive actions

// Text colors
AppTheme.textDark        // Primary text
AppTheme.textGrey        // Secondary text
AppTheme.textLightGrey   // Tertiary text
```

### Using Spacing
```dart
// Always use theme spacing instead of hardcoding
Padding(
  padding: const EdgeInsets.all(AppTheme.md), // 16px
  child: Column(
    children: [
      Text('Item 1'),
      SizedBox(height: AppTheme.sm), // 8px
      Text('Item 2'),
    ],
  ),
)

// Spacing scale:
AppTheme.xs    // 4px - minimal spacing
AppTheme.sm    // 8px - small spacing
AppTheme.md    // 16px - medium spacing (most common)
AppTheme.lg    // 24px - large spacing
AppTheme.xl    // 32px - extra large
AppTheme.xxl   // 48px - huge
```

### Using Text Styles
```dart
Text(
  'Large Heading',
  style: Theme.of(context).textTheme.displayLarge,
)

Text(
  'Section Title',
  style: Theme.of(context).textTheme.headlineSmall,
)

Text(
  'Normal Body Text',
  style: Theme.of(context).textTheme.bodyMedium,
)

Text(
  'Small Caption',
  style: Theme.of(context).textTheme.bodySmall,
)
```

## Creating New Sections

### Step 1: Create folder structure
```
presentation/
└── new_feature/
    ├── pages/
    │   └── new_feature_page.dart
    └── widgets/
        └── new_feature_widgets.dart
```

### Step 2: Create models
```dart
class ItemModel {
  final String id;
  final String name;
  
  ItemModel({
    required this.id,
    required this.name,
  });
}
```

### Step 3: Create widgets
```dart
class ItemCard extends StatelessWidget {
  final ItemModel item;
  final VoidCallback? onTap;
  
  const ItemCard({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Text('Item: ${item.name}'),
    );
  }
}
```

### Step 4: Create page
```dart
class NewFeaturePage extends StatefulWidget {
  const NewFeaturePage({Key? key}) : super(key: key);

  @override
  State<NewFeaturePage> createState() => _NewFeaturePageState();
}

class _NewFeaturePageState extends State<NewFeaturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature Title'),
      ),
      body: const Center(
        child: Text('Content here'),
      ),
    );
  }
}
```

## Constants Usage

```dart
import 'config/constants.dart';

Text(AppConstants.dashboardTitle)    // 'Dashboard'
Text(AppConstants.usersTitle)         // 'Quản lý Người Dùng'
Text(AppConstants.promotionsTitle)    // 'Mã giảm giá'
Text(AppConstants.favoritesTitle)     // 'Danh mục'
```

## Best Practices

✅ **DO:**
- Use `const` constructors whenever possible
- Access theme values from `AppTheme`
- Use constants from `AppConstants`  
- Wrap widgets in `AppCard` for consistency
- Use `AppButton` for all buttons
- Create data models for entities

❌ **DON'T:**
- Hardcode colors directly
- Use magic numbers for spacing
- Create duplicate widgets
- Hardcode strings in UI
- Skip const constructors
- Mix different button styles

## Performance Tips

1. **Use const constructors** - Reduces widget rebuilds
2. **Avoid expensive operations in build()** - Use lifecycle methods
3. **Use ListView/GridView efficiently** - Keep itemBuilder simple
4. **Memoize expensive calculations** - Use models and caching
5. **Profile with Flutter DevTools** - Check for jank

## Responsive Breakpoints

```dart
final isMobile = MediaQuery.of(context).size.width < 600;
final isTablet = MediaQuery.of(context).size.width < 1024;

if (isMobile) {
  crossAxisCount = 2;
} else if (isTablet) {
  crossAxisCount = 3;
} else {
  crossAxisCount = 4;
}
```
