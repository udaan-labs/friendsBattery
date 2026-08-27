import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for DashboardApi
void main() {
  final instance = FriendsBatteryApi().getDashboardApi();

  group(DashboardApi, () {
    // Get paginated activity history (Admin only)
    //
    //Future<ActivityHistoryResponse> apiDashboardActivityHistoryGet({ int page, int limit }) async
    test('test apiDashboardActivityHistoryGet', () async {
      // TODO
    });

    // Get recent activity feed (Admin only)
    //
    //Future<RecentActivityResponse> apiDashboardRecentActivityGet() async
    test('test apiDashboardRecentActivityGet', () async {
      // TODO
    });

    // Get dashboard statistics
    //
    // Retrieves total available stock, today's sales, pending seller requests, and total sellers. Only accessible by Admin users.
    //
    //Future<ApiDashboardStatsGet200Response> apiDashboardStatsGet() async
    test('test apiDashboardStatsGet', () async {
      // TODO
    });

    // Get seller dashboard statistics
    //
    // Retrieves total available stock and today's sales for the authenticated seller. Only accessible by Seller users.
    //
    //Future<ApiSellerDashboardStatsGet200Response> apiSellerDashboardStatsGet() async
    test('test apiSellerDashboardStatsGet', () async {
      // TODO
    });

  });
}
