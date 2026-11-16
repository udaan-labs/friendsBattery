import 'package:dio/dio.dart';
import 'api_exceptions.dart';
import '../storage/auth_token_cache.dart';
import '../storage/session_guard.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../navigation/root_navigator_key.dart';

class ApiInterceptor extends Interceptor {
  /// Login: no force-logout on 401 (bad credentials).
  /// Register and register-admin require auth-id + auth-key — do not skip tokens.
  static bool _isPublicAuthPath(String path) {
    return path.contains('/auth/login');
  }

  /// Public endpoints that must not wait on the local session load.
  /// Splash hits /app/status in parallel with session restore.
  static bool _isPublicNoTokenPath(String path) {
    return _isPublicAuthPath(path) || path.contains('/app/status');
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Prefer in-memory tokens (sync). Cold path loads Hive once.
    // Public paths skip that load so the first request is not blocked.
    final path = options.path;
    final isPublicNoToken = _isPublicNoTokenPath(path);

    void attachAndContinue({bool withTokens = true}) {
      if (withTokens) {
        final token = AuthTokenCache.authKey;
        final authId = AuthTokenCache.authId;
        if (token != null && token.isNotEmpty) {
          // Backend accepts auth-key or Authorization Bearer
          options.headers['Authorization'] = 'Bearer $token';
          options.headers['auth-key'] = token;
        }
        if (authId != null && authId.isNotEmpty) {
          options.headers['auth-id'] = authId;
        }
      }
      // Always skip ngrok free-tier HTML interstitial on phone browsers/clients
      options.headers['ngrok-skip-browser-warning'] = '1';
      handler.next(options);
    }

    if (isPublicNoToken) {
      attachAndContinue(withTokens: false);
      return;
    }

    if (AuthTokenCache.hasTokens) {
      attachAndContinue();
      return;
    }

    AuthTokenCache.ensureLoaded().then((_) {
      attachAndContinue();
    }).catchError((Object e, StackTrace st) {
      attachAndContinue();
    });
  }

  static String? _lastErrorMessage;
  static DateTime? _lastErrorTime;

  void _showDebouncedSnackBar(String message) {
    final now = DateTime.now();
    if (_lastErrorMessage == message &&
        _lastErrorTime != null &&
        now.difference(_lastErrorTime!) < const Duration(seconds: 2)) {
      return;
    }
    _lastErrorMessage = message;
    _lastErrorTime = now;

    final overlayState = rootNavigatorKey.currentState?.overlay;
    if (overlayState != null) {
      showTopSnackBar(
        overlayState,
        CustomSnackBar.error(message: message),
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = 'An unexpected error occurred';
    int? statusCode;
    var forceLogout = false;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Connection timed out. Please try again later.';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'No internet connection. Please check your network.';
        break;
      case DioExceptionType.badResponse:
        statusCode = err.response?.statusCode;
        final responseData = err.response?.data;
        final path = err.requestOptions.path;

        if (responseData is Map && responseData['data'] is Map && responseData['data']['message'] != null) {
          errorMessage = responseData['data']['message'].toString();
        } else if (responseData is Map && responseData['message'] != null) {
          errorMessage = responseData['message'].toString();
        } else if (responseData is Map && responseData['error'] != null) {
          errorMessage = responseData['error'].toString();
        } else if (statusCode == 401 || statusCode == 403) {
          errorMessage = 'Unauthorized access. Please login again.';
        } else if (statusCode != null && statusCode >= 500) {
          errorMessage = 'A server error occurred. Please try again.';
        } else {
          errorMessage = err.message ?? 'A server error occurred.';
        }

        // 401 = session dead (revoked / expired). 403 = still logged in, no access.
        if (statusCode == 401 && !_isPublicAuthPath(path)) {
          forceLogout = true;
          errorMessage = 'Session expired. Please login again.';
        }
        break;
      default:
        errorMessage = err.message ?? 'An unexpected error occurred.';
        break;
    }

    if (forceLogout) {
      // Fire-and-forget: clear local auth so router kicks to /login
      SessionGuard.forceUnauthorized();
    }

    // Show debounced error snackbar automatically using global navigator overlay
    _showDebouncedSnackBar(errorMessage);

    handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: ApiException(errorMessage, statusCode: statusCode),
      response: err.response,
      type: err.type,
    ));
  }
}
