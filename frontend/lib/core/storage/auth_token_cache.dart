import 'package:flutter/foundation.dart';

import 'local_store.dart';

/// In-memory auth credentials so Dio does not hit Hive on every HTTP request.
class AuthTokenCache {
  AuthTokenCache._();

  static const authIdKey = 'auth_id';
  static const authKeyKey = 'auth_key';
  static const roleKey = 'role';

  static String? authId;
  static String? authKey;
  static String? role;
  static bool _loaded = false;
  static Future<void>? _loading;

  static bool get hasTokens =>
      authId != null &&
      authId!.isNotEmpty &&
      authKey != null &&
      authKey!.isNotEmpty;

  static void set({
    required String authId,
    required String authKey,
    String? role,
  }) {
    AuthTokenCache.authId = authId;
    AuthTokenCache.authKey = authKey;
    AuthTokenCache.role = role;
    _loaded = true;
  }

  static void clear() {
    authId = null;
    authKey = null;
    role = null;
    _loaded = true;
    _loading = null;
  }

  /// Drop memory so the next [ensureLoaded] reads Hive again.
  @visibleForTesting
  static void debugUnload() {
    authId = null;
    authKey = null;
    role = null;
    _loaded = false;
    _loading = null;
  }

  /// Load once from Hive. Safe to call repeatedly.
  static Future<void> ensureLoaded() async {
    if (_loaded) return;
    if (_loading != null) {
      await _loading;
      return;
    }
    _loading = _load();
    try {
      await _loading;
    } finally {
      _loading = null;
    }
  }

  static Future<void> _load() async {
    authId = LocalStore.getString(authIdKey);
    authKey = LocalStore.getString(authKeyKey);
    role = LocalStore.getString(roleKey);
    _loaded = true;
  }
}
