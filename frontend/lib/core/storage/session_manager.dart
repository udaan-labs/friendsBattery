import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'auth_token_cache.dart';
import 'local_store.dart';

/// Session tokens + cached profile (Hive box + in-memory for sync UI reads).
class SessionManager {
  static const _userKey = 'user_json';
  static const _loggedInKey = 'is_logged_in';

  /// Profile map for dashboard greetings. Sync after [saveSession]/[getSessionData].
  static Map<String, dynamic>? user;

  /// Bumped on logout so the app builds a fresh provider tree.
  static final restartTick = ValueNotifier<int>(0);

  static Future<void> saveSession({
    required String authId,
    required String authKey,
    required String role,
    required Map<String, dynamic> user,
  }) async {
    // Memory first so router + Dio work even if the box write fails.
    AuthTokenCache.set(authId: authId, authKey: authKey, role: role);
    SessionManager.user = user;

    try {
      await LocalStore.putAll({
        AuthTokenCache.authIdKey: authId,
        AuthTokenCache.authKeyKey: authKey,
        AuthTokenCache.roleKey: role,
        _loggedInKey: 'true',
        _userKey: jsonEncode(user),
      });
    } catch (_) {}
  }

  static Future<Map<String, String?>> getSessionData() async {
    await AuthTokenCache.ensureLoaded();
    if (user == null) {
      final raw = LocalStore.getString(_userKey);
      if (raw != null) {
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
    return LocalStore.getString(_loggedInKey) == 'true';
  }

  static Future<void> clearSession() async {
    AuthTokenCache.clear();
    user = null;
    try {
      await LocalStore.clear();
    } catch (_) {}
    restartTick.value++;
  }
}
