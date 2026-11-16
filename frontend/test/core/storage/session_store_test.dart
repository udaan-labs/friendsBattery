import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/storage/auth_token_cache.dart';
import 'package:frontend/core/storage/local_store.dart';
import 'package:frontend/core/storage/session_manager.dart';

void main() {
  late Directory dir;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('fb_hive_');
    await LocalStore.init(path: dir.path);
    await SessionManager.clearSession();
    AuthTokenCache.debugUnload();
    SessionManager.user = null;
  });

  tearDown(() async {
    await LocalStore.close();
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
  });

  test('session round-trips through Hive after memory is cleared', () async {
    await SessionManager.saveSession(
      authId: 'id-1',
      authKey: 'key-1',
      role: 'admin',
      user: {'username': 'Kartik', 'shop_name': 'Shop'},
    );

    AuthTokenCache.debugUnload();
    SessionManager.user = null;

    expect(await SessionManager.isLoggedIn(), isTrue);
    final data = await SessionManager.getSessionData();
    expect(data['auth_id'], 'id-1');
    expect(data['auth_key'], 'key-1');
    expect(data['role'], 'admin');
    expect(SessionManager.user?['username'], 'Kartik');
    expect(SessionManager.user?['shop_name'], 'Shop');

    await LocalStore.putString('cache.id-1.admin.kpi', 'old');
    await SessionManager.clearSession();
    AuthTokenCache.debugUnload();
    SessionManager.user = null;

    expect(LocalStore.getString('cache.id-1.admin.kpi'), isNull);
    expect(await SessionManager.isLoggedIn(), isFalse);
    final cleared = await SessionManager.getSessionData();
    expect(cleared['auth_id'], isNull);
    expect(cleared['auth_key'], isNull);
    expect(cleared['role'], isNull);
    expect(SessionManager.user, isNull);
  });
}
