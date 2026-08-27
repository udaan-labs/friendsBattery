import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:dio/dio.dart';
import 'api_client.dart';
import 'api_config.dart';

final dioProvider = Provider<Dio>((ref) => createAppDio());

final apiClientProvider = Provider<FriendsBatteryApi>((ref) {
  final dio = ref.watch(dioProvider);
  // Pass empty interceptors so FriendsBatteryApi does NOT stack
  // OAuth/Bearer/Basic interceptors onto the shared Dio on every rebuild
  // (that duplicated request handling and made login flaky).
  // Auth headers are owned by ApiInterceptor in createAppDio().
  return FriendsBatteryApi(
    dio: dio,
    basePathOverride: ApiConfig.baseUrl,
    interceptors: const [],
  );
});
