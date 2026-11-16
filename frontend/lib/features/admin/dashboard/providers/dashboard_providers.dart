import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';
import '../../../../core/storage/swr_notifier.dart';
import '../../../shared/products/providers/product_catalog_providers.dart';

DashboardApi _dashboard(Ref ref) => ref.read(apiClientProvider).getDashboardApi();

final kpiProvider =
    StateNotifierProvider<SwrNotifier<AdminDashboardStats>, AsyncValue<AdminDashboardStats>>((ref) {
  ref.watch(apiClientProvider);
  return SwrNotifier(
    key: 'admin.kpi',
    encode: (stats) => standardSerializers.serializeWith(AdminDashboardStats.serializer, stats),
    decode: (json) => standardSerializers.deserializeWith(AdminDashboardStats.serializer, json),
    fetch: () async {
      final response = await _dashboard(ref).apiDashboardStatsGet();
      final data = response.data?.data;
      if (data == null) {
        throw Exception(response.data?.message ?? 'Failed to load dashboard stats');
      }
      return data;
    },
  );
});

/// GET /api/dashboard/recent-activity — OpenAPI [ActivityItem] list.
final recentActivityProvider =
    StateNotifierProvider<SwrNotifier<List<ActivityItem>>, AsyncValue<List<ActivityItem>>>((ref) {
  ref.watch(apiClientProvider);
  return SwrNotifier(
    key: 'admin.activity',
    encode: (items) => encodeBuiltList(
      items,
      (item) => standardSerializers.serializeWith(ActivityItem.serializer, item),
    ),
    decode: (json) => decodeBuiltList(
      json,
      (item) => standardSerializers.deserializeWith(ActivityItem.serializer, item),
    ),
    fetch: () async {
      final response = await _dashboard(ref).apiDashboardRecentActivityGet();
      return response.data?.data?.toList() ?? [];
    },
  );
});

/// Pull-to-refresh for admin dashboard cards.
Future<void> refreshAdminDashboard(WidgetRef ref) async {
  await Future.wait([
    ref.read(kpiProvider.notifier).reload(),
    ref.read(recentActivityProvider.notifier).reload(),
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
