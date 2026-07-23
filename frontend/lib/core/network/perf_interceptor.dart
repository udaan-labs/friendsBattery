import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Debug-only timing for request phases:
/// - auth: time until next interceptor finishes request mutation (approx)
/// - network: wire time after request is sent until response headers/body
/// - total: end-to-end interceptor span
///
/// Logs: `[PERF] METHOD path | auth=Xms net=Yms total=Zms status=N bytes=B`
class PerfInterceptor extends Interceptor {
  static const _kStart = '_perf_start_ms';
  static const _kAfterAuth = '_perf_after_auth_ms';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      options.extra[_kStart] = DateTime.now().millisecondsSinceEpoch;
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      _log(response.requestOptions, response.statusCode, response.data);
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      _log(err.requestOptions, err.response?.statusCode, err.response?.data, error: true);
    }
    handler.next(err);
  }

  /// Call from [ApiInterceptor] after auth headers are attached.
  static void markAuthDone(RequestOptions options) {
    if (!kDebugMode) return;
    options.extra[_kAfterAuth] = DateTime.now().millisecondsSinceEpoch;
  }

  void _log(RequestOptions options, int? status, dynamic data, {bool error = false}) {
    final start = options.extra[_kStart] as int?;
    if (start == null) return;
    final end = DateTime.now().millisecondsSinceEpoch;
    final afterAuth = options.extra[_kAfterAuth] as int? ?? start;
    final authMs = afterAuth - start;
    final netMs = end - afterAuth;
    final totalMs = end - start;
    int bytes = 0;
    if (data is String) {
      bytes = data.length;
    } else if (data != null) {
      bytes = data.toString().length;
    }
    final tag = error ? 'PERF-ERR' : 'PERF';
    // ignore: avoid_print
    print(
      '[$tag] ${options.method} ${options.path} | '
      'auth=${authMs}ms net=${netMs}ms total=${totalMs}ms '
      'status=${status ?? '-'} ~bytes=$bytes',
    );
  }
}
