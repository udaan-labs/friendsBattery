import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';

/// Sellers + employees at the same location as [sellerId] (admin shop view).
final shopStaffProvider = FutureProvider.family<ShopStaffData, int>((ref, sellerId) async {
  final response = await ref.watch(apiClientProvider).getShopsApi().apiShopsSellersSellerIdStaffGet(
        sellerId: sellerId,
      );
  final data = response.data?.data;
  if (data == null) {
    throw Exception(response.data?.message ?? 'Failed to load shop staff');
  }
  return data;
});
