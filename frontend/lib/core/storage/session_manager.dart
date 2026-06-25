import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'local_storage.dart';

class SessionManager {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveSession({
    required String authId,
    required String authKey,
    required String role,
    required dynamic user,
  }) async {
    // Save secure tokens
    await _storage.write(key: 'auth_id', value: authId);
    await _storage.write(key: 'auth_key', value: authKey);
    await _storage.write(key: 'role', value: role);
    await _storage.write(key: 'is_logged_in', value: 'true');

    // Save general user data
    await LocalStorage.put('user', user);
  }

  static Future<Map<String, String?>> getSessionData() async {
    return {
      'auth_id': await _storage.read(key: 'auth_id'),
      'auth_key': await _storage.read(key: 'auth_key'),
      'role': await _storage.read(key: 'role'),
    };
  }

  static Future<bool> isLoggedIn() async {
    final loggedIn = await _storage.read(key: 'is_logged_in');
    return loggedIn == 'true';
  }

  static Future<void> clearSession() async {
    await _storage.deleteAll();
    await LocalStorage.delete('user');
  }
}
