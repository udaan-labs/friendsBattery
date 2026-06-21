class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class NoInternetException extends ApiException {
  NoInternetException() : super("No internet connection. Please check your network.");
}

class TimeoutException extends ApiException {
  TimeoutException() : super("Connection timed out. Please try again later.");
}

class ServerErrorException extends ApiException {
  ServerErrorException({int? statusCode, String? message}) 
      : super(message ?? "A server error occurred. Please try again.", statusCode: statusCode);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException() : super("Unauthorized access. Please login again.", statusCode: 401);
}
