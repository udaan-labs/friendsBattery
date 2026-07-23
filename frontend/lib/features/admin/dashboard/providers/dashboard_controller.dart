import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;
import 'dashboard_providers.dart';

class DashboardController {
  final Ref ref;

  DashboardController(this.ref);

  /// Pull-to-refresh for the main dashboard cards only.
  /// Does not force-load View Stock (that is lazy via [adminStockDetailsProvider]).
  Future<void> refreshAllData() async {
    await Future.wait([
      _safeRefresh(kpiProvider, 'KPIs'),
      _safeRefresh(recentActivityProvider, 'Recent Activity'),
    ]);
  }

  Future<void> _safeRefresh(FutureProvider provider, String name) async {
    try {
      final _ = await ref.refresh(provider.future);
    } catch (e) {
      developer.log('Failed to refresh $name', error: e);
    }
  }
}

final dashboardControllerProvider = Provider<DashboardController>((ref) {
  return DashboardController(ref);
});
