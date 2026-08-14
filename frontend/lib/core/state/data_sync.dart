import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/admin/dashboard/providers/admin_stock_provider.dart';
import '../../features/admin/dashboard/providers/dashboard_providers.dart';
import '../../features/admin/sales/providers/admin_sales_history_provider.dart';
import '../../features/admin/sellers/providers/seller_details_provider.dart';
import '../../features/admin/sellers/providers/sellers_provider.dart';
import '../../features/admin/shipments/providers/shipment_provider.dart';
import '../../features/seller/dashboard/providers/seller_dashboard_providers.dart';
import '../../features/seller/sales/providers/seller_sales_provider.dart';
import '../../features/shared/inventory/providers/inventory_provider.dart';
import '../../features/shared/products/providers/product_catalog_providers.dart';

/// Central post-mutation cache invalidation for shared Riverpod sources of truth.
///
/// Prefer [invalidate] over [refresh] so watched screens refetch once and
/// unwatched providers stay cheap until the next [ref.watch].
/// Call these only after a successful server mutation.
class DataSync {
  DataSync._();

  /// Inventory quantities, prices, thresholds, or units changed.
  static void afterInventoryMutation(WidgetRef ref, {int? productId}) {
    ref.invalidate(sharedInventoryProvider);
    ref.invalidate(adminStockDetailsProvider);
    ref.invalidate(sellerRecentInventoryProvider);
    ref.invalidate(sellerKpiProvider);
    ref.invalidate(kpiProvider);
    ref.invalidate(recentActivityProvider);

    if (productId != null) {
      ref.invalidate(sharedInventoryProductDetailProvider(productId));
    } else {
      ref.invalidate(sharedInventoryProductDetailProvider);
    }
  }

  /// Same as [afterInventoryMutation] but awaits Super Admin list re-fetch.
  static Future<void> afterInventoryMutationAndRefresh(
    WidgetRef ref, {
    int? productId,
  }) async {
    afterInventoryMutation(ref, productId: productId);
    await Future.wait([
      _safeFuture(ref, sharedInventoryProvider),
      _safeFuture(ref, adminStockDetailsProvider),
      _safeFuture(ref, kpiProvider),
      _safeFuture(ref, recentActivityProvider),
    ]);
  }

  /// Product name/model created or product configuration saved.
  ///
  /// Invalidates catalog + inventory sources of truth, then awaits a re-fetch
  /// of the main Super Admin lists so the screen under the form updates when
  /// the user pops back (not only on the next manual pull-to-refresh).
  static Future<void> afterProductMutation(WidgetRef ref) async {
    ref.invalidate(productNamesProvider);
    ref.invalidate(productModelsProvider);
    ref.invalidate(productCatalogCombosProvider);
    ref.invalidate(productConfigProvider);
    ref.invalidate(productStockDetailsProvider);
    afterInventoryMutation(ref);

    // Warm catalog + KPI so Super Admin home updates after pop.
    await Future.wait([
      _safeFuture(ref, productNamesProvider),
      _safeFuture(ref, kpiProvider),
    ]);
  }

  static Future<void> _safeFuture(WidgetRef ref, FutureProvider provider) async {
    try {
      final _ = await ref.refresh(provider.future);
    } catch (_) {
      // Screen can still show error/retry; mutation itself already succeeded.
    }
  }

  /// Shipment created (admin) or accepted (seller).
  static void afterShipmentMutation(WidgetRef ref, {int? shipmentId}) {
    ref.invalidate(shipmentsListProvider);
    if (shipmentId != null) {
      ref.invalidate(shipmentDetailByIdProvider(shipmentId));
      ref.invalidate(sellerShipmentDetailProvider(shipmentId));
    } else {
      ref.invalidate(shipmentDetailByIdProvider);
      ref.invalidate(sellerShipmentDetailProvider);
    }
    // Pending is derived from all — invalidate source first.
    ref.invalidate(sellerAllShipmentsProvider);
    ref.invalidate(sellerPendingShipmentsProvider);
    afterInventoryMutation(ref);
  }

  /// Sale or return — inventory + sales history lists.
  static void afterSaleMutation(WidgetRef ref) {
    afterInventoryMutation(ref);
    // Avoid creating sales notifiers (and their network calls) if screens never opened.
    if (ref.exists(sellerSalesProvider)) {
      ref.read(sellerSalesProvider.notifier).fetchSales(isRefresh: true);
    }
    if (ref.exists(adminSalesHistoryProvider)) {
      ref.read(adminSalesHistoryProvider.notifier).fetchSales(isRefresh: true);
    }
  }

  /// Seller registered (admin flow).
  static void afterSellerMutation(WidgetRef ref) {
    ref.invalidate(sellersProvider);
    ref.invalidate(shipmentSellersProvider);
    ref.invalidate(sellerDetailsProvider);
    ref.invalidate(kpiProvider);
    ref.invalidate(recentActivityProvider);
  }
}
