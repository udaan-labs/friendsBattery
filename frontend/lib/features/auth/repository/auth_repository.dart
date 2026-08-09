import 'package:dio/dio.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

class AuthResponse {
  final String authId;
  final String authKey;
  final String role; // 'super_admin' | 'admin' | 'seller' | 'employee'
  /// Profile snapshot for session storage (not an API DTO).
  final Map<String, dynamic> user;

  AuthResponse({
    required this.authId,
    required this.authKey,
    required this.role,
    required this.user,
  });
}

class AuthRepository {
  final AuthApi api;

  AuthRepository({required this.api});

  Future<AuthResponse> login(String username, String password) async {
    final request = (ApiAuthLoginPostRequestBuilder()
          ..userId = username
          ..password = password)
        .build();

    try {
      final response =
          await api.apiAuthLoginPost(apiAuthLoginPostRequest: request);
      final data = response.data?.data;
      final authId = data?.authId;
      final authKey = data?.authKey;
      final loginUser = data?.user;

      if (authId == null ||
          authId.isEmpty ||
          authKey == null ||
          authKey.isEmpty) {
        throw Exception(
          response.data?.message ?? 'Login response missing credentials',
        );
      }

      final roleRaw = loginUser?.role?.name;
      if (roleRaw == null || roleRaw.isEmpty) {
        throw Exception('Login response missing role');
      }

      final roleLower = roleRaw.toLowerCase();
      const allowed = {'super_admin', 'admin', 'seller', 'employee'};
      if (!allowed.contains(roleLower)) {
        throw Exception('Unsupported role: $roleRaw');
      }

      return AuthResponse(
        authId: authId,
        authKey: authKey,
        role: roleLower,
        user: {
          'username': loginUser?.username,
          'user_number': loginUser?.userNumber,
          'shop_name': loginUser?.shopName,
          'role': roleRaw,
        },
      );
    } catch (e) {
      throw Exception(_authError(e, 'Login failed'));
    }
  }

  /// Closes server session (employee_sessions) while tokens are still present.
  Future<void> logout() async {
    try {
      await api.apiAuthLogoutPost();
    } catch (_) {
      // Local clear still runs; server session may expire with JWT.
    }
  }

  Future<void> register({
    required String userId,
    required String username,
    required String userNumber,
    required String shopName,
    required String password,
    int? locationId,
  }) async {
    final request = (ApiAuthRegisterPostRequestBuilder()
          ..userId = userId
          ..username = username
          ..userNumber = userNumber
          ..shopName = shopName
          ..password = password
          ..locationId = locationId)
        .build();

    try {
      final response =
          await api.apiAuthRegisterPost(apiAuthRegisterPostRequest: request);
      if (response.data?.success == false) {
        throw Exception(response.data?.message ?? 'Registration failed');
      }
    } catch (e) {
      throw Exception(_authError(e, 'Registration failed'));
    }
  }

  static String _authError(Object e, String fallback) {
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
      return e.message ?? fallback;
    }
    final s = e.toString();
    return s.startsWith('Exception: ') ? s.substring(11) : s;
  }
}
