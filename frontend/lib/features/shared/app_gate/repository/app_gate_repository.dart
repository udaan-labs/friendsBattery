import 'package:friends_battery_api/friends_battery_api.dart';

/// Remote app gate config from generated OpenAPI client only.
class AppGateRepository {
  final FriendsBatteryApi _api;

  AppGateRepository({required FriendsBatteryApi api}) : _api = api;

  AppApi get _app => _api.getAppApi();

  Future<AppStatus> fetchStatus() async {
    final response = await _app.apiAppStatusGet();
    final data = response.data?.data;
    if (data == null) {
      throw StateError('App status response missing data');
    }
    return data;
  }
}
