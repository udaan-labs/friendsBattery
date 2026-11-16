import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';
import '../../../../core/storage/swr_notifier.dart';
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

final sellerKpiProvider =
    StateNotifierProvider<SwrNotifier<SellerKpiStats>, AsyncValue<SellerKpiStats>>((ref) {
  final api = ref.watch(apiClientProvider);
  return SwrNotifier(
    key: 'seller.kpi',
    encode: _sellerKpiToJson,
    decode: _sellerKpiFromJson,
    fetch: () async {
      final response = await api.getDashboardApi().apiSellerDashboardStatsGet();
      final data = response.data?.data;
      if (data == null) {
        throw Exception('Failed to retrieve seller statistics from API');
      }
      final recentSales = (data.recentSales?.toList() ?? [])
          .map(
            (sale) => SellerSale(
              id: sale.id ?? 0,
              productName: sale.productName ?? 'Unknown Product',
              productModel: sale.productModel ?? 'Unknown Model',
              serialNumber: sale.serialNumber ?? 'N/A',
              quantity: 1,
              sellPrice: (sale.sellPrice ?? 0).toDouble(),
              soldAt: sale.soldAt ?? DateTime.now(),
              customerName: sale.customerName,
            ),
          )
          .toList();
      return SellerKpiStats(
        currentStock: data.totalStock ?? 0,
        todaySalesAmount: (data.todaySalesAmount ?? 0).toDouble(),
        todaySalesCount: data.todaySales ?? 0,
        pendingShipments: data.pendingShipments ?? 0,
        recentSales: recentSales,
      );
    },
  );
});

Map<String, Object?> _sellerKpiToJson(SellerKpiStats stats) => {
      'currentStock': stats.currentStock,
      'todaySalesAmount': stats.todaySalesAmount,
      'todaySalesCount': stats.todaySalesCount,
      'pendingShipments': stats.pendingShipments,
      'recentSales': [
        for (final sale in stats.recentSales)
          {
            'id': sale.id,
            'productName': sale.productName,
            'productModel': sale.productModel,
            'serialNumber': sale.serialNumber,
            'sellPrice': sale.sellPrice,
            'soldAt': sale.soldAt.toIso8601String(),
            'customerName': sale.customerName,
          },
      ],
    };

SellerKpiStats? _sellerKpiFromJson(Object? json) {
  if (json is! Map) return null;
  final sales = json['recentSales'];
  return SellerKpiStats(
    currentStock: (json['currentStock'] as num?)?.toInt() ?? 0,
    todaySalesAmount: (json['todaySalesAmount'] as num?)?.toDouble() ?? 0,
    todaySalesCount: (json['todaySalesCount'] as num?)?.toInt() ?? 0,
    pendingShipments: (json['pendingShipments'] as num?)?.toInt() ?? 0,
    recentSales: [
      if (sales is List)
        for (final item in sales)
          if (item is Map)
            SellerSale(
              id: (item['id'] as num?)?.toInt() ?? 0,
              productName: item['productName'] as String? ?? 'Unknown Product',
              productModel: item['productModel'] as String? ?? 'Unknown Model',
              serialNumber: item['serialNumber'] as String? ?? 'N/A',
              quantity: 1,
              sellPrice: (item['sellPrice'] as num?)?.toDouble() ?? 0,
              soldAt: DateTime.tryParse(item['soldAt'] as String? ?? '') ?? DateTime.now(),
              customerName: item['customerName'] as String?,
            ),
    ],
  );
}

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
final sellerRecentInventoryProvider = StateNotifierProvider<
    SwrNotifier<List<RecentInventoryItem>>,
    AsyncValue<List<RecentInventoryItem>>>((ref) {
  final inventory = ref.watch(sharedInventoryRepositoryProvider);
  return SwrNotifier(
    key: 'seller.recentInventory',
    encode: (items) => [
      for (final item in items)
        {
          'name': item.name,
          'serialNumber': item.serialNumber,
          'status': item.status,
        },
    ],
    decode: (json) {
      if (json is! List) return null;
      return [
        for (final item in json)
          if (item is Map)
            RecentInventoryItem(
              name: item['name'] as String? ?? 'Battery unit',
              serialNumber: item['serialNumber'] as String? ?? '',
              status: item['status'] as String? ?? 'Available',
            ),
      ];
    },
    fetch: () async {
      final result = await inventory.getInventory(page: 1, limit: 4);
      if (result.items.isEmpty) return const [];
      return result.items.take(4).map((item) {
        final name = '${item.productName} ${item.productModel}'.trim();
        final quantity = item.quantity;
        var status = 'Available';
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
    },
  );
});

/// Single network call for seller shipments (any status).
final sellerAllShipmentsProvider = StateNotifierProvider<
    SwrNotifier<List<ApiSellerShipmentsGet200ResponseDataInner>>,
    AsyncValue<List<ApiSellerShipmentsGet200ResponseDataInner>>>((ref) {
  final api = ref.watch(apiClientProvider);
  return SwrNotifier(
    key: 'seller.shipments',
    encode: (items) => encodeBuiltList(
      items,
      (item) => standardSerializers.serializeWith(
        ApiSellerShipmentsGet200ResponseDataInner.serializer,
        item,
      ),
    ),
    decode: (json) => decodeBuiltList(
      json,
      (item) => standardSerializers.deserializeWith(
        ApiSellerShipmentsGet200ResponseDataInner.serializer,
        item,
      ),
    ),
    fetch: () async {
      final response = await api.getShipmentsApi().apiSellerShipmentsGet();
      return response.data?.data?.toList() ?? [];
    },
  );
});

/// Derived from [sellerAllShipmentsProvider] — no second network request.
final sellerPendingShipmentsProvider =
    Provider<AsyncValue<List<ApiSellerShipmentsGet200ResponseDataInner>>>((ref) {
  return ref.watch(sellerAllShipmentsProvider).whenData(
        (all) => all.where((item) => item.status == 'PENDING').toList(),
      );
});

/// Seller: full shipment detail via generated client / ShipmentRepository.
final sellerShipmentDetailProvider =
    FutureProvider.family<ShipmentDetailModel, int>((ref, shipmentId) async {
  return ref.watch(shipmentRepositoryProvider).getShipmentById(shipmentId);
});

/// Pull-to-refresh for seller dashboard.
Future<void> refreshSellerDashboard(WidgetRef ref) async {
  await Future.wait([
    ref.read(sellerKpiProvider.notifier).reload(),
    ref.read(sellerRecentInventoryProvider.notifier).reload(),
    ref.read(sellerAllShipmentsProvider.notifier).reload(),
  ]);
}
