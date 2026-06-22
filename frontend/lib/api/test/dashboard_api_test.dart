import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for DashboardApi
void main() {
  final instance = FriendsBatteryApi().getDashboardApi();

  group(DashboardApi, () {
    // Get dashboard statistics
    //
    // Retrieves total available stock, today's sales, pending seller requests, and total sellers. Only accessible by Admin users.
    //
    //Future<ApiDashboardStatsGet200Response> apiDashboardStatsGet() async
    test('test apiDashboardStatsGet', () async {
      // TODO
    });

  });
}
