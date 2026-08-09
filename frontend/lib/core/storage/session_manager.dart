import 'dart:convert';

import 'package:flutter/foundation.dart';
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
    // Always set memory first so router + Dio work even if secure storage fails.
    AuthTokenCache.set(authId: authId, authKey: authKey, role: role);
    SessionManager.user = user;

    try {
      await Future.wait([
        _storage.write(key: 'auth_id', value: authId),
        _storage.write(key: 'auth_key', value: authKey),
        _storage.write(key: 'role', value: role),
        _storage.write(key: 'is_logged_in', value: 'true'),
        _storage.write(key: _userKey, value: jsonEncode(user)),
      ]);
    } catch (e) {
      // Login must not fail only because disk/Keystore write failed.
      if (kDebugMode) {
        // ignore: avoid_print
        print('[session] secure storage write failed (memory session kept): $e');
      }
    }
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
    if (AuthTokenCache.hasTokens) return true;
    final loggedIn = await _storage.read(key: 'is_logged_in');
    return loggedIn == 'true';
  }

  static Future<void> clearSession() async {
    AuthTokenCache.clear();
    user = null;
    try {
      await _storage.deleteAll();
    } catch (_) {}
  }
}
