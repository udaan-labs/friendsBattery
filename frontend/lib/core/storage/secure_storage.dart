import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  
  static Future<void> saveAuthData(String authId, String authKey, String role) async {
    await _storage.write(key: 'auth_id', value: authId);
    await _storage.write(key: 'auth_key', value: authKey);
    await _storage.write(key: 'role', value: role);
  }

  static Future<Map<String, String?>> getAuthData() async {
    return {
      'auth_id': await _storage.read(key: 'auth_id'),
      'auth_key': await _storage.read(key: 'auth_key'),
      'role': await _storage.read(key: 'role'),
    };
  }
  
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
