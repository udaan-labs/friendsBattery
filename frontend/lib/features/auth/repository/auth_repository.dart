import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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

      if (kDebugMode) {
        // ignore: avoid_print
        print(
          '[auth] http status=${response.statusCode} success=${response.data?.success}',
        );
      }

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

      // Prefer enum name; fall back to wire string if needed
      final roleRaw = loginUser?.role?.name;
      if (roleRaw == null || roleRaw.isEmpty) {
        throw Exception('Login response missing role');
      }

      final roleLower = roleRaw.toLowerCase();
      const allowed = {'super_admin', 'admin', 'seller', 'employee'};
      if (!allowed.contains(roleLower)) {
        throw Exception('Unsupported role: $roleRaw');
      }

      if (kDebugMode) {
        // ignore: avoid_print
        print('[auth] parsed role=$roleLower user=${loginUser?.username}');
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
    } on DioException catch (e) {
      // Typed client often throws here when body cannot deserialize.
      final raw = e.response?.data;
      if (kDebugMode) {
        // ignore: avoid_print
        print(
          '[auth] DioException status=${e.response?.statusCode} type=${e.type} err=${e.error} dataType=${raw.runtimeType}',
        );
      }

      // Fallback: parse Map body if OpenAPI deserialize failed after 2xx
      final status = e.response?.statusCode ?? 0;
      if (status >= 200 && status < 300 && raw is Map) {
        final parsed = _parseLoginMap(Map<String, dynamic>.from(raw));
        if (parsed != null) {
          if (kDebugMode) {
            // ignore: avoid_print
            print('[auth] fallback Map parse ok role=${parsed.role}');
          }
          return parsed;
        }
      }

      throw Exception(_authError(e, 'Login failed'));
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('[auth] login catch: $e');
      }
      throw Exception(_authError(e, 'Login failed'));
    }
  }

  /// Manual parse when built_value fails (null fields / enum edge cases).
  static AuthResponse? _parseLoginMap(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map) return null;
    final map = Map<String, dynamic>.from(data);
    final authId = map['auth_id']?.toString();
    final authKey = map['auth_key']?.toString();
    final userRaw = map['user'];
    if (authId == null ||
        authId.isEmpty ||
        authKey == null ||
        authKey.isEmpty ||
        userRaw is! Map) {
      return null;
    }
    final user = Map<String, dynamic>.from(userRaw);
    final roleRaw = user['role']?.toString();
    if (roleRaw == null || roleRaw.isEmpty) return null;
    final roleLower = roleRaw.toLowerCase();
    const allowed = {'super_admin', 'admin', 'seller', 'employee'};
    if (!allowed.contains(roleLower)) return null;

    return AuthResponse(
      authId: authId,
      authKey: authKey,
      role: roleLower,
      user: {
        'username': user['username'],
        'user_number': user['user_number'],
        'shop_name': user['shop_name'],
        'role': roleRaw,
      },
    );
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
      // Surface deserialize / network detail in debug-friendly way
      if (e.error != null) {
        return '${e.message ?? fallback}: ${e.error}';
      }
      return e.message ?? fallback;
    }
    final s = e.toString();
    return s.startsWith('Exception: ') ? s.substring(11) : s;
  }
}
