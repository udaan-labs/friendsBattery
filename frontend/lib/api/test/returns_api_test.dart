import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for ReturnsApi
void main() {
  final instance = FriendsBatteryApi().getReturnsApi();

  group(ReturnsApi, () {
    // List product returns (seller own, admin all)
    //
    //Future<ReturnsListResponse> apiReturnsGet() async
    test('test apiReturnsGet', () async {
      // TODO
    });

    // Process a product return (seller)
    //
    //Future<CreateReturnResponse> apiReturnsPost(CreateReturnRequest createReturnRequest) async
    test('test apiReturnsPost', () async {
      // TODO
    });

  });
}
