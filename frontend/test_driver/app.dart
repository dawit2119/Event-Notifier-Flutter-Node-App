import 'package:flutter_driver/driver_extension.dart';
import 'package:frontend/main.dart' as app;
void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}

// this is the function which enabls the extension and runs the main function to the real device or emulator