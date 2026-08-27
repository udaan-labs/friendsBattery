import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';
import '../../../../shared/models/session_profile.dart';
import '../../../admin/shipments/providers/shipment_provider.dart';
import '../../../admin/shipments/repository/shipment_repository.dart';
import '../../../shared/inventory/providers/inventory_provider.dart';
import '../../sales/models/seller_sale.dart';

/// Seller greeting profile (same shape as employee session profile).
typedef SellerProfile = SessionProfile;

final sellerProfileProvider = Provider<SessionProfile>((ref) {
  return SessionProfile.fromSession(
    fallbackName: 'Seller',
    fallbackRole: 'seller',
  );
});

class SellerKpiStats {
  final int currentStock;
  final double todaySalesAmount;
  final int todaySalesCount;
  final int pendingShipments;
  final List<SellerSale> recentSales;

  SellerKpiStats({
    required this.currentStock,
    required this.todaySalesAmount,
    required this.todaySalesCount,
    required this.pendingShipments,
    required this.recentSales,
  });
}

final sellerKpiProvider = FutureProvider<SellerKpiStats>((ref) async {
  final api = ref.watch(apiClientProvider).getDashboardApi();
  final response = await api.apiSellerDashboardStatsGet();
  final d = response.data?.data;
  if (d == null) {
    throw Exception('Failed to retrieve seller statistics from API');
  }

  final recentSales = (d.recentSales?.toList() ?? [])
      .map(
        (s) => SellerSale(
          id: s.id ?? 0,
          productName: s.productName ?? 'Unknown Product',
          productModel: s.productModel ?? 'Unknown Model',
          serialNumber: s.serialNumber ?? 'N/A',
          quantity: 1,
          sellPrice: (s.sellPrice ?? 0).toDouble(),
          soldAt: s.soldAt ?? DateTime.now(),
          customerName: s.customerName,
        ),
      )
      .toList();

  return SellerKpiStats(
    currentStock: d.totalStock ?? 0,
    todaySalesAmount: (d.todaySalesAmount ?? 0).toDouble(),
    todaySalesCount: d.todaySales ?? 0,
    pendingShipments: d.pendingShipments ?? 0,
    recentSales: recentSales,
  );
});

class RecentInventoryItem {
  final String name;
  final String serialNumber;
  final String status; // 'Available', 'Low Stock', 'Sold'

  RecentInventoryItem({
    required this.name,
    required this.serialNumber,
    required this.status,
  });
}

/// Dashboard "recent inventory" — single small page (not full inventory).
final sellerRecentInventoryProvider = FutureProvider<List<RecentInventoryItem>>((ref) async {
  final result = await ref.watch(sharedInventoryRepositoryProvider).getInventory(
        page: 1,
        limit: 4,
      );
  if (result.items.isEmpty) return const [];

  return result.items.take(4).map((item) {
    final name = '${item.productName} ${item.productModel}'.trim();
    final quantity = item.quantity;
    String status = 'Available';
    if (quantity == 0) {
      status = 'Sold';
    } else if (quantity < 5) {
      status = 'Low Stock';
    }
    return RecentInventoryItem(
      name: name.isNotEmpty ? name : 'Battery unit',
      serialNumber: 'Quantity: $quantity units',
      status: status,
    );
  }).toList();
});

/// Single network call for seller shipments (any status).
final sellerAllShipmentsProvider =
    FutureProvider<List<ApiSellerShipmentsGet200ResponseDataInner>>((ref) async {
  final api = ref.watch(apiClientProvider).getShipmentsApi();
  final response = await api.apiSellerShipmentsGet();
  final list = response.data?.data;
  if (list == null) return [];
  return list.toList();
});

/// Derived from [sellerAllShipmentsProvider] — no second network request.
final sellerPendingShipmentsProvider =
    FutureProvider<List<ApiSellerShipmentsGet200ResponseDataInner>>((ref) async {
  final all = await ref.watch(sellerAllShipmentsProvider.future);
  return all.where((item) => item.status == 'PENDING').toList();
});

/// Seller: full shipment detail via generated client / ShipmentRepository.
final sellerShipmentDetailProvider =
    FutureProvider.family<ShipmentDetailModel, int>((ref, shipmentId) async {
  return ref.watch(shipmentRepositoryProvider).getShipmentById(shipmentId);
});

/// Pull-to-refresh for seller dashboard.
Future<void> refreshSellerDashboard(WidgetRef ref) async {
  await Future.wait([
    _safeRefresh(ref, sellerKpiProvider, 'KPIs'),
    _safeRefresh(ref, sellerRecentInventoryProvider, 'Recent Inventory'),
    _safeRefresh(ref, sellerAllShipmentsProvider, 'Shipments'),
  ]);
  ref.invalidate(sellerPendingShipmentsProvider);
}

Future<void> _safeRefresh(WidgetRef ref, FutureProvider provider, String name) async {
  try {
    final _ = await ref.refresh(provider.future);
  } catch (e) {
    developer.log('Failed to refresh seller $name', error: e);
  }
}
