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

final lowStockAlertsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return [
    {
      'product': 'Exide InvaTubular 150Ah',
      'stock': 5,
      'threshold': 10,
    },
    {
      'product': 'Amaron Go 35Ah',
      'stock': 2,
      'threshold': 5,
    },
    {
      'product': 'Luminous RedCharge 150Ah',
      'stock': 8,
      'threshold': 15,
    },
  ];
});

final recentActivityProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return [
    {
      'title': 'New seller registered',
      'subtitle': 'Kumar Auto Electricals joined',
      'time': '10:30 AM',
      'icon': 'person_add',
      'color': 0xFF006B2C,
    },
    {
      'title': 'Stock updated',
      'subtitle': 'Added 50 units of Exide 150Ah',
      'time': '09:15 AM',
      'icon': 'inventory_2',
      'color': 0xFF006E1C,
    },
    {
      'title': 'Order delivered',
      'subtitle': 'Order #4892 completed',
      'time': 'Yesterday',
      'icon': 'local_shipping',
      'color': 0xFF3E4A3D,
    },
  ];
});
