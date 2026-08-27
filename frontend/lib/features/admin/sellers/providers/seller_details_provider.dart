import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';
import '../../../shared/inventory/repository/shared_inventory_repository.dart';

class SellerDetailsData {
  final String shopName;
  final String userName;
  final String userNumber;
  final bool isActive;
  final bool isVerified;
  /// Shop location label from API (`name` · `code`), null if unassigned.
  final String? locationLabel;
  final int stock;
  final int products;
  final int sales;
  final int returns;
  final List<SharedInventoryItemModel> inventory;

  SellerDetailsData({
    required this.shopName,
    required this.userName,
    required this.userNumber,
    required this.isActive,
    required this.isVerified,
    this.locationLabel,
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
          (item) => SharedInventoryItemModel(
            productId: item.productId ?? 0,
            productNameId: 0,
            productModelId: 0,
            productModel: item.model ?? 'N/A',
            productName: item.brand ?? 'N/A',
            quantity: item.quantity ?? 0,
            minPrice: (item.minPrice ?? 0).toDouble(),
            minUnitCountAdmin: item.minUnitCountAdmin ?? 0,
            minUnitCountSeller: item.minUnitCountSeller ?? 0,
            onSale: item.onSale ?? false,
            isLowStock: item.isLowStock ?? false,
          ),
        )
        .toList();

    final loc = d.location;
    String? locationLabel;
    if (loc != null) {
      final name = loc.name?.trim();
      final code = loc.code?.trim();
      if (name != null && name.isNotEmpty) {
        locationLabel = (code != null && code.isNotEmpty) ? '$name · $code' : name;
      } else if (code != null && code.isNotEmpty) {
        locationLabel = code;
      }
    }

    return SellerDetailsData(
      shopName: d.shopName ?? 'Unknown Shop',
      userName: d.userName ?? 'Unknown User',
      userNumber: d.userNumber ?? 'N/A',
      isActive: d.isActive ?? false,
      isVerified: d.isVerified ?? false,
      locationLabel: locationLabel,
      stock: stats?.stock ?? 0,
      products: stats?.products ?? 0,
      sales: stats?.sales ?? 0,
      returns: stats?.returns ?? 0,
      inventory: inventory,
    );
  },
);
