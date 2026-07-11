import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';
import '../repository/shared_inventory_repository.dart';

final sharedInventoryRepositoryProvider = Provider<SharedInventoryRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return SharedInventoryRepository(
    dio: dio,
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
  
  return repository.getInventory(
    search: query.search,
    page: query.page,
    limit: query.limit,
  );
});

final sharedInventoryProductDetailProvider = FutureProvider.family<InventoryProductDetailModel, int>((ref, productId) async {
  final repository = ref.watch(sharedInventoryRepositoryProvider);
  return repository.getProductDetail(productId);
});
