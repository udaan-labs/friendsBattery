import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for AppApi
void main() {
  final instance = FriendsBatteryApi().getAppApi();

  group(AppApi, () {
    // App version + maintenance gate status
    //
    // Public endpoint for Flutter splash / app gate. Clients compare local version to `latest_version` and block on `maintenance`. 
    //
    //Future<AppStatusResponse> apiAppStatusGet() async
    test('test apiAppStatusGet', () async {
      // TODO
    });

  });
}
