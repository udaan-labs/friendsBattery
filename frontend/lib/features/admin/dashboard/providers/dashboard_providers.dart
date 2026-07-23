import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';
import '../services/dashboard_api_service.dart';
import '../models/dashboard_stats.dart';

final dashboardApiServiceProvider = Provider<DashboardApiService>((ref) {
  return DashboardApiService(api: ref.watch(apiClientProvider));
});

final kpiProvider = FutureProvider<DashboardStats>((ref) async {
  final sw = Stopwatch()..start();
  final stats = await ref.watch(dashboardApiServiceProvider).getDashboardStats();
  sw.stop();
  assert(() {
    // ignore: avoid_print
    print('[PERF-PROVIDER] kpiProvider total=${sw.elapsedMilliseconds}ms');
    return true;
  }());
  return stats;
});

/// Fetches real recent activity from GET /api/dashboard/recent-activity.
final recentActivityProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final sw = Stopwatch()..start();
  final rawList = await ref.watch(dashboardApiServiceProvider).getRecentActivity();
  final networkMs = sw.elapsedMilliseconds;

  final parseSw = Stopwatch()..start();
  final mapped = rawList.map((item) {
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
  parseSw.stop();
  sw.stop();
  assert(() {
    // ignore: avoid_print
    print(
      '[PERF-PROVIDER] recentActivityProvider '
      'network+dio=${networkMs}ms parse=${parseSw.elapsedMilliseconds}ms '
      'total=${sw.elapsedMilliseconds}ms items=${mapped.length}',
    );
    return true;
  }());
  return mapped;
});
