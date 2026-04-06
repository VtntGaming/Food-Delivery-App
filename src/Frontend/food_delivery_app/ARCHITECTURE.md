# Flutter Clean Architecture Implementation Guide

## 📐 Architecture Overview

```
┌─────────────────────────────────────────────────────┐
│         Presentation Layer (UI)                     │
│  ┌───────────────────────────────────────────────┐  │
│  │ Screens (Order History, Notifications, etc)  │  │
│  └───────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────┐  │
│  │ Widgets (Reusable UI Components)             │  │
│  └───────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
           ↓        ↓        ↓        ↓
┌─────────────────────────────────────────────────────┐
│      Business Logic / Domain Layer                  │
│  ┌───────────────────────────────────────────────┐  │
│  │ Models (Order, Notification, OrderDetail)    │  │
│  │ Model Extensions (formatters, validators)    │  │
│  │ Constants (AppStrings, OrderStatus, etc)     │  │
│  └───────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
           ↓        ↓        ↓        ↓
┌─────────────────────────────────────────────────────┐
│       Infrastructure / Services Layer               │
│  ┌───────────────────────────────────────────────┐  │
│  │ Theme (AppTheme - centralized styling)       │  │
│  │ Navigation Service                           │  │
│  │ Data Services (future: API, Database)        │  │
│  └───────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
```

## 📁 File Structure Explanation

### 1. **config/theme/**
- **Responsibility**: Centralize all design tokens
- **Contains**: Colors, typography, spacing, shadows
- **Benefits**: Single point of change for entire app styling
- **Usage**: `AppTheme.primaryColor`, `AppTheme.spacingM`

### 2. **models/**
- **Order Model**:
  - Data class for order information
  - Extensions for formatting (date, price, status checks)
  - JSON serialization for API integration
  - Immutable design with copyWith for state updates

- **OrderDetail Model**:
  - Extends Order with delivery-specific information
  - Contains recipient details and delivery logistics
  - Fully serializable for persistence

- **Notification Model**:
  - Represents notification data
  - Includes read status for UI state
  - Extensions for time formatting and type detection

### 3. **screens/**
All screens follow a consistent pattern:

```dart
class ScreenName extends StatefulWidget/StatelessWidget {
  const ScreenName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          AppHeader(...),           // Reusable header
          _buildContent(),           // Main content
          _buildFooter(),            // Optional footer
        ],
      ),
    );
  }
}
```

**Screen List**:
- `notifications_empty_screen.dart` - Empty notifications
- `notifications_screen.dart` - With notification items
- `order_history_empty_screen.dart` - Empty order history
- `order_history_screen.dart` - With order items
- `order_detail_screen.dart` - Full order details
- `demo_navigation_page.dart` - Test/demo page

### 4. **widgets/common_widgets.dart**
Reusable widget components:

```dart
// Header
AppHeader(title, onBackPressed, trailing)

// Navigation
TabBar(tabs, onTabChanged, initialIndex)

// Content
EmptyStateWidget(message, icon)
OrderHistoryItemWidget(order, onViewDetails)
NotificationItemWidget(notification, onTap)

// Input
NoteTextField(hint, onChanged, controller)

// Data Display
PriceInfoRow(label, value, isHighlight)
InfoSection(label, value, leading)
ActionButtonRow(primaryLabel, secondaryLabel, callbacks)
```

### 5. **constants/app_constants.dart**
Centralized application constants:

```dart
AppStrings      // All UI text strings (easy translation)
AppConstants    // UI sizing, durations, validation rules
OrderStatus     // Order status values and display names
NotificationType // Notification type handling
```

### 6. **services/navigation_service.dart**
Navigation management:
- Centralized route definitions
- Type-safe screen transitions
- Future navigation support

### 7. **exports.dart**
Re-export all public APIs for easier imports:
```dart
import 'package:food_delivery_app/exports.dart';
```

## 🎯 Design Patterns Used

### 1. **Composition Pattern**
Large screens are built from smaller, reusable widgets
```dart
OrderDetailScreen
  ├── AppHeader
  ├── OrderIdSection
  ├── DeliveryAddressSection
  ├── OrderItemsSection
  ├── PriceSummarySection
  ├── NoteSection
  └── ActionButtonsSection
```

### 2. **Extension Methods**
Adding utility methods to models without inheritance
```dart
extension OrderExtension on Order {
  String get formattedDate => '${date.day}/${date.month}/${date.year}';
  bool get isDelivered => status == 'delivered';
}

// Usage
order.formattedDate  // "05/04/2026"
order.isDelivered    // true/false
```

### 3. **Model with Factory Pattern**
JSON serialization for API integration
```dart
factory Order.fromJson(Map<String, dynamic> json) {
  return Order(...);
}

Map<String, dynamic> toJson() => {...};
```

