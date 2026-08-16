import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';
import '../repository/shared_inventory_repository.dart';

final sharedInventoryRepositoryProvider = Provider<SharedInventoryRepository>((ref) {
  return SharedInventoryRepository(
    api: ref.watch(apiClientProvider),
  );
});

class InventoryQuery {
  final String? search;
  final int page;
  final int limit;

  const InventoryQuery({this.search, this.page = 1, this.limit = 10});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryQuery &&
          runtimeType == other.runtimeType &&
          search == other.search &&
          page == other.page &&
          limit == other.limit;

  @override
  int get hashCode => search.hashCode ^ page.hashCode ^ limit.hashCode;
}

final sharedInventoryQueryProvider = StateProvider<InventoryQuery>((ref) => const InventoryQuery());

final sharedInventoryProvider = FutureProvider<PaginatedInventoryResponse>((ref) async {
  final repository = ref.watch(sharedInventoryRepositoryProvider);
  final query = ref.watch(sharedInventoryQueryProvider);
  final sw = Stopwatch()..start();
  final result = await repository.getInventory(
    search: query.search,
    page: query.page,
    limit: query.limit,
  );
  sw.stop();
  assert(() {
    // ignore: avoid_print
    print(
      '[PERF-PROVIDER] sharedInventoryProvider total=${sw.elapsedMilliseconds}ms '
      'page=${query.page} items=${result.items.length}',
    );
    return true;
  }());
  return result;
});

final sharedInventoryProductDetailProvider = FutureProvider.family<InventoryProductDetailModel, int>((ref, productId) async {
  final repository = ref.watch(sharedInventoryRepositoryProvider);
  return repository.getProductDetail(productId);
});

/// SA/Admin: available units physically at this shop/warehouse.
/// ponytail: first page limit=50; add paging if a warehouse grows past that.
final locationInventoryProvider =
    FutureProvider.family<PaginatedInventoryResponse, int>((ref, locationId) async {
  return ref.watch(sharedInventoryRepositoryProvider).getInventory(
        locationId: locationId,
        page: 1,
        limit: 50,
      );
});
