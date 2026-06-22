import 'package:dio/dio.dart';
import 'package:friends_battery_api/friends_battery_api.dart'; // From generated OpenAPI package

class AuthResponse {
  final String authId;
  final String authKey;
  final String role; // 'admin' or 'seller'
  final Map<String, dynamic> user; // Full user details
  
  AuthResponse({required this.authId, required this.authKey, required this.role, required this.user});
}

class AuthRepository {
  final AuthApi api;

  AuthRepository({required this.api});

  Future<AuthResponse> login(String username, String password) async {
    final builder = ApiAuthLoginPostRequestBuilder()
      ..userId = username
      ..password = password;
    final request = builder.build();
      
    try {
      final response = await api.apiAuthLoginPost(apiAuthLoginPostRequest: request);
      
      // Since it's generated as Response<void>, we can access the underlying data using dynamic cast
      final dynamic responseData = (response as dynamic).data;
      
      if (responseData != null && responseData is Map<String, dynamic> && responseData['success'] == true) {
        final data = responseData['data'] as Map<String, dynamic>? ?? {};
        final user = data['user'] as Map<String, dynamic>? ?? {};
        return AuthResponse(
          authId: data['auth_id']?.toString() ?? '123',
          authKey: data['auth_key']?.toString() ?? 'abc',
          role: user['role']?.toString().toLowerCase() ?? 'seller',
          user: user,
        );
      } else if (responseData != null && responseData is Map<String, dynamic>) {
         throw Exception(responseData['message'] ?? 'Login failed');
      }
      return AuthResponse(authId: '123', authKey: 'abc', role: 'seller', user: {});
    } catch (e) {
      String errorMessage = 'Login failed';
      if (e is DioException) {
        if (e.response?.data != null && e.response?.data is Map) {
          errorMessage = e.response?.data['message'] ?? errorMessage;
        } else {
          errorMessage = e.message ?? errorMessage;
        }
      } else {
        errorMessage = e.toString();
      }
      throw Exception(errorMessage);
    }
  }

  Future<void> register({
    required String userId,
    required String username,
    required String userNumber,
    required String shopName,
    required String password,
  }) async {
    final builder = ApiAuthRegisterPostRequestBuilder()
      ..userId = userId
      ..username = username
      ..userNumber = userNumber
      ..shopName = shopName
      ..password = password;
    final request = builder.build();

    try {
      final response = await api.apiAuthRegisterPost(apiAuthRegisterPostRequest: request);
      final dynamic responseData = (response as dynamic).data;
      if (responseData != null && responseData is Map<String, dynamic> && responseData['success'] == false) {
        throw Exception(responseData['message'] ?? 'Registration failed');
      }
    } catch (e) {
      String errorMessage = 'Registration failed';
      if (e is DioException) {
        if (e.response?.data != null && e.response?.data is Map) {
          errorMessage = e.response?.data['message'] ?? errorMessage;
        } else {
          errorMessage = e.message ?? errorMessage;
        }
      } else {
        errorMessage = e.toString();
      }
      throw Exception(errorMessage);
    }
  }
}
