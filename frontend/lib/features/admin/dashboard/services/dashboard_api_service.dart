import 'package:dio/dio.dart';
import '../models/dashboard_stats.dart';

class DashboardApiService {
  final Dio dio;

  DashboardApiService({required this.dio});

  Future<DashboardStats> getDashboardStats() async {
    try {
      final response = await dio.get('/api/dashboard/stats');
      final body = response.data;

      if (body is Map && body['success'] == true && body['data'] is Map) {
        final d = body['data'] as Map<String, dynamic>;
        return DashboardStats(
          totalStock: (d['totalStock'] ?? 0) as int,
          todaySales: (d['todaySales'] ?? 0) as int,
          pendingRequests: (d['pendingRequests'] ?? 0) as int,
          totalSellers: (d['totalSellers'] ?? 0) as int,
          pendingShipments: (d['pendingShipments'] ?? 0) as int,
        );
      }

      throw Exception(body['message'] ?? 'Failed to load dashboard stats');
    } catch (e) {
      throw Exception('Failed to load dashboard stats: $e');
    }
  }
}

