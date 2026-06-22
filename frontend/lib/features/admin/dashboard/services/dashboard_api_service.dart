import 'package:friends_battery_api/friends_battery_api.dart';
import '../models/dashboard_stats.dart';

class DashboardApiService {
  final DashboardApi api;

  DashboardApiService({required this.api});

  Future<DashboardStats> getDashboardStats() async {
    try {
      final response = await api.apiDashboardStatsGet();
      
      final data = response.data;
      if (data != null && data.success == true && data.data != null) {
        return DashboardStats.fromApi(data.data!);
      }
      
      throw Exception(data?.message ?? 'Failed to load dashboard stats');
    } catch (e) {
      throw Exception('Failed to load dashboard stats: $e');
    }
  }
}
