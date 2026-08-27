import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
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

/// Flat catalog rows. Model is null when the name has no models yet.
final productCatalogCombosProvider =
    FutureProvider<List<({CatalogItem name, CatalogItem? model})>>((ref) async {
  final repo = ref.watch(productCatalogRepositoryProvider);
  final names = await ref.watch(productNamesProvider.future);
  // ponytail: one request per name; add a combo list API if the catalog gets large
  final chunks = await Future.wait(names.map((n) async {
    final id = int.tryParse(n.id);
    if (id == null) return <({CatalogItem name, CatalogItem? model})>[];
    final models = await repo.getProductModels(id);
    if (models.isEmpty) return [(name: n, model: null)];
    return [for (final m in models) (name: n, model: m)];
  }));
  return [for (final c in chunks) ...c];
});

/// Existing pricing/units config for a name+model combo (null if not configured).
final productConfigProvider =
    FutureProvider.family<ProductConfigItem?, ({int nameId, int modelId})>(
  (ref, params) async {
    return ref.watch(productCatalogRepositoryProvider).getProductConfig(
          productNameId: params.nameId,
          productModelId: params.modelId,
        );
  },
);

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
