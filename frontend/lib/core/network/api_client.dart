import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_config.dart';
import 'api_interceptor.dart';

/// Builds the shared Dio instance (auth + debug error logging).
Dio createAppDio() {
  final dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: ApiConfig.connectTimeout,
    receiveTimeout: ApiConfig.receiveTimeout,
    sendTimeout: ApiConfig.sendTimeout,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // Skip ngrok free-tier browser interstitial (HTML).
      'ngrok-skip-browser-warning': '1',
    },
  ));

  dio.interceptors.addAll([
    ApiInterceptor(),
    if (kDebugMode)
      LogInterceptor(
        request: true,
        requestHeader: false,
        requestBody: false,
        // statusCode is under responseHeader — needed to debug login
        responseHeader: true,
        responseBody: false,
        error: true,
        logPrint: (obj) {
          // ignore: avoid_print
          print(obj);
        },
      ),
  ]);

  return dio;
}
