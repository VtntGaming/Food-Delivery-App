import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FoodDeliveryApp());
    expect(find.text('Lê Thanh Lộc'), findsOneWidget);
  });
}
