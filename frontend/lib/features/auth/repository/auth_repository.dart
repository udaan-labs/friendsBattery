import 'package:dio/dio.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

class AuthResponse {
  final String authId;
  final String authKey;
  final String role; // 'admin' | 'seller' | 'employee'
  /// Hive-safe snapshot of [LoginUser] (local storage only, not an API DTO).
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
      final response = await api.apiAuthLoginPost(apiAuthLoginPostRequest: request);
      final data = response.data?.data;
      final authId = data?.authId;
      final authKey = data?.authKey;
      final loginUser = data?.user;

      if (authId == null || authId.isEmpty || authKey == null || authKey.isEmpty) {
        throw Exception(response.data?.message ?? 'Login response missing credentials');
      }

      final roleRaw = loginUser?.role?.name ?? 'SELLER';
      return AuthResponse(
        authId: authId,
        authKey: authKey,
        role: roleRaw.toLowerCase(),
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
      if (data is Map && data['message'] != null) return data['message'].toString();
      // Typed Error body when deserializable fails still lands as Map from Dio
      return e.message ?? fallback;
    }
    final s = e.toString();
    return s.startsWith('Exception: ') ? s.substring(11) : s;
  }
}
