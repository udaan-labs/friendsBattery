import 'package:friends_battery_api/friends_battery_api.dart';

class CatalogItem {
  final String id;
  final String name;

  const CatalogItem({required this.id, required this.name});
}

/// Product names / models / create-product via generated OpenAPI client only.
class ProductCatalogRepository {
  final FriendsBatteryApi _api;

  ProductCatalogRepository({required FriendsBatteryApi api}) : _api = api;

  ProductsApi get _products => _api.getProductsApi();
  InventoryApi get _inventory => _api.getInventoryApi();

  Future<List<CatalogItem>> getProductNames() async {
    final response = await _products.apiProductsProductNamesGet();
    final rows = response.data?.data?.toList() ?? [];
    return rows
        .map(
          (row) => CatalogItem(
            id: (row.id ?? 0).toString(),
            name: row.name ?? '',
          ),
        )
        .toList();
  }

  Future<List<CatalogItem>> getProductModels(int productNameId) async {
    final body = ListProductModelsRequest(
      (b) => b.productNameId = productNameId,
    );
    final response = await _products.apiProductsProductModelsListPost(
      listProductModelsRequest: body,
    );
    final rows = response.data?.data?.toList() ?? [];
    return rows
        .map(
          (row) => CatalogItem(
            id: (row.id ?? 0).toString(),
            name: row.name ?? '',
          ),
        )
        .toList();
  }

  Future<({int stock, num minPrice})> getProductStockDetails({
    required int productNameId,
    required int productModelId,
  }) async {
    final response = await _inventory.apiInventoryProductDetailsGet(
      productNameId: productNameId,
      productModelId: productModelId,
    );
    final d = response.data?.data;
    return (
      stock: d?.currentStock ?? 0,
      minPrice: d?.minSellPrice ?? 0,
    );
  }

  Future<int> createProductName(String name) async {
    final body = CreateProductNameRequest((b) => b.name = name);
    final response = await _products.apiProductsProductNamesPost(
      createProductNameRequest: body,
    );
    final id = response.data?.data?.id;
    if (id == null) {
      throw Exception('Product name created but id missing');
    }
    return id;
  }

  Future<int> createProductModel({
    required int productNameId,
    required String name,
  }) async {
    final body = CreateProductModelRequest((b) {
      b.productNameId = productNameId;
      b.name = name;
    });
    final response = await _products.apiProductsProductModelsPost(
      createProductModelRequest: body,
    );
    final id = response.data?.data?.id;
    if (id == null) {
      throw Exception('Product model created but id missing');
    }
    return id;
  }

  Future<void> createProduct({
    required int productNameId,
    required int productModelId,
    num? minPrice,
    bool? onSale,
    num? offerPrice,
    int? minUnitCountAdmin,
    int? minUnitCountSeller,
  }) async {
    final body = CreateProductRequest((b) {
      b.productNameId = productNameId;
      b.productModelId = productModelId;
      if (minPrice != null) b.minPrice = minPrice;
      if (onSale != null) b.onSale = onSale;
      if (offerPrice != null) b.offerPrice = offerPrice;
      if (minUnitCountAdmin != null) b.minUnitCountAdmin = minUnitCountAdmin;
      if (minUnitCountSeller != null) b.minUnitCountSeller = minUnitCountSeller;
    });
    await _products.apiProductsPost(createProductRequest: body);
  }
}
