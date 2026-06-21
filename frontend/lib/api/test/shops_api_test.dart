import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for ShopsApi
void main() {
  final instance = FriendsBatteryApi().getShopsApi();

  group(ShopsApi, () {
    // Retrieve a list of shops
    //
    //Future<BuiltList<ShopsGet200ResponseInner>> shopsGet() async
    test('test shopsGet', () async {
      // TODO
    });

  });
}
