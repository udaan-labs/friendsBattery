import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_token_cache.dart';

/// Session tokens + cached profile (secure storage + in-memory for sync UI reads).
class SessionManager {
  static const _storage = FlutterSecureStorage();
  static const _userKey = 'user_json';

  /// Hive-free profile map for dashboard greetings. Sync after [saveSession]/[getSessionData].
  static Map<String, dynamic>? user;

  static Future<void> saveSession({
    required String authId,
    required String authKey,
    required String role,
    required Map<String, dynamic> user,
  }) async {
    AuthTokenCache.set(authId: authId, authKey: authKey, role: role);
    SessionManager.user = user;

    await Future.wait([
      _storage.write(key: 'auth_id', value: authId),
      _storage.write(key: 'auth_key', value: authKey),
      _storage.write(key: 'role', value: role),
      _storage.write(key: 'is_logged_in', value: 'true'),
      _storage.write(key: _userKey, value: jsonEncode(user)),
    ]);
  }

  static Future<Map<String, String?>> getSessionData() async {
    await AuthTokenCache.ensureLoaded();
    if (user == null) {
      final raw = await _storage.read(key: _userKey);
      if (raw != null && raw.isNotEmpty) {
        try {
          final decoded = jsonDecode(raw);
          if (decoded is Map) {
            user = Map<String, dynamic>.from(decoded);
          }
        } catch (_) {}
      }
    }
    return {
      'auth_id': AuthTokenCache.authId,
      'auth_key': AuthTokenCache.authKey,
      'role': AuthTokenCache.role,
    };
  }

  static Future<bool> isLoggedIn() async {
    final loggedIn = await _storage.read(key: 'is_logged_in');
    return loggedIn == 'true';
  }

  static Future<void> clearSession() async {
    AuthTokenCache.clear();
    user = null;
    await _storage.deleteAll();
  }
}
