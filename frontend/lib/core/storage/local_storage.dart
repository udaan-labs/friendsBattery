import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static late Box _cacheBox;

  static Future<void> init() async {
    _cacheBox = await Hive.openBox('cacheBox');
  }

  static Future<void> put(String key, dynamic value) async {
    await _cacheBox.put(key, value);
  }

  static dynamic get(String key) {
    return _cacheBox.get(key);
  }

  static Future<void> delete(String key) async {
    await _cacheBox.delete(key);
  }

  static Future<void> clearAll() async {
    await _cacheBox.clear();
  }
}
