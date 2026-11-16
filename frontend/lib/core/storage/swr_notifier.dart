import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_token_cache.dart';
import 'local_store.dart';

/// Shows the last Hive snapshot immediately, then replaces it when [fetch] returns.
/// A failed refresh keeps the snapshot on screen.
class SwrNotifier<T> extends StateNotifier<AsyncValue<T>> {
  SwrNotifier({
    required String key,
    required this.decode,
    required this.encode,
    required this.fetch,
  })  : cacheKey = cacheScope(key),
        super(readCached(cacheScope(key), decode)) {
    _inflight = _refresh();
  }

  final String cacheKey;
  final T? Function(Object? json) decode;
  final Object? Function(T value) encode;
  final Future<T> Function() fetch;

  Future<void> _inflight = Future<void>.value();

  Future<void> get settled => _inflight;

  static String cacheScope(String key) {
    final id = AuthTokenCache.authId;
    final who = (id == null || id.isEmpty) ? 'anon' : id;
    return 'cache.$who.$key';
  }

  Future<void> reload() {
    final run = _refresh();
    _inflight = run;
    return run;
  }

  /// Push a value that another provider already loaded. Writes Hive too.
  void adopt(T value) {
    if (!mounted) return;
    state = AsyncData(value);
    _persist(value);
  }

  Future<void> _refresh() async {
    try {
      final fresh = await fetch();
      if (!mounted) return;
      state = AsyncData(fresh);
      if (!mounted) return;
      await _persist(fresh);
    } catch (error, stack) {
      if (!mounted) return;
      if (state.hasValue) return;
      state = AsyncError(error, stack);
    }
  }

  Future<void> _persist(T value) async {
    try {
      await LocalStore.putString(cacheKey, jsonEncode(encode(value)));
    } catch (_) {}
  }

}

AsyncValue<T> readCached<T>(String cacheKey, T? Function(Object? json) decode) {
  final raw = LocalStore.getString(cacheKey);
  if (raw == null) return AsyncValue<T>.loading();
  try {
    final value = decode(jsonDecode(raw));
    if (value == null) return AsyncValue<T>.loading();
    return AsyncData(value);
  } catch (_) {
    return AsyncValue<T>.loading();
  }
}

List<Object?> encodeBuiltList<T>(List<T> items, Object? Function(T item) encodeItem) =>
    [for (final item in items) encodeItem(item)];

List<T>? decodeBuiltList<T>(Object? json, T? Function(Object? item) decodeItem) {
  if (json is! List) return null;
  final out = <T>[];
  for (final item in json) {
    final value = decodeItem(item);
    if (value != null) out.add(value);
  }
  return out;
}
