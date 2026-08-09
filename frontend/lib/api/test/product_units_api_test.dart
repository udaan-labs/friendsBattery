import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for ProductUnitsApi
void main() {
  final instance = FriendsBatteryApi().getProductUnitsApi();

  group(ProductUnitsApi, () {
    // Verify a product unit by serial or QR
    //
    //Future<VerifyProductResponse> apiProductUnitsVerifyPost(VerifyProductRequest verifyProductRequest) async
    test('test apiProductUnitsVerifyPost', () async {
      // TODO
    });

  });
}
