import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:dio/dio.dart';
import 'api_client.dart';
import 'api_config.dart';

final dioProvider = Provider<Dio>((ref) {
  return ApiClient().dio;
});

final apiClientProvider = Provider<FriendsBatteryApi>((ref) {
  // Use our centralized ApiClient that has dotenv, interceptors, and error handling configured
  final dio = ref.watch(dioProvider);
  
  return FriendsBatteryApi(dio: dio, basePathOverride: ApiConfig.baseUrl);
});
