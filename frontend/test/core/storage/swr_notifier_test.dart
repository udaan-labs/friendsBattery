import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:frontend/core/storage/auth_token_cache.dart';
import 'package:frontend/core/storage/local_store.dart';
import 'package:frontend/core/storage/swr_notifier.dart';

void main() {
  late Directory dir;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('fb_swr_');
    await LocalStore.init(path: dir.path);
    AuthTokenCache.debugUnload();
  });

  tearDown(() async {
    await LocalStore.close();
    if (dir.existsSync()) dir.deleteSync(recursive: true);
  });

  test('cached value shows before fetch, then the new value replaces it', () async {
    await LocalStore.putString(SwrNotifier.cacheScope('n'), '1');
    var fetches = 0;
    final notifier = SwrNotifier<int>(
      key: 'n',
      decode: (json) => json is num ? json.toInt() : null,
      encode: (value) => value,
      fetch: () async {
        fetches += 1;
        return 7;
      },
    );

    expect(notifier.state.value, 1);
    await notifier.settled;
    expect(fetches, 1);
    expect(notifier.state.value, 7);
    expect(LocalStore.getString(SwrNotifier.cacheScope('n')), '7');

    notifier.dispose();

    final again = SwrNotifier<int>(
      key: 'n',
      decode: (json) => json is num ? json.toInt() : null,
      encode: (value) => value,
      fetch: () async => 7,
    );
    expect(again.state.value, 7);
    await again.settled;
    again.dispose();
  });

  test('failed refresh keeps the cached value', () async {
    await LocalStore.putString(SwrNotifier.cacheScope('n'), '4');
    final notifier = SwrNotifier<int>(
      key: 'n',
      decode: (json) => json is num ? json.toInt() : null,
      encode: (value) => value,
      fetch: () async => throw Exception('offline'),
    );

    expect(notifier.state.value, 4);
    await notifier.settled;
    expect(notifier.state.value, 4);
    notifier.dispose();
  });

  test('dashboard stat json round-trips', () {
    final stats = AdminDashboardStats((builder) => builder
      ..totalStock = 3
      ..todaySales = 1
      ..pendingShipments = 2);
    final back = standardSerializers.deserializeWith(
      AdminDashboardStats.serializer,
      standardSerializers.serializeWith(AdminDashboardStats.serializer, stats),
    );
    expect(back?.totalStock, 3);
    expect(back?.todaySales, 1);
    expect(back?.pendingShipments, 2);

    final activity = ActivityItem((builder) => builder
      ..title = 'Sold'
      ..subtitle = 'Shop'
      ..icon = 'sale');
    final decoded = decodeBuiltList(
      encodeBuiltList(
        [activity],
        (item) => standardSerializers.serializeWith(ActivityItem.serializer, item),
      ),
      (item) => standardSerializers.deserializeWith(ActivityItem.serializer, item),
    );
    expect(decoded?.single.title, 'Sold');
    expect(decoded?.single.subtitle, 'Shop');
  });
}
