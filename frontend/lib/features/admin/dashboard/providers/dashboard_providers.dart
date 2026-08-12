import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';
import '../../../shared/products/providers/product_catalog_providers.dart';

DashboardApi _dashboard(Ref ref) => ref.watch(apiClientProvider).getDashboardApi();

final kpiProvider = FutureProvider<AdminDashboardStats>((ref) async {
  final response = await _dashboard(ref).apiDashboardStatsGet();
  final d = response.data?.data;
  if (d == null) {
    throw Exception(response.data?.message ?? 'Failed to load dashboard stats');
  }
  return d;
});

/// GET /api/dashboard/recent-activity — OpenAPI [ActivityItem] list.
final recentActivityProvider = FutureProvider<List<ActivityItem>>((ref) async {
  final response = await _dashboard(ref).apiDashboardRecentActivityGet();
  return response.data?.data?.toList() ?? [];
});

/// Pull-to-refresh for admin dashboard cards.
Future<void> refreshAdminDashboard(WidgetRef ref) async {
  await Future.wait([
    _safeRefresh(ref, kpiProvider, 'KPIs'),
    _safeRefresh(ref, recentActivityProvider, 'Recent Activity'),
    _safeRefresh(ref, productNamesProvider, 'Products'),
  ]);
}

Future<void> _safeRefresh(WidgetRef ref, FutureProvider provider, String name) async {
  try {
    final _ = await ref.refresh(provider.future);
  } catch (e) {
    developer.log('Failed to refresh $name', error: e);
  }
}
