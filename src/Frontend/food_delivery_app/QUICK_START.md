# Implementation Quick Start Guide

## ⚡ 5-Minute Setup

### Step 1: Copy Files to Your Project
```bash
# Copy all files to your Flutter project
cp -r lib/* your_project/lib/
```

### Step 2: Update Imports
If your project has a different structure, update imports:
```dart
// Find & Replace
'package:food_delivery_app/' → 'package:your_app_name/'
```

### Step 3: Add to main.dart
```dart
import 'package:flutter/material.dart';
import 'exports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      theme: AppTheme.lightTheme,
      home: const DemoNavigationPage(), // Start with demo
      debugShowCheckedModeBanner: false,
    );
  }
}
```

### Step 4: Test
```bash
flutter pub get
flutter run
```

## 📦 Integration Checklist

### Immediate Tasks
- [ ] Copy all files to lib/
- [ ] Update package name in imports
- [ ] Run `flutter pub get`
- [ ] Test with demo navigation page

### Next Week Tasks
- [ ] Connect to API (replace mock data)
- [ ] Integrate GetX/Provider for state management
- [ ] Add error handling and loading states
- [ ] Write tests

### Sprint Tasks
- [ ] Implement search functionality
- [ ] Add filters to order history
- [ ] Enable push notifications
- [ ] Add analytics tracking

## 🔌 API Integration Example

### 1. Create Data Service
```dart
// lib/services/order_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/order_model.dart';

class OrderService {
  static const String baseUrl = 'https://api.example.com';

  Future<List<Order>> getOrders() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orders'),
      );
      
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((json) => Order.fromJson(json)).toList();
      }
      throw Exception('Failed to load orders');
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<OrderDetail> getOrderDetail(String orderId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orders/$orderId'),
      );
      
      if (response.statusCode == 200) {
        return OrderDetail.fromJson(jsonDecode(response.body)['data']);
      }
      throw Exception('Failed to load order detail');
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
```

### 2. Update Screen with State Management (GetX)
```dart
// lib/controllers/order_controller.dart
import 'package:get/get.dart';
import '../services/order_service.dart';
import '../models/order_model.dart';

class OrderController extends GetxController {
  final orderService = OrderService();
  
  final orders = <Order>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() async {
    try {
      isLoading.value = true;
      orders.value = await orderService.getOrders();
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
```

### 3. Update Screen to Use Controller
```dart
// Update OrderHistoryScreen
class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({Key? key}) : super(key: key);
  
  final controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppHeader(...),
          _buildTabBar(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              }

              final orders = _getFilteredOrders();
              
              if (orders.isEmpty) {
                return const EmptyStateWidget(...);
              }

              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderHistoryItemWidget(
                    order: orders[index],
                    onViewDetails: () => _onViewDetails(orders[index]),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
```

## 🎯 Common Tasks

### Task 1: Change Header Color
```dart
// app_theme.dart
static const Color primaryColor = Color(0xFF1E88E5); // Changed from 0xFF003366
```

### Task 2: Add New Tab to Order History
```dart
// In _tabs list
final _tabs = ['Đang giao', 'Đã giao', 'Yêu thích', 'Hủy'];

// In _activeTabIndex switch
case 2:
  return _orders.where((o) => o.isFavorite).toList();
case 3:
  return _orders.where((o) => o.isCancelled).toList();
```

### Task 3: Customize Empty Message
```dart
// In app_constants.dart
static const String emptyOrderHistory =
  'Bạn chưa có đơn hàng nào.\nMua sắm ngay để hưởng các ưu đãi độc quyền.';

// Change to:
static const String emptyOrderHistory =
  'Không có đơn hàng\n👉 Bắt đầu mua hàng ngay!';
```

### Task 4: Add Loading State to Screen
```dart
// Wrap with FutureBuilder or Obx
Obx(() {
  if (controller.isLoading.value) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  return _buildContent();
})
```

## 📱 Platform-Specific Setup

### iOS Setup
```bash
cd ios
pod install
cd ..
```

### Android Setup
```bash
# Ensure minSdkVersion >= 21 in android/app/build.gradle
minSdkVersion 21
```

## 🧪 Testing the Screens

### Test 1: Empty States
1. Run the app
2. Go to Order History
3. Should see empty state message

### Test 2: Tab Navigation
1. Go to Order History (with items)
2. Click different tabs
3. List should filter correctly

### Test 3: Detail Navigation
1. Go to Order History
2. Click "View Details"
3. OrderDetailScreen should open with proper data

### Test 4: Responsive Layout
1. Test in portrait mode
2. Test in landscape mode
3. Text should not overflow
4. Layout should adapt properly

## 🚨 Troubleshooting

### Issue: Import Error
**Solution**: Ensure all files are in the correct directory and update package names

### Issue: Theme Not Applied
**Solution**: Make sure to set `theme: AppTheme.lightTheme` in MaterialApp

### Issue: Mock Data Not Showing
**Solution**: Check if screen is using mock data initialization (see _initializeOrders in code)

### Issue: Navigation Not Working
**Solution**: Ensure Navigator.push/pop is being called correctly with proper context

## 📚 Next Steps

1. **Replace Mock Data**: Update `_initializeOrders()` and `_initializeNotifications()` to fetch from API
2. **Add State Management**: Integrate GetX/Provider for state handling
3. **Implement Error Handling**: Add try-catch blocks around API calls
4. **Add Loading Indicators**: Show progress during data fetch
5. **Test on Real Devices**: Run on iOS and Android devices
6. **Connect to Backend**: Update API endpoints in service layer
7. **Deploy**: Follow Flutter deployment guide

## 🔗 Useful Links

- [Flutter Documentation](https://flutter.dev/docs)
- [GetX Documentation](https://github.com/jonataslaw/getx)
- [http Package](https://pub.dev/packages/http)
- [Material Design](https://material.io/design)

## 💡 Tips

1. **Use const everywhere**: Improves performance
2. **Extract methods**: Keep widgets under 300 lines
3. **Use extensions**: Add helper methods to models
4. **Theme first**: Define all colors/spacing in AppTheme
5. **Test early**: Test on multiple devices early

## 📞 Support

For issues or questions:
1. Check ARCHITECTURE.md for design patterns
2. Review SCREENS_README.md for screen details
3. Check code comments for implementation notes
4. Look at demo_navigation_page.dart for examples

---

**Happy Coding!** 🚀

Questions? Check the architecture documentation or review the code comments.
