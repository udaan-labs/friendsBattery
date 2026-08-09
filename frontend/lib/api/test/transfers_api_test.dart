import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for TransfersApi
void main() {
  final instance = FriendsBatteryApi().getTransfersApi();

  group(TransfersApi, () {
    // Return all shipments (Admin gets all, Seller gets own)
    //
    //Future apiTransfersGet() async
    test('test apiTransfersGet', () async {
      // TODO
    });

    // Create a new shipment from Admin to Seller
    //
    //Future apiTransfersPost(ApiTransfersPostRequest apiTransfersPostRequest) async
    test('test apiTransfersPost', () async {
      // TODO
    });

    // Admin cancels a pending shipment
    //
    //Future apiTransfersShipmentIdCancelPatch(int shipmentId) async
    test('test apiTransfersShipmentIdCancelPatch', () async {
      // TODO
    });

    // Return complete shipment details by ID
    //
    //Future apiTransfersShipmentIdGet(int shipmentId) async
    test('test apiTransfersShipmentIdGet', () async {
      // TODO
    });

    // Seller receives and confirms a shipment delivery
    //
    //Future apiTransfersShipmentIdReceivePatch(int shipmentId) async
    test('test apiTransfersShipmentIdReceivePatch', () async {
      // TODO
    });

  });
}
