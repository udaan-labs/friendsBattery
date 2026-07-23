import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;
import 'seller_dashboard_providers.dart';

class SellerDashboardController {
  final Ref ref;

  SellerDashboardController(this.ref);

  /// Pull-to-refresh: one parallel batch.
  /// Pending shipments derive from [sellerAllShipmentsProvider] — do not refresh twice.
  Future<void> refreshAllData() async {
    await Future.wait([
      _safeRefresh(sellerKpiProvider, 'KPIs'),
      _safeRefresh(sellerRecentInventoryProvider, 'Recent Inventory'),
      _safeRefresh(sellerAllShipmentsProvider, 'Shipments'),
    ]);
    // Derived pending list recomputes when all-shipments updates.
    ref.invalidate(sellerPendingShipmentsProvider);
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
