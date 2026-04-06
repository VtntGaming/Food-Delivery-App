# Food Delivery App - Flutter Implementation Guide

## Project Structure (Clean Architecture)

```
lib/
├── config/
│   └── theme/
│       └── app_theme.dart          # Centralized theme and constants
├── features/
│   ├── food_detail/
│   │   ├── domain/
│   │   │   └── entities/
│   │   │       ├── food_item.dart
│   │   │       └── review.dart
│   │   └── presentation/
│   │       ├── pages/
│   │       │   └── food_detail_screen.dart
│   │       └── widgets/
│   │           ├── food_detail_header.dart
│   │           ├── food_info_section.dart
│   │           ├── description_section.dart
│   │           ├── reviews_section.dart
│   │           └── review_card.dart
│   ├── favorites/
│   │   ├── domain/
│   │   │   └── entities/
│   │   │       └── favorite_item.dart
│   │   └── presentation/
│   │       ├── pages/
│   │       │   └── favorites_screen.dart
│   │       └── widgets/
│   │           ├── favorites_app_bar.dart
│   │           └── favorite_item_card.dart
│   └── reviews/
│       ├── domain/
│       │   └── entities/
│       │       └── user_review.dart
│       └── presentation/
│           ├── pages/
│           │   └── reviews_screen.dart
│           └── widgets/
│               ├── reviews_app_bar.dart
│               └── user_review_card.dart
└── main.dart                        # Example usage & navigation
```

## Features

### 1. Food Detail Screen (Chi tiết món ăn)
- Product image with favorite button
- Rating and review count
- Product name and price
- Description with "Xem Thêm" expand functionality
- Latest reviews display
- Responsive layout with proper spacing

**File:** `features/food_detail/presentation/pages/food_detail_screen.dart`

### 2. Favorites List Screen (Danh sách yêu thích)
- Header with dark blue background
- List of favorite items with:
  - Thumbnail image
  - Name and price
  - Star rating
  - View details button
  - Delete functionality
- Empty state handling

**File:** `features/favorites/presentation/pages/favorites_screen.dart`

### 3. My Reviews Screen (Đánh giá của bạn)
- Header with dark blue background
- List of user reviews with:
  - Restaurant name
  - Star rating
  - Review comment
  - Edit and Delete buttons
  - Review date
- Empty state handling

**File:** `features/reviews/presentation/pages/reviews_screen.dart`

## Design System

### Colors (from AppTheme)
- **Primary:** Deep Purple
- **Accent:** #FFA000 (Orange)
- **Error:** #FF4D4F (Red)
- **Dark Header:** #000080 (Navy Blue)
- **Text Dark:** #333333
- **Text Light:** #555555
- **Border:** #D1D5DB

### Typography
- **Font Families:** Inter, BeVietnamPro
- **Title Large Bold:** 30px Bold
- **Title Medium Bold:** 20px Bold
- **Body Large:** 20px Regular
- **Body Small:** 14px Regular

### Spacing Constants
- `paddings16`: 16px
- `paddings12`: 12px
- `paddings8`: 8px
- `paddings4`: 4px

### Border Radius
- `radius8`: 8px
- `radius12`: 12px

## Widget Reusability

### Reusable Components
1. **FoodDetailHeader** - Displays food image with overlap buttons
2. **ReviewCard** - Shows individual review with rating
3. **FavoriteItemCard** - Displays favorite item with action buttons
4. **UserReviewCard** - Shows user's review with edit/delete options

### Usage Example
```dart
// Food Detail Screen
FoodDetailScreen(
  foodItem: FoodItem(
    id: '1',
    name: 'Phở Tái',
    imageUrl: 'https://...',
    price: 70000,
    rating: 4.5,
    reviewCount: 120,
    description: '...',
    reviews: [...]
  ),
)

// Favorites Screen
FavoritesScreen(
  favorites: [
    FavoriteItem(
      id: '1',
      name: 'Pizza',
      imageUrl: '...',
      price: 250000,
      rating: 4.5,
    ),
    // ...
  ],
)

// Reviews Screen
ReviewsScreen(
  reviews: [
    UserReview(
      id: '1',
      restaurantName: 'Phở bò - Bếp Cương Quán',
      rating: 4,
      comment: 'Ngon!',
      date: '12/03/2026',
    ),
    // ...
  ],
)
```

## Key Features Implemented

✅ Clean Architecture with domain entities  
✅ Const constructors for performance  
✅ Proper widget tree separation  
✅ Consistent spacing using AppTheme constants  
✅ Centralized color and typography management  
✅ Responsive design handling  
✅ No hardcoded values  
✅ Empty state handling  
✅ Proper error handling for images  
✅ State management with StatefulWidget  

## Integration Steps

1. **Add Assets** - Update `pubspec.yaml` with any required fonts
2. **Connect Data Layer** - Replace sample data with API calls
3. **Add Navigation** - Integrate with your app's routing
4. **Connect States** - Use Provider, Riverpod, or BLoC for state management
5. **Implement API** - Connect to your backend endpoints

## Responsive Design

All screens are designed to:
- Handle various screen sizes
- Use `SingleChildScrollView` for overflow prevention
- Implement `ListView.separated` for lists
- Use `Expanded` and `Flexible` widgets appropriately

## Best Practices Applied

- ✅ Each widget has a single responsibility
- ✅ Separation of concerns (domain, presentation)
- ✅ Theme tokens centralized in `AppTheme`
- ✅ Proper use of const constructors
- ✅ Safe network image loading with error builders
- ✅ Consistent naming conventions
- ✅ Clean and readable code structure
