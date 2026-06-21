import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'api_client.dart';
import 'api_config.dart';

final apiClientProvider = Provider<FriendsBatteryApi>((ref) {
  // Use our centralized ApiClient that has dotenv, interceptors, and error handling configured
  final dio = ApiClient().dio;
  
  return FriendsBatteryApi(dio: dio, basePathOverride: ApiConfig.baseUrl);
});
