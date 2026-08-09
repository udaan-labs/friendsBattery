import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

// tests for CreateLocationRequest
void main() {
  final instance = CreateLocationRequestBuilder();
  // TODO add properties to the builder and call build()

  group(CreateLocationRequest, () {
    // Unique location code (stored uppercase)
    // String code
    test('to test the property `code`', () async {
      // TODO
    });

    // String name
    test('to test the property `name`', () async {
      // TODO
    });

    // String type
    test('to test the property `type`', () async {
      // TODO
    });

    // String address
    test('to test the property `address`', () async {
      // TODO
    });

    // String phone
    test('to test the property `phone`', () async {
      // TODO
    });

    // Geofence center; required together with longitude
    // num latitude
    test('to test the property `latitude`', () async {
      // TODO
    });

    // Geofence center; required together with latitude
    // num longitude
    test('to test the property `longitude`', () async {
      // TODO
    });

    // Attendance radius in meters (default 100 when lat/lng set)
    // int allowedRadius
    test('to test the property `allowedRadius`', () async {
      // TODO
    });

  });
}
