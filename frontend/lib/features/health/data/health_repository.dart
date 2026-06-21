import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_exceptions.dart';

class HealthRepository {
  final Dio _dio;

  HealthRepository({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  Future<bool> checkHealth() async {
    try {
      final response = await _dio.get('/api/health');
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      if (e is DioException && e.error is ApiException) {
        throw e.error as ApiException; // Rethrow custom API exceptions
      }
      // Provide a generic fallback
      throw ServerErrorException(message: e.toString());
    }
  }
}
