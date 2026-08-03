/// Hooks Dio / UI into auth without circular imports.
/// Wire [handleUnauthorized] once from the app shell (has Riverpod [Ref]).
class SessionGuard {
  SessionGuard._();

  /// Clear local session + auth state. Must not call protected APIs.
  static Future<void> Function()? handleUnauthorized;

  static bool _busy = false;

  static Future<void> forceUnauthorized() async {
    if (_busy) return;
    final handler = handleUnauthorized;
    if (handler == null) return;
    _busy = true;
    try {
      await handler();
    } finally {
      _busy = false;
    }
  }
}
