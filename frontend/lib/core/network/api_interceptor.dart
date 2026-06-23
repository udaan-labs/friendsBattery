import 'package:dio/dio.dart';
import 'api_exceptions.dart';
import '../storage/secure_storage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../app/router/app_router.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final authData = await SecureStorage.getAuthData();
    final token = authData['auth_key'];
    final authId = authData['auth_id'];
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    if (authId != null) {
      options.headers['auth-id'] = authId;
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = 'An unexpected error occurred';
    ApiException? apiException;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        apiException = TimeoutException();
        errorMessage = apiException.message;
        break;
      case DioExceptionType.connectionError:
        apiException = NoInternetException();
        errorMessage = apiException.message;
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final responseData = err.response?.data;
        
        if (responseData is Map && responseData['data'] is Map && responseData['data']['message'] != null) {
          errorMessage = responseData['data']['message'].toString();
        } else if (responseData is Map && responseData['message'] != null) {
          errorMessage = responseData['message'].toString();
        } else if (responseData is Map && responseData['error'] != null) {
          errorMessage = responseData['error'].toString();
        } else if (statusCode == 401 || statusCode == 403) {
          apiException = UnauthorizedException();
          errorMessage = apiException.message;
        } else if (statusCode != null && statusCode >= 500) {
          apiException = ServerErrorException(statusCode: statusCode);
          errorMessage = apiException.message;
        } else {
          errorMessage = err.message ?? 'A server error occurred.';
        }
        break;
      default:
        errorMessage = err.message ?? 'An unexpected error occurred.';
        break;
    }

    // Show the error snackbar automatically using global navigator overlay
    final overlayState = rootNavigatorKey.currentState?.overlay;
    if (overlayState != null) {
      showTopSnackBar(
        overlayState,
        CustomSnackBar.error(message: errorMessage),
      );
    }

    if (apiException != null) {
      handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: apiException,
        response: err.response,
      ));
    } else {
      handler.next(err);
    }
  }
}
