import 'package:dio/dio.dart';
import 'api_exceptions.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: TimeoutException(),
        ));
        break;
      case DioExceptionType.connectionError:
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: NoInternetException(),
        ));
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        if (statusCode == 401 || statusCode == 403) {
          handler.reject(DioException(
            requestOptions: err.requestOptions,
            error: UnauthorizedException(),
          ));
        } else if (statusCode != null && statusCode >= 500) {
          handler.reject(DioException(
            requestOptions: err.requestOptions,
            error: ServerErrorException(statusCode: statusCode),
          ));
        } else {
          handler.next(err);
        }
        break;
      default:
        handler.next(err);
        break;
    }
  }
}
