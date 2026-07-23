import 'package:friends_battery_api/friends_battery_api.dart';

class SharedInventoryItemModel {
  final int productId;
  final int productNameId;
  final int productModelId;
  final String productModel;
  final String productName;
  final int quantity;
  final double minPrice;
  final int minUnitCountAdmin;
  final int minUnitCountSeller;
  final bool onSale;
  final bool isLowStock;

  SharedInventoryItemModel({
    required this.productId,
    required this.productNameId,
    required this.productModelId,
    required this.productModel,
    required this.productName,
    required this.quantity,
    required this.minPrice,
    this.minUnitCountAdmin = 0,
    this.minUnitCountSeller = 0,
    this.onSale = false,
    this.isLowStock = false,
  });
}

class InventoryProductDetailModel {
  final int productId;
  final String productModel;
  final String productName;
  final int quantity;
  final double minPrice;
  final bool isLowStock;
  final List<String> serialNumbers;

  InventoryProductDetailModel({
    required this.productId,
    required this.productModel,
    required this.productName,
    required this.quantity,
    required this.minPrice,
    required this.isLowStock,
    required this.serialNumbers,
  });
}

class PaginatedInventoryResponse {
  final List<SharedInventoryItemModel> items;
  final int total;

  PaginatedInventoryResponse({required this.items, required this.total});
}

/// Shared inventory list + detail via generated OpenAPI client only (no raw Dio).
class SharedInventoryRepository {
  final FriendsBatteryApi _api;

  SharedInventoryRepository({required FriendsBatteryApi api}) : _api = api;

  InventoryApi get _inventory => _api.getInventoryApi();

  Future<PaginatedInventoryResponse> getInventory({
    String? search,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _inventory.apiInventoryGet(
        search: (search != null && search.isNotEmpty) ? search : null,
        page: page,
        limit: limit,
      );

      final payload = response.data?.data;
      if (payload == null) {
        return PaginatedInventoryResponse(items: [], total: 0);
      }

      final rows = payload.data?.toList() ?? [];
      final items = rows
          .map(
            (row) => SharedInventoryItemModel(
              productId: row.productId ?? 0,
              productNameId: row.productNameId ?? 0,
              productModelId: row.productModelId ?? 0,
              productModel: row.model ?? 'N/A',
              productName: row.brand ?? 'N/A',
              quantity: row.quantity ?? 0,
              minPrice: (row.minPrice ?? 0).toDouble(),
              minUnitCountAdmin: row.minUnitCountAdmin ?? 0,
              minUnitCountSeller: row.minUnitCountSeller ?? 0,
              onSale: row.onSale ?? false,
              isLowStock: row.isLowStock ?? false,
            ),
          )
          .toList();

      final total = payload.pagination?.total ?? items.length;
      return PaginatedInventoryResponse(items: items, total: total);
    } catch (e) {
      throw Exception('Failed to fetch inventory: $e');
    }
  }

  Future<InventoryProductDetailModel> getProductDetail(int productId) async {
    try {
      final response = await _inventory.apiInventoryProductIdGet(
        productId: productId,
      );
      final d = response.data?.data;
      if (d == null) {
        throw Exception('Invalid response format');
      }

      return InventoryProductDetailModel(
        productId: d.productId ?? 0,
        productModel: d.model ?? 'N/A',
        productName: d.brand ?? 'N/A',
        quantity: d.quantity ?? 0,
        minPrice: (d.minPrice ?? 0).toDouble(),
        isLowStock: d.isLowStock ?? false,
        serialNumbers: d.serialNumbers?.toList() ?? const [],
      );
    } catch (e) {
      throw Exception('Failed to fetch product detail: $e');
    }
  }

  /// Admin add stock / update price & sale flags.
  Future<void> updateStock({
    required int productNameId,
    required int productModelId,
    int? quantity,
    num? minSellPrice,
    int? minUnitCountAdmin,
    int? minUnitCountSeller,
    bool? onSale,
  }) async {
    final body = UpdateStockRequest((b) {
      b.productNameId = productNameId;
      b.productModelId = productModelId;
      if (quantity != null) b.quantity = quantity;
      if (minSellPrice != null) b.minSellPrice = minSellPrice;
      if (minUnitCountAdmin != null) b.minUnitCountAdmin = minUnitCountAdmin;
      if (minUnitCountSeller != null) b.minUnitCountSeller = minUnitCountSeller;
      if (onSale != null) b.onSale = onSale;
    });

    await _inventory.apiInventoryUpdateStockPost(updateStockRequest: body);
  }

  /// Admin adjust stock (negative removes units for [userId] owner).
  Future<void> adjustInventory({
    required int productId,
    required int userId,
    required int adjustmentQuantity,
  }) async {
    final body = AdjustInventoryRequest((b) {
      b.productId = productId;
      b.userId = userId;
      b.adjustmentQuantity = adjustmentQuantity;
    });

    await _inventory.apiInventoryAdjustPatch(adjustInventoryRequest: body);
  }
}
