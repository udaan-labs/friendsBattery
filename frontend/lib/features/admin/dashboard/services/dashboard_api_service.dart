import 'package:friends_battery_api/friends_battery_api.dart';
import '../models/dashboard_stats.dart';

/// Admin dashboard HTTP via generated OpenAPI client only (no raw Dio).
class DashboardApiService {
  final FriendsBatteryApi _api;

  DashboardApiService({required FriendsBatteryApi api}) : _api = api;

  DashboardApi get _dashboard => _api.getDashboardApi();

  Future<DashboardStats> getDashboardStats() async {
    try {
      final response = await _dashboard.apiDashboardStatsGet();
      final d = response.data?.data;
      if (d == null) {
        throw Exception(response.data?.message ?? 'Failed to load dashboard stats');
      }
      return DashboardStats(
        totalStock: d.totalStock ?? 0,
        todaySales: d.todaySales ?? 0,
        pendingRequests: d.pendingRequests ?? 0,
        totalSellers: d.totalSellers ?? 0,
        pendingShipments: d.pendingShipments ?? 0,
      );
    } catch (e) {
      throw Exception('Failed to load dashboard stats: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getRecentActivity() async {
    final response = await _dashboard.apiDashboardRecentActivityGet();
    final rows = response.data?.data?.toList() ?? [];
    return rows
        .map(
          (item) => {
            'title': item.title ?? '',
            'subtitle': item.subtitle ?? '',
            'time': item.time ?? '',
            'icon': item.icon ?? 'notifications',
          },
        )
        .toList();
  }

  Future<({List<Map<String, dynamic>> items, bool hasNextPage})> getActivityHistory(
    int page,
    int limit,
  ) async {
    final response = await _dashboard.apiDashboardActivityHistoryGet(
      page: page,
      limit: limit,
    );
    final body = response.data;
    final rows = body?.data?.toList() ?? [];
    final items = rows
        .map(
          (item) => {
            'title': item.title ?? '',
            'subtitle': item.subtitle ?? '',
            'time': item.time ?? '',
            'icon': item.icon ?? 'notifications',
          },
        )
        .toList();
    final hasNextPage = body?.pagination?.hasNextPage ?? false;
    return (items: items, hasNextPage: hasNextPage);
  }
}
