import 'package:hive_flutter/hive_flutter.dart';

/// Single on-device box. Session and any other local keys go through here.
class LocalStore {
  static const boxName = 'app';

  static Box<String>? _box;

  /// [path] is for tests. The app leaves it null and uses the documents dir.
  static Future<void> init({String? path}) async {
    if (_box != null && _box!.isOpen) return;
    if (path == null) {
      await Hive.initFlutter();
    } else {
      Hive.init(path);
    }
    _box = await Hive.openBox<String>(boxName);
  }

  static String? getString(String key) {
    final opened = _box;
    if (opened == null || !opened.isOpen) return null;
    final value = opened.get(key);
    if (value == null || value.isEmpty) return null;
    return value;
  }

  static Future<void> putString(String key, String value) => putAll({key: value});

  static Future<void> putAll(Map<String, String> entries) async {
    final opened = _box;
    if (opened == null || !opened.isOpen) return;
    await opened.putAll(entries);
  }

  static Future<void> deleteAll(Iterable<String> keys) async {
    final opened = _box;
    if (opened == null || !opened.isOpen) return;
    await opened.deleteAll(keys);
  }

  static Future<void> clear() async {
    final opened = _box;
    if (opened == null || !opened.isOpen) return;
    await opened.clear();
  }

  static Future<void> close() async {
    final opened = _box;
    _box = null;
    if (opened != null && opened.isOpen) {
      await opened.close();
    }
  }
}
