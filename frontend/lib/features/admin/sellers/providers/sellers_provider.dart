import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';

class SellerData {
  final User seller;
  final int totalStock;
  final int todaySales;
  final int pendingShipments;

  SellerData({
    required this.seller,
    required this.totalStock,
    required this.todaySales,
    required this.pendingShipments,
  });
}

final sellersProvider = FutureProvider<List<SellerData>>((ref) async {
  final dio = ref.watch(apiClientProvider).dio;
  final response = await dio.get('/api/shops/sellers');
  
  final dynamic data = response.data;
  List<SellerData> sellersList = [];
  
  List<dynamic> rawList = [];
  if (data is List) {
    rawList = data;
  } else if (data is Map<String, dynamic> && data.containsKey('data') && data['data'] is List) {
    rawList = data['data'];
  }
  
  for (var item in rawList) {
    if (item is Map<String, dynamic>) {
      // Manually map fields because API returns snake_case but generated User expects camelCase
      final user = User((b) => b
        ..id = item['id']?.toString()
        ..userName = item['user_name']?.toString()
        ..shopName = item['shop_name']?.toString()
        ..userNumber = item['user_number']?.toString()
        ..isVerified = item['is_verified'] == true || item['is_verified'] == 1
        ..isActive = item['is_active'] == true || item['is_active'] == 1
      );

      sellersList.add(SellerData(
        seller: user,
        totalStock: item['totalStock'] ?? 0,
        todaySales: item['todaySales'] ?? 0,
        pendingShipments: item['pendingShipments'] ?? 0,
      ));
    }
  }

  return sellersList;
});
