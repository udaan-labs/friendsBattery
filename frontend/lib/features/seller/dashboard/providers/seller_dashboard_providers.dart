import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';
import '../../../../core/storage/local_storage.dart';

class SellerProfile {
  final String userName;
  final String shopName;
  final String role;

  SellerProfile({
    required this.userName,
    required this.shopName,
    required this.role,
  });
}

final sellerProfileProvider = Provider<SellerProfile>((ref) {
  final dynamic user = LocalStorage.get('user');
  if (user is Map) {
    final userNameStr = (user['username'] ?? user['userName'] ?? 'Rahul Sharma').toString();
    final shopNameStr = (user['shop_name'] ?? user['shopName'] ?? 'EcoPower Solutions Hub').toString();
    final roleStr = (user['role'] ?? 'Premium Dealer').toString();
    return SellerProfile(
      userName: userNameStr,
      shopName: shopNameStr,
      role: roleStr,
    );
  }
  return SellerProfile(
    userName: 'Rahul Sharma',
    shopName: 'EcoPower Solutions Hub',
    role: 'Premium Dealer',
  );
});

final sellerInventoryProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final api = ref.watch(apiClientProvider).getInventoryApi();
  final response = await api.apiInventoryGet();
  final dynamic responseData = (response as dynamic).data;
  
  if (responseData != null && responseData is Map<String, dynamic> && responseData['success'] == true) {
    final dataMap = responseData['data'] as Map<String, dynamic>? ?? {};
    final list = dataMap['data'] as List? ?? [];
    return list.map((item) => item as Map<String, dynamic>).toList();
  }
  return [];
});

class SellerKpiStats {
  final int currentStock;
  final double todaySalesAmount;
  final int todaySalesCount;
  final double salesGrowthPercentage;
  final int pendingShipments;

  SellerKpiStats({
    required this.currentStock,
    required this.todaySalesAmount,
    required this.todaySalesCount,
    required this.salesGrowthPercentage,
    required this.pendingShipments,
  });
}

final sellerKpiProvider = FutureProvider<SellerKpiStats>((ref) async {
  try {
    final dio = ref.watch(apiClientProvider).dio;
    final response = await dio.get('/api/seller/dashboard/stats');
    final body = response.data;

    if (body is! Map || body['success'] != true || body['data'] is! Map) {
      throw Exception('Failed to retrieve seller statistics from API');
    }

    final d = body['data'] as Map<String, dynamic>;

    final totalStock = (d['totalStock'] ?? 0) as int;
    final todaySalesCount = (d['todaySales'] ?? 0) as int;
    final todaySalesAmount = (d['todaySalesAmount'] ?? 0).toDouble();
    final pendingShipmentsCount = (d['pendingShipments'] ?? 0) as int;

    return SellerKpiStats(
      currentStock: totalStock,
      todaySalesAmount: todaySalesAmount,
      todaySalesCount: todaySalesCount,
      salesGrowthPercentage: 12.0,
      pendingShipments: pendingShipmentsCount,
    );
  } catch (e) {
    rethrow;
  }
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

final sellerRecentInventoryProvider = FutureProvider<List<RecentInventoryItem>>((ref) async {
  // Let's create some representative stock items or read from inventory history
  // If we have inventory, we can map them, else fallback to mockup data
  final inventory = await ref.watch(sellerInventoryProvider.future);
  if (inventory.isNotEmpty) {
    return inventory.take(4).map((item) {
      final name = "${item['brand'] ?? ''} ${item['model'] ?? ''}".trim();
      final quantity = (item['quantity'] as num? ?? 0).toInt();
      String status = 'Available';
      if (quantity == 0) {
        status = 'Sold';
      } else if (quantity < 5) {
        status = 'Low Stock';
      }
      return RecentInventoryItem(
        name: name.isNotEmpty ? name : 'Battery unit',
        serialNumber: 'SN: BATT-0${item['product_id']}-XW',
        status: status,
      );
    }).toList();
  }

  // Fallback to mockup data
  return [
    RecentInventoryItem(name: 'UltraLife Max S3', serialNumber: 'SN: BATT-0921-XW', status: 'Available'),
    RecentInventoryItem(name: 'PowerVolt Core 5', serialNumber: 'SN: PVOLT-332-LM', status: 'Low Stock'),
    RecentInventoryItem(name: 'EcoSafe Lithium 100Ah', serialNumber: 'SN: ECO-LITH-440', status: 'Sold'),
    RecentInventoryItem(name: 'ThunderCharge Pro', serialNumber: 'SN: TC-9921-X1', status: 'Available'),
  ];
});

final sellerPendingShipmentsProvider = FutureProvider<List<ApiSellerShipmentsGet200ResponseDataInner>>((ref) async {
  try {
    final api = ref.watch(apiClientProvider).getShipmentsApi();
    final response = await api.apiSellerShipmentsGet();
    final list = response.data?.data;
    if (list == null) return [];
    return list.where((item) => item.status == 'PENDING').toList();
  } catch (e) {
    rethrow;
  }
});

/// All shipments (any status) for the Received Shipments screen.
final sellerAllShipmentsProvider = FutureProvider<List<ApiSellerShipmentsGet200ResponseDataInner>>((ref) async {
  try {
    final api = ref.watch(apiClientProvider).getShipmentsApi();
    final response = await api.apiSellerShipmentsGet();
    final list = response.data?.data;
    if (list == null) return [];
    return list.toList();
  } catch (e) {
    rethrow;
  }
});

/// Seller: get full shipment detail by ID via GET /api/shipments/:id
final sellerShipmentDetailProvider =
    FutureProvider.family<Map<String, dynamic>, int>((ref, shipmentId) async {
  final dio = ref.watch(apiClientProvider).dio;
  final response = await dio.get('/api/shipments/$shipmentId');
  final body = response.data;
  if (body is Map && body['data'] != null) {
    return body['data'] as Map<String, dynamic>;
  }
  throw Exception('Invalid response from GET /api/shipments/$shipmentId');
});

