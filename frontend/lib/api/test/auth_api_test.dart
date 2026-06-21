import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for AuthApi
void main() {
  final instance = FriendsBatteryApi().getAuthApi();

  group(AuthApi, () {
    // Activate and verify a user account
    //
    //Future apiAuthActivatePut(ApiAuthActivatePutRequest apiAuthActivatePutRequest) async
    test('test apiAuthActivatePut', () async {
      // TODO
    });

    // Authenticate user and return token
    //
    //Future apiAuthLoginPost(ApiAuthLoginPostRequest apiAuthLoginPostRequest) async
    test('test apiAuthLoginPost', () async {
      // TODO
    });

    // Register a new user
    //
    //Future apiAuthRegisterPost(ApiAuthRegisterPostRequest apiAuthRegisterPostRequest) async
    test('test apiAuthRegisterPost', () async {
      // TODO
    });

  });
}
