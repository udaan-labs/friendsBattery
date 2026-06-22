import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for SalesApi
void main() {
  final instance = FriendsBatteryApi().getSalesApi();

  group(SalesApi, () {
    // Return complete purchase history for a customer mobile
    //
    //Future apiSalesCustomerMobileGet(String mobile) async
    test('test apiSalesCustomerMobileGet', () async {
      // TODO
    });

    // Return all sales based on role (Admin sees all, Seller sees own)
    //
    //Future apiSalesGet() async
    test('test apiSalesGet', () async {
      // TODO
    });

    // Create a new sale transaction
    //
    //Future apiSalesPost(ApiSalesPostRequest apiSalesPostRequest) async
    test('test apiSalesPost', () async {
      // TODO
    });

    // Return a single sale's details by ID
    //
    //Future apiSalesTransactionIdGet(String transactionId) async
    test('test apiSalesTransactionIdGet', () async {
      // TODO
    });

  });
}
