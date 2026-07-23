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

  // ponytail: Map parse until login/register OpenAPI responses are typed + client regen.
  Future<AuthResponse> login(String username, String password) async {
    final request = (ApiAuthLoginPostRequestBuilder()
          ..userId = username
          ..password = password)
        .build();

    try {
      final response = await api.apiAuthLoginPost(apiAuthLoginPostRequest: request);
      final dynamic responseData = (response as dynamic).data;

      if (responseData is Map<String, dynamic> && responseData['success'] == true) {
        final data = responseData['data'] as Map<String, dynamic>? ?? {};
        final user = data['user'] as Map<String, dynamic>? ?? {};
        final authId = data['auth_id']?.toString();
        final authKey = data['auth_key']?.toString();
        if (authId == null || authId.isEmpty || authKey == null || authKey.isEmpty) {
          throw Exception('Login response missing credentials');
        }
        return AuthResponse(
          authId: authId,
          authKey: authKey,
          role: user['role']?.toString().toLowerCase() ?? 'seller',
          user: user,
        );
      }
      throw Exception(
        responseData is Map<String, dynamic>
            ? (responseData['message'] ?? 'Login failed')
            : 'Login failed',
      );
    } catch (e) {
      throw Exception(_authError(e, 'Login failed'));
    }
  }

  Future<void> register({
    required String userId,
    required String username,
    required String userNumber,
    required String shopName,
    required String password,
  }) async {
    final request = (ApiAuthRegisterPostRequestBuilder()
          ..userId = userId
          ..username = username
          ..userNumber = userNumber
          ..shopName = shopName
          ..password = password)
        .build();

    try {
      final response = await api.apiAuthRegisterPost(apiAuthRegisterPostRequest: request);
      final dynamic responseData = (response as dynamic).data;
      if (responseData is Map<String, dynamic> && responseData['success'] == false) {
        throw Exception(responseData['message'] ?? 'Registration failed');
      }
    } catch (e) {
      throw Exception(_authError(e, 'Registration failed'));
    }
  }

  static String _authError(Object e, String fallback) {
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) return data['message'].toString();
      return e.message ?? fallback;
    }
    final s = e.toString();
    // Avoid "Exception: Exception: …" when rethrowing our own messages.
    return s.startsWith('Exception: ') ? s.substring(11) : s;
  }
}
