import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_config.dart';
import 'api_interceptor.dart';
import 'perf_interceptor.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio _dio;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      sendTimeout: ApiConfig.sendTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // Skip ngrok free-tier browser interstitial (HTML) which can add multi-second latency.
        'ngrok-skip-browser-warning': '1',
      },
    ));

    _dio.interceptors.addAll([
      // Order: timing → auth headers → optional verbose logs
      PerfInterceptor(),
      ApiInterceptor(),
      if (kDebugMode)
        LogInterceptor(
          request: false,
          requestHeader: false,
          requestBody: false,
          // Response body logging is expensive (large JSON stringification).
          // Use PerfInterceptor timings instead; enable body only when debugging payloads.
          responseHeader: false,
          responseBody: false,
          error: true,
          logPrint: (obj) {
            // ignore: avoid_print
            print(obj);
          },
        ),
    ]);
  }

  Dio get dio => _dio;
}
