# Flutter Food Delivery App - Screen Implementation

Production-ready Flutter screens for Food Delivery Application with Clean Architecture.

## 📁 Project Structure

```
lib/
├── config/
│   └── theme/
│       └── app_theme.dart          # Centralized theme, colors, spacing, typography
├── models/
│   └── order_model.dart             # Order, OrderDetail, Notification models with extensions
├── screens/
│   ├── notifications_empty_screen.dart
│   ├── notifications_screen.dart
│   ├── order_history_empty_screen.dart
│   ├── order_history_screen.dart
│   ├── order_detail_screen.dart
│   ├── demo_navigation_page.dart    # Demo/test page showing all screens
│   └── [other screens]
├── widgets/
│   └── common_widgets.dart           # Reusable UI components
├── services/
│   └── navigation_service.dart       # Navigation management
└── main.dart                         # App entry point
```

## 🎨 Screens Implemented

### 1. **Notifications Screen - Empty State** (notifications_empty_screen.dart)
- Figma Node: 274:1410
- Empty state with message "Bạn không có thông báo mới."
- Header with back button and action menu
- Mark all as read button

### 2. **Notifications Screen** (notifications_screen.dart)
- Figma Node: 198:4
- Displays list of notifications with read/unread status
- Notification items show title, message, and timestamp
- Mark all as read functionality
- Notification type detection (delivery, promo, etc.)

### 3. **Order History - Empty State** (order_history_empty_screen.dart)
- Figma Node: 274:1209
- Tab navigation (Đang giao, Đã giao, Giỏ hàng)
- Empty state message with shopping icon
- Clear history button in header

### 4. **Order History Screen** (order_history_screen.dart)
- Figma Node: 198:2
- Tab-based filtering by order status
- Order items with restaurant name, ID, date, and view details link
- Responsive list view
- Clear history with confirmation dialog

### 5. **Order Detail Screen** (order_detail_screen.dart)
- Figma Node: 198:3
- Comprehensive order information display
- Delivery address section with location and recipient info
- Order items with description
- Price summary (food price, shipping, total)
- Notes section with text input
- Action buttons (Rate, Reorder)
- Scrollable content for responsive design

## 🏗️ Architecture

### Clean Architecture Principles
```
Presentation Layer (Screens & Widgets)
            ↓
Business Logic Layer (Models & Extensions)
            ↓
Data Layer (Services & Models)
```

### Design Patterns Used
- **Widget Composition**: Large screens built from reusable widgets
- **Model Extensions**: Utility methods on models (formatting, filtering)
- **Singleton Services**: Navigation and data services
- **Const Constructors**: Optimized for performance
- **Theme Management**: Centralized styling

## 🎯 Key Features

### 1. Theme System (AppTheme)
```dart
// Centralized colors
AppTheme.primaryColor       // #003366
AppTheme.accentColor        // Navy with transparency
AppTheme.backgroundColor    // White
AppTheme.dividerColor       // Light gray

// Consistent spacing
AppTheme.spacingXXS through spacingXXL

// Typography styles
AppTheme.headerTitle
AppTheme.tabLabel
AppTheme.orderLabel
```

### 2. Reusable Widgets (common_widgets.dart)
- **AppHeader**: Consistent header for all screens
- **TabBar**: Custom tab navigation
- **EmptyStateWidget**: Empty state display
- **ActionButtonRow**: Primary/secondary button pairs
- **PriceInfoRow**: Price display with highlighting
- **InfoSection**: Information display with icon
- **NoteTextField**: Multi-line note input

### 3. Models with Extensions
```dart
// Order extensions
order.formattedDate         // "DD/MM/YYYY"
order.formattedPrice        // "XXXVND"
order.isDelivered           // Status check
order.isDelivering

// Notification extensions
notification.formattedDate  // Relative time ("2 hours ago")
notification.isDeliveryNotification
notification.isPromoNotification
```

### 4. Navigation Service
```dart
// Easy navigation throughout the app
ScreenNavigationService.navigateToOrderDetail(context, orderDetail)
ScreenNavigationService.navigateToOrderHistory(context)
ScreenNavigationService.navigateToNotifications(context)
```

## 📱 Responsive Design

All screens are responsive and handle:
- Different screen sizes (portrait/landscape)
- Long text content with ellipsis
- Safe area considerations
- SingleChildScrollView for overflow content
- Flexible layout components

## 🔧 Usage Example

```dart
import 'package:flutter/material.dart';
import 'screens/order_history_screen.dart';
import 'screens/order_detail_screen.dart';
import 'models/order_model.dart';

// Navigate to Order History
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const OrderHistoryScreen()),
);

// Navigate to Order Detail with data
final orderDetail = OrderDetail(
  order: Order(...),
  recipientName: 'Nguyen Van A',
  // ... more fields
);

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => OrderDetailScreen(orderDetail: orderDetail),
  ),
);
```

## 🎨 Customization

### Change Theme Colors
Edit `AppTheme` class in `app_theme.dart`:
```dart
static const Color primaryColor = Color(0xFF003366);
static const Color accentColor = Color.fromARGB(204, 0, 0, 128);
```

### Adjust Spacing
All spacing values are defined in `AppTheme`:
```dart
static const double spacingM = 16.0;
static const double spacingL = 24.0;
```

### Add New Text Styles
```dart
static TextStyle get customStyle => const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: textPrimary,
  fontFamily: 'BeVietnamPro',
);
```

## ✨ Best Practices Applied

- ✅ const constructors for performance
- ✅ Proper widget composition
- ✅ Consistent naming conventions
- ✅ Null safety throughout
- ✅ Meaningful variable/function names
- ✅ Centralized color/spacing management
- ✅ Extension methods for model utilities
- ✅ Scalable folder structure
- ✅ No hardcoded values
- ✅ Responsive layouts

## 📦 Dependencies
- `flutter` (latest stable)
- `flutter_localizations` (for multi-language support - future)

## 🚀 Getting Started

1. Copy all files to your Flutter project
2. Update `pubspec.yaml` if needed
3. Replace your main app navigation with these screens
4. Customize theme colors in `AppTheme`
5. Connect to your backend APIs

## 📝 Notes

- All screens include mock data for testing
- UI is responsive for all screen sizes
- Ready for integration with GetX/Provider state management
- Follows Material Design 3 guidelines
- Vietnamese UI text (easily translatable)

---

**Production Ready** ✓
**Clean Architecture** ✓
**Fully Responsive** ✓
**Theme Enabled** ✓
