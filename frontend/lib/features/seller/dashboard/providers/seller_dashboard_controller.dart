import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;
import 'seller_dashboard_providers.dart';

class SellerDashboardController {
  final Ref ref;

  SellerDashboardController(this.ref);

  Future<void> refreshAllData() async {
    await Future.wait([
      _safeRefresh(sellerInventoryProvider, 'Inventory'),
      _safeRefresh(sellerKpiProvider, 'KPIs'),
      _safeRefresh(sellerRecentInventoryProvider, 'Recent Inventory'),
      _safeRefresh(sellerPendingShipmentsProvider, 'Pending Shipments'),
    ]);
  }

  Future<void> _safeRefresh(FutureProvider provider, String name) async {
    try {
      final _ = await ref.refresh(provider.future);
    } catch (e) {
      developer.log('Failed to refresh seller $name', error: e);
    }
  }
}

final sellerDashboardControllerProvider = Provider<SellerDashboardController>((ref) {
  return SellerDashboardController(ref);
});
