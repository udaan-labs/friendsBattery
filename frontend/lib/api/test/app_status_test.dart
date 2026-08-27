import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

// tests for AppStatus
void main() {
  final instance = AppStatusBuilder();
  // TODO add properties to the builder and call build()

  group(AppStatus, () {
    // Expected client app version (semver, e.g. 1.1.3)
    // String latestVersion
    test('to test the property `latestVersion`', () async {
      // TODO
    });

    // When true, clients must show maintenance screen
    // bool maintenance
    test('to test the property `maintenance`', () async {
      // TODO
    });

    // Optional message for update or maintenance UI
    // String message
    test('to test the property `message`', () async {
      // TODO
    });

    // Play Store / APK URL for force-update button
    // String androidUpdateUrl
    test('to test the property `androidUpdateUrl`', () async {
      // TODO
    });

  });
}
