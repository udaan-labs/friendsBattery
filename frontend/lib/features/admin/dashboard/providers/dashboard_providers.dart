import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';
import '../services/dashboard_api_service.dart';

final dashboardApiServiceProvider = Provider<DashboardApiService>((ref) {
  return DashboardApiService(api: ref.watch(apiClientProvider));
});

final kpiProvider = FutureProvider<AdminDashboardStats>((ref) async {
  return ref.watch(dashboardApiServiceProvider).getDashboardStats();
});

/// GET /api/dashboard/recent-activity — OpenAPI [ActivityItem] list.
final recentActivityProvider = FutureProvider<List<ActivityItem>>((ref) async {
  return ref.watch(dashboardApiServiceProvider).getRecentActivity();
});

/// Pull-to-refresh for admin dashboard cards.
Future<void> refreshAdminDashboard(WidgetRef ref) async {
  await Future.wait([
    _safeRefresh(ref, kpiProvider, 'KPIs'),
    _safeRefresh(ref, recentActivityProvider, 'Recent Activity'),
  ]);
}

Future<void> _safeRefresh(WidgetRef ref, FutureProvider provider, String name) async {
  try {
    final _ = await ref.refresh(provider.future);
  } catch (e) {
    developer.log('Failed to refresh $name', error: e);
  }
}
