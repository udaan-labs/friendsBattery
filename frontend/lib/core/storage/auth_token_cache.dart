import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// In-memory auth credentials so Dio does not hit [FlutterSecureStorage]
/// on every HTTP request (secure storage is often 50–200ms+ per read on device).
class AuthTokenCache {
  AuthTokenCache._();

  static const _storage = FlutterSecureStorage();

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

  /// Load once from secure storage (parallel reads). Safe to call repeatedly.
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
    final results = await Future.wait([
      _storage.read(key: 'auth_id'),
      _storage.read(key: 'auth_key'),
      _storage.read(key: 'role'),
    ]);
    authId = results[0];
    authKey = results[1];
    role = results[2];
    _loaded = true;
  }
}
