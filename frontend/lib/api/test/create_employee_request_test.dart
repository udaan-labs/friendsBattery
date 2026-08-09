import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

// tests for CreateEmployeeRequest
void main() {
  final instance = CreateEmployeeRequestBuilder();
  // TODO add properties to the builder and call build()

  group(CreateEmployeeRequest, () {
    // String userId
    test('to test the property `userId`', () async {
      // TODO
    });

    // String username
    test('to test the property `username`', () async {
      // TODO
    });

    // 10-digit mobile
    // String userNumber
    test('to test the property `userNumber`', () async {
      // TODO
    });

    // String password
    test('to test the property `password`', () async {
      // TODO
    });

    // Optional job title id from GET /api/shops/employee-roles
    // int employeeRoleId
    test('to test the property `employeeRoleId`', () async {
      // TODO
    });

    // Required for admin (warehouse or shop). Ignored for seller.
    // int locationId
    test('to test the property `locationId`', () async {
      // TODO
    });

  });
}