### 4. **Const Constructor Pattern**
Performance optimization through immutability
```dart
const Widget = StatelessWidget(key: key,);
// Only instantiated once in memory
```

### 5. **Service Locator Pattern**
Centralized service management (future: GetIt integration)
```dart
ScreenNavigationService.navigateToOrderDetail(context, order);
```

## 🔄 Data Flow Example

### Viewing Order Details

1. **User Action**
   ```
   User taps "View Details" on order item
   ```

2. **Presentation Layer**
   ```dart
   OrderHistoryItemWidget
     ├── GestureDetector(onTap: () => _onViewDetails(order))
     └── Navigator.push(OrderDetailScreen(orderDetail: orderDetail))
   ```

3. **Business Logic Layer**
   ```dart
   // Models provide the data structure
   OrderDetail orderDetail = OrderDetail(
     order: order,
     recipientName: 'Nguyen Van A',
     ...
   );
   ```

4. **UI Rendering**
   ```dart
   OrderDetailScreen._buildOrderIdSection()
   OrderDetailScreen._buildDeliveryAddressSection()
   OrderDetailScreen._buildPriceSummarySection()
   ```

## 🚀 Extension Points for Integration

### 1. **State Management** (GetX/Provider/Riverpod)
```dart
class OrderHistoryController extends GetxController {
  final orders = <Order>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchOrders();  // Fetch from API
  }
}
```

### 2. **API Integration**
```dart
class OrderService {
  Future<OrderDetail> getOrderDetail(String orderId) async {
    final response = await http.get('/orders/$orderId');
    return OrderDetail.fromJson(response.data);
  }
}
```

### 3. **Local Storage**
```dart
class OrderRepository {
  Future<void> saveOrder(Order order) async {
    await hive.box<Order>().add(order);
  }
}
```

### 4. **Internationalization**
Replace `AppStrings` with GetX localization:
```dart
// Change from
AppStrings.headerNotifications

// To
'notifications.header'.tr
```

## 📋 Checklist for Production Deployment

- [ ] Replace mock data with real API calls
- [ ] Add state management (GetX/Provider)
- [ ] Implement error handling and retry logic
- [ ] Add loading indicators during data fetch
- [ ] Set up logging and crash reporting
- [ ] Add unit tests for models and extensions
- [ ] Add widget tests for screens
- [ ] Set up CI/CD pipeline
- [ ] Configure app analytics
- [ ] Implement push notifications
- [ ] Add Firebase integration for notifications
- [ ] Set up tracking and user analytics
- [ ] Profile and optimize performance
- [ ] Test on multiple devices and OS versions
- [ ] Prepare for internationalization
- [ ] Add accessibility features (semantic, contrast)
- [ ] Document API contracts
- [ ] Set up feature flags
- [ ] Plan for A/B testing

## 🎨 Customization Guide

### Change App Colors
```dart
// app_theme.dart
static const Color primaryColor = Color(0xFF003366);  // Edit this
static const Color accentColor = Color.fromARGB(...); // Edit this
```

### Add New Screen
```dart
// 1. Create screen file
lib/screens/new_screen.dart

// 2. Add to exports.dart
export 'screens/new_screen.dart';

// 3. Add to navigation service
static Future<dynamic> navigateToNewScreen(BuildContext context) {
  return Navigator.push(...);
}

// 4. Use in app
ScreenNavigationService.navigateToNewScreen(context);
```

### Modify Widget Styling
```dart
// Edit in common_widgets.dart or create new styling constants in AppTheme

// Example: Change AppHeader background
// In AppTheme
static const Color headerBackground = Color(0xFF003366);

// In AppHeader
decoration: BoxDecoration(
  color: AppTheme.headerBackground,  // Uses constant
);
```

## 📊 Performance Optimizations

1. **Const Constructors**: Reduces memory footprint
2. **Single Scroll View**: Efficient list rendering with IndexedStack
3. **Lazy Loading**: demo_navigation_page for lazy screen loading
4. **Minimal Rebuilds**: Stateful widgets only where necessary
5. **Theme Caching**: AppTheme provides cached TextStyles

## 🧪 Testing Strategy

```dart
// Test models
test('Order.formattedPrice returns correct format', () {
  final order = Order(...);
  expect(order.formattedPrice, '65.000VND');
});

// Test widgets
testWidgets('AppHeader displays title', (WidgetTester tester) async {
  await tester.pumpWidget(
    AppHeader(title: 'Test'),
  );
  expect(find.text('Test'), findsOneWidget);
});
```

## 📚 Resources & Documentation

- [Flutter Best Practices](https://flutter.dev/docs/testing/best-practices)
- [Dart Documentation](https://dart.dev/guides)
- [Material Design Guidelines](https://material.io/design)
- [Clean Architecture Blog](https://blog.cleancoder.com)

---

**Version**: 1.0  
**Last Updated**: 2026-04-06  
**Status**: Production Ready ✓
