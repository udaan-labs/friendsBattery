import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for InventoryApi
void main() {
  final instance = FriendsBatteryApi().getInventoryApi();

  group(InventoryApi, () {
    // Retrieve inventory transactions
    //
    //Future<BuiltList<InventoryTransaction>> apiInventoryGet() async
    test('test apiInventoryGet', () async {
      // TODO
    });

  });
}
