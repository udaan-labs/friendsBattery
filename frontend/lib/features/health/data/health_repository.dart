import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../core/network/api_exceptions.dart';

class HealthRepository {
  final FriendsBatteryApi _api;

  HealthRepository({required FriendsBatteryApi api}) : _api = api;

  Future<bool> checkHealth() async {
    try {
      final response = await _api.getHealthApi().apiHealthGet();
      return response.statusCode == 200;
    } catch (e) {
      throw ServerErrorException(message: e.toString());
    }
  }
}
