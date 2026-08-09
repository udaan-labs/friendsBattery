import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:dio/dio.dart';
import 'api_client.dart';
import 'api_config.dart';

final dioProvider = Provider<Dio>((ref) => createAppDio());

final apiClientProvider = Provider<FriendsBatteryApi>((ref) {
  final dio = ref.watch(dioProvider);
  return FriendsBatteryApi(dio: dio, basePathOverride: ApiConfig.baseUrl);
});
