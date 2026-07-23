import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';

class SellerDetailsData {
  final String shopName;
  final String userName;
  final String userNumber;
  final bool isActive;
  final bool isVerified;
  final int stock;
  final int products;
  final int sales;
  final int returns;
  final List<Map<String, dynamic>> inventory;

  SellerDetailsData({
    required this.shopName,
    required this.userName,
    required this.userNumber,
    required this.isActive,
    required this.isVerified,
    required this.stock,
    required this.products,
    required this.sales,
    required this.returns,
    required this.inventory,
  });
}

final sellerDetailsProvider =
    FutureProvider.family<SellerDetailsData, ({int sellerId, bool includeOutOfStock})>(
  (ref, params) async {
    final response = await ref.watch(apiClientProvider).getShopsApi().apiShopsSellersSellerIdGet(
          sellerId: params.sellerId,
          includeOutOfStock: params.includeOutOfStock,
        );

    final d = response.data?.data;
    if (d == null) {
      throw Exception(response.data?.message ?? 'Invalid data format received from API');
    }

    final stats = d.statistics;
    final inventory = (d.inventory?.toList() ?? [])
        .map(
          (item) => <String, dynamic>{
            'product_id': item.productId,
            'brand': item.brand,
            'model': item.model,
            'quantity': item.quantity,
            'min_price': item.minPrice,
            'min_unit_count_admin': item.minUnitCountAdmin,
            'min_unit_count_seller': item.minUnitCountSeller,
            'on_sale': item.onSale,
            'is_low_stock': item.isLowStock,
          },
        )
        .toList();

    return SellerDetailsData(
      shopName: d.shopName ?? 'Unknown Shop',
      userName: d.userName ?? 'Unknown User',
      userNumber: d.userNumber ?? 'N/A',
      isActive: d.isActive ?? false,
      isVerified: d.isVerified ?? false,
      stock: stats?.stock ?? 0,
      products: stats?.products ?? 0,
      sales: stats?.sales ?? 0,
      returns: stats?.returns ?? 0,
      inventory: inventory,
    );
  },
);
