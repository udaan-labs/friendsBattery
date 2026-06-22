import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for ShipmentsApi
void main() {
  final instance = FriendsBatteryApi().getShipmentsApi();

  group(ShipmentsApi, () {
    // Get pending shipments count (Seller only)
    //
    //Future<ApiSellerDashboardPendingShipmentsGet200Response> apiSellerDashboardPendingShipmentsGet() async
    test('test apiSellerDashboardPendingShipmentsGet', () async {
      // TODO
    });

    // List shipments for seller (Seller only)
    //
    //Future<ApiSellerShipmentsGet200Response> apiSellerShipmentsGet() async
    test('test apiSellerShipmentsGet', () async {
      // TODO
    });

    // Create a new shipment (Admin only)
    //
    //Future apiShipmentsPost(ApiShipmentsPostRequest apiShipmentsPostRequest) async
    test('test apiShipmentsPost', () async {
      // TODO
    });

    // Accept a pending shipment (Seller only)
    //
    //Future apiShipmentsShipmentIdAcceptPost(int shipmentId, { JsonObject body }) async
    test('test apiShipmentsShipmentIdAcceptPost', () async {
      // TODO
    });

  });
}
