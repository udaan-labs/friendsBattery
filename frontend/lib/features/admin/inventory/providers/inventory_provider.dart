import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/inventory_repository.dart';
import '../../../../core/network/api_client_provider.dart';
import '../../../shared/inventory/providers/inventory_provider.dart';

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return InventoryRepository(api: ref.watch(apiClientProvider).getInventoryApi());
});

/// Legacy list shape used by [InventoryScreen].
/// Backed by the shared inventory SSOT so CRUD invalidation stays consistent.
final inventoryListProvider = FutureProvider<List<InventoryItemModel>>((ref) async {
  final page = await ref.watch(sharedInventoryProvider.future);
  return page.items
      .map(
        (item) => InventoryItemModel(
          id: item.productId.toString(),
          name: '${item.productName} ${item.productModel}'.trim(),
          quantity: item.quantity,
        ),
      )
      .toList();
});
