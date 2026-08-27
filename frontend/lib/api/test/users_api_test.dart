import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for UsersApi
void main() {
  final instance = FriendsBatteryApi().getUsersApi();

  group(UsersApi, () {
    // List admins, sellers, and employees
    //
    // Super Admin only. Excludes SUPER_ADMIN. Optional role filter.
    //
    //Future<AccountUsersResponse> apiUsersGet({ String role }) async
    test('test apiUsersGet', () async {
      // TODO
    });

    // Activate or deactivate an admin, seller, or employee
    //
    // Super Admin only. Inactive users cannot log in or use the API. Cannot change self or SUPER_ADMIN.
    //
    //Future<SetAccountActiveResponse> apiUsersIdActivePatch(int id, SetAccountActiveRequest setAccountActiveRequest) async
    test('test apiUsersIdActivePatch', () async {
      // TODO
    });

  });
}
