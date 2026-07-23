import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';
import '../repository/product_catalog_repository.dart';

export '../repository/product_catalog_repository.dart' show CatalogItem;

final productCatalogRepositoryProvider = Provider<ProductCatalogRepository>((ref) {
  return ProductCatalogRepository(api: ref.watch(apiClientProvider));
});

/// Single source of truth for product names (dropdowns across admin forms).
final productNamesProvider = FutureProvider<List<CatalogItem>>((ref) async {
  return ref.watch(productCatalogRepositoryProvider).getProductNames();
});

/// Product models for a given product name id.
final productModelsProvider =
    FutureProvider.family<List<CatalogItem>, int>((ref, productNameId) async {
  return ref.watch(productCatalogRepositoryProvider).getProductModels(productNameId);
});

/// Live product stock/price snapshot for Add Stock form.
final productStockDetailsProvider =
    FutureProvider.family<({int stock, num minPrice}), ({int nameId, int modelId})>(
  (ref, params) async {
    return ref.watch(productCatalogRepositoryProvider).getProductStockDetails(
          productNameId: params.nameId,
          productModelId: params.modelId,
        );
  },
);
