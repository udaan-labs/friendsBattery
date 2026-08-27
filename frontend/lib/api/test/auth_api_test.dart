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
    // Works for SUPER_ADMIN, ADMIN, SELLER, and EMPLOYEE. EMPLOYEE login may include location / employee_role on user and session_id (employee_sessions). 
    //
    //Future<LoginResponse> apiAuthLoginPost(ApiAuthLoginPostRequest apiAuthLoginPostRequest) async
    test('test apiAuthLoginPost', () async {
      // TODO
    });

    // End session (closes employee_sessions for EMPLOYEE)
    //
    //Future apiAuthLogoutPost() async
    test('test apiAuthLogoutPost', () async {
      // TODO
    });

    // Register a new user
    //
    //Future<RegisterResponse> apiAuthRegisterPost(ApiAuthRegisterPostRequest apiAuthRegisterPostRequest) async
    test('test apiAuthRegisterPost', () async {
      // TODO
    });

  });
}
