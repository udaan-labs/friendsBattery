import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';
import '../services/dashboard_api_service.dart';
import '../models/dashboard_stats.dart';

// Simulated API calls that take some time

final dashboardApiServiceProvider = Provider<DashboardApiService>((ref) {
  final api = ref.watch(apiClientProvider).getDashboardApi();
  return DashboardApiService(api: api);
});

final kpiProvider = FutureProvider<DashboardStats>((ref) async {
  return ref.watch(dashboardApiServiceProvider).getDashboardStats();
});


final recentActivityProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return [
    {
      'title': 'Stock assigned to Shop A',
      'subtitle': 'Exide InvaTubular 150Ah • 20 units',
      'time': 'Today, 10:30 AM',
      'icon': 'inventory_2',
      'color': 0xFF006B2C,
    },
  ];
});
