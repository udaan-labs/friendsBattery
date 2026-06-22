import 'package:friends_battery_api/friends_battery_api.dart';

class DashboardStats {
  final int totalStock;
  final int todaySales;
  final int pendingRequests;
  final int totalSellers;

  DashboardStats({
    required this.totalStock,
    required this.todaySales,
    required this.pendingRequests,
    required this.totalSellers,
  });

  factory DashboardStats.fromApi(ApiDashboardStatsGet200ResponseData data) {
    return DashboardStats(
      totalStock: data.totalStock?.toInt() ?? 0,
      todaySales: data.todaySales?.toInt() ?? 0,
      pendingRequests: data.pendingRequests?.toInt() ?? 0,
      totalSellers: data.totalSellers?.toInt() ?? 0,
    );
  }
}
