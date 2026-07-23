import 'package:friends_battery_api/friends_battery_api.dart';

/// Admin dashboard HTTP via generated OpenAPI client only (no raw Dio).
class DashboardApiService {
  final FriendsBatteryApi _api;

  DashboardApiService({required FriendsBatteryApi api}) : _api = api;

  DashboardApi get _dashboard => _api.getDashboardApi();

  Future<AdminDashboardStats> getDashboardStats() async {
    final response = await _dashboard.apiDashboardStatsGet();
    final d = response.data?.data;
    if (d == null) {
      throw Exception(response.data?.message ?? 'Failed to load dashboard stats');
    }
    return d;
  }

  Future<List<ActivityItem>> getRecentActivity() async {
    final response = await _dashboard.apiDashboardRecentActivityGet();
    return response.data?.data?.toList() ?? [];
  }

  Future<({List<ActivityItem> items, bool hasNextPage})> getActivityHistory(
    int page,
    int limit,
  ) async {
    final response = await _dashboard.apiDashboardActivityHistoryGet(
      page: page,
      limit: limit,
    );
    final body = response.data;
    return (
      items: body?.data?.toList() ?? [],
      hasNextPage: body?.pagination?.hasNextPage ?? false,
    );
  }
}
