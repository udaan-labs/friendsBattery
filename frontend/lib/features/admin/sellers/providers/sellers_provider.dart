import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';

class SellerData {
  final User seller;
  final int totalStock;
  final int todaySales;
  final int pendingShipments;
  final bool? hasLowStock;

  SellerData({
    required this.seller,
    required this.totalStock,
    required this.todaySales,
    required this.pendingShipments,
    this.hasLowStock = false,
  });
}

final sellersProvider = FutureProvider<List<SellerData>>((ref) async {
  final response = await ref.watch(apiClientProvider).getShopsApi().apiShopsSellersGet();
  final rows = response.data?.data?.toList() ?? [];

  return rows.map((item) {
    final user = User((b) {
      b.id = item.id?.toString();
      b.userName = item.userName;
      b.shopName = item.shopName;
      b.userNumber = item.userNumber;
      b.isVerified = item.isVerified;
      b.isActive = item.isActive;
    });

    return SellerData(
      seller: user,
      totalStock: item.totalStock ?? 0,
      todaySales: item.todaySales ?? 0,
      pendingShipments: item.pendingShipments ?? 0,
      hasLowStock: item.hasLowStock == true,
    );
  }).toList();
});
