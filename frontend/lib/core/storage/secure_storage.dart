import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_token_cache.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveAuthData(String authId, String authKey, String role) async {
    AuthTokenCache.set(authId: authId, authKey: authKey, role: role);
    await Future.wait([
      _storage.write(key: 'auth_id', value: authId),
      _storage.write(key: 'auth_key', value: authKey),
      _storage.write(key: 'role', value: role),
    ]);
  }

  static Future<Map<String, String?>> getAuthData() async {
    await AuthTokenCache.ensureLoaded();
    return {
      'auth_id': AuthTokenCache.authId,
      'auth_key': AuthTokenCache.authKey,
      'role': AuthTokenCache.role,
    };
  }

  static Future<void> clearAll() async {
    AuthTokenCache.clear();
    await _storage.deleteAll();
  }
}
