import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/main.dart';

void main() {
  testWidgets('App launches without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const FoodDeliveryApp());
    await tester.pump();
    expect(find.byType(FoodDeliveryApp), findsOneWidget);
  });
}
