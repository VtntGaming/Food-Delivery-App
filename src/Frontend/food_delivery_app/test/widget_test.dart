import 'package:flutter_test/flutter_test.dart';

import 'package:food_delivery_app/main.dart';

void main() {
  testWidgets('Address screen renders expected texts', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FoodDeliveryApp());
    await tester.pumpAndSettle();

    expect(find.text('Địa chỉ của tôi'), findsOneWidget);
    expect(find.text('Xác nhận'), findsOneWidget);
    expect(find.text('Nguyễn Văn A'), findsOneWidget);
  });
}
