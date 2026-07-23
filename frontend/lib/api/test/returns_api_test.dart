import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for ReturnsApi
void main() {
  final instance = FriendsBatteryApi().getReturnsApi();

  group(ReturnsApi, () {
    // Process a product return (seller)
    //
    //Future<CreateReturnResponse> apiReturnsPost(CreateReturnRequest createReturnRequest) async
    test('test apiReturnsPost', () async {
      // TODO
    });

  });
}
