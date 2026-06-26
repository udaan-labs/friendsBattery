import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';
import '../services/dashboard_api_service.dart';
import '../models/dashboard_stats.dart';

final dashboardApiServiceProvider = Provider<DashboardApiService>((ref) {
  final dio = ref.watch(apiClientProvider).dio;
  return DashboardApiService(dio: dio);
});

final kpiProvider = FutureProvider<DashboardStats>((ref) async {
  return ref.watch(dashboardApiServiceProvider).getDashboardStats();
});

/// Fetches real recent activity from GET /api/dashboard/recent-activity.
final recentActivityProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final dio = ref.watch(apiClientProvider).dio;
  final response = await dio.get('/api/dashboard/recent-activity');
  final body = response.data;
  final List<dynamic> rawList =
      (body is Map && body['data'] is List) ? body['data'] : (body is List ? body : []);

  return rawList.whereType<Map<String, dynamic>>().map((item) {
    // Convert ISO time to a human-readable relative string
    final isoTime = item['time'] as String? ?? '';
    String timeLabel = '';
    if (isoTime.isNotEmpty) {
      final dt = DateTime.tryParse(isoTime);
      if (dt != null) {
        final diff = DateTime.now().difference(dt);
        if (diff.inMinutes < 1) {
          timeLabel = 'Just now';
        } else if (diff.inMinutes < 60) {
          timeLabel = '${diff.inMinutes}m ago';
        } else if (diff.inHours < 24) {
          timeLabel = '${diff.inHours}h ago';
        } else {
          timeLabel = '${diff.inDays}d ago';
        }
      }
    }
    return {
      'title': item['title'] ?? '',
      'subtitle': item['subtitle'] ?? '',
      'time': timeLabel,
      'icon': item['icon'] ?? 'notifications',
    };
  }).toList();
});
