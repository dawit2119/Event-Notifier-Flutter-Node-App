import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets("The auth displayed as expected", (WidgetTester tester) async {
    await tester.pumpWidget(AppStarter());

    expect(find.text("Religious Daily Schedule Notifier"), findsOneWidget);
  });
}
