import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for HealthApi
void main() {
  final instance = FriendsBatteryApi().getHealthApi();

  group(HealthApi, () {
    // Health check
    //
    //Future<HealthStatus> apiHealthGet() async
    test('test apiHealthGet', () async {
      // TODO
    });

  });
}
