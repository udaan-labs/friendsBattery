import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/api.dart';
import '../repository/inventory_repository.dart';
import '../../../../../core/network/api_client_provider.dart';

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return InventoryRepository(api: InventoryApi(ref.watch(apiClientProvider)));
});

final inventoryListProvider = FutureProvider<List<InventoryItemModel>>((ref) async {
  final repository = ref.watch(inventoryRepositoryProvider);
  return repository.getInventory();
});
