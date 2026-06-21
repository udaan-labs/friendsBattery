import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for ProductsApi
void main() {
  final instance = FriendsBatteryApi().getProductsApi();

  group(ProductsApi, () {
    // Retrieve a list of products
    //
    //Future<BuiltList<ShopsGet200ResponseInner>> productsGet() async
    test('test productsGet', () async {
      // TODO
    });

  });
}
