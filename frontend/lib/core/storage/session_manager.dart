import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_token_cache.dart';
import 'local_storage.dart';

class SessionManager {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveSession({
    required String authId,
    required String authKey,
    required String role,
    required dynamic user,
  }) async {
    AuthTokenCache.set(authId: authId, authKey: authKey, role: role);

    await Future.wait([
      _storage.write(key: 'auth_id', value: authId),
      _storage.write(key: 'auth_key', value: authKey),
      _storage.write(key: 'role', value: role),
      _storage.write(key: 'is_logged_in', value: 'true'),
    ]);

    await LocalStorage.put('user', user);
  }

  static Future<Map<String, String?>> getSessionData() async {
    await AuthTokenCache.ensureLoaded();
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
    await _storage.deleteAll();
    await LocalStorage.delete('user');
  }
}
