import 'package:friends_battery_api/api.dart'; // Use the correct import for your generated api

class InventoryItemModel {
  final String id;
  final String name;
  final int quantity;

  InventoryItemModel({required this.id, required this.name, required this.quantity});
}

class InventoryRepository {
  final InventoryApi api; // Replace with correct generated api class (e.g. InventoryApi)

  InventoryRepository({required this.api});

  Future<List<InventoryItemModel>> getInventory() async {
    // Mock response for now
    await Future.delayed(const Duration(seconds: 1));
    return [
      InventoryItemModel(id: '1', name: 'Car Battery 12V', quantity: 50),
      InventoryItemModel(id: '2', name: 'Inverter Battery 150Ah', quantity: 20),
    ];
  }
}
