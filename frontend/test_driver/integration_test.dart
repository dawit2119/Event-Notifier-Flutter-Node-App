// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    // final goLoginFinder = find.byValueKey('goLogin');
    // final goRegisterFinder = find.byValueKey('goRegister');
    final welcomeTextFinder = find.byValueKey('welcomeText');

    late FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      driver.close();
    });

    test('welcome text displayed', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(welcomeTextFinder),
          "Religious Daily Schedule Notifier");
    });
  });
}
