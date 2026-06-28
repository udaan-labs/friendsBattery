import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/inventory_repository.dart';
import '../../../../core/network/api_client_provider.dart';

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return InventoryRepository(api: ref.watch(apiClientProvider).getInventoryApi());
});

final inventoryListProvider = FutureProvider<List<InventoryItemModel>>((ref) async {
  final repository = ref.watch(inventoryRepositoryProvider);
  return repository.getInventory();
});
