import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../core/network/api_client_provider.dart';
import '../repository/app_gate_repository.dart';

enum AppGateMode { none, updateRequired, maintenance }

class AppGateState {
  final AppGateMode mode;
  final String? message;
  final String? updateUrl;
  final String? localVersion;
  final String? latestVersion;
  /// True after first check attempt (success or fail-open).
  final bool checked;
  final bool isLoading;

  const AppGateState({
    this.mode = AppGateMode.none,
    this.message,
    this.updateUrl,
    this.localVersion,
    this.latestVersion,
    this.checked = false,
    this.isLoading = false,
  });

  bool get isBlocked => mode != AppGateMode.none;

  AppGateState copyWith({
    AppGateMode? mode,
    String? message,
    String? updateUrl,
    String? localVersion,
    String? latestVersion,
    bool? checked,
    bool? isLoading,
  }) {
    return AppGateState(
      mode: mode ?? this.mode,
      message: message ?? this.message,
      updateUrl: updateUrl ?? this.updateUrl,
      localVersion: localVersion ?? this.localVersion,
      latestVersion: latestVersion ?? this.latestVersion,
      checked: checked ?? this.checked,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final appGateRepositoryProvider = Provider<AppGateRepository>((ref) {
  return AppGateRepository(api: ref.watch(apiClientProvider));
});

class AppGateNotifier extends StateNotifier<AppGateState> {
  final AppGateRepository _repository;

  AppGateNotifier(this._repository) : super(const AppGateState());

  /// Fail-open without a network round-trip (timeout / storage hang / dispose).
  /// No-ops if a real check already finished (does not clear update/maintenance).
  void markFailOpen() {
    if (!mounted || state.checked) return;
    state = AppGateState(
      mode: AppGateMode.none,
      localVersion: state.localVersion,
      latestVersion: state.latestVersion,
      checked: true,
      isLoading: false,
    );
  }

  /// Fetch remote status, compare to local package version.
  /// Network/API errors → fail-open ([AppGateMode.none]).
  ///
  /// Does **not** set state before the first await — sync state updates from
  /// Splash [initState] remounted the whole router and overflowed the stack.
  Future<void> check() async {
    if (!mounted) return;
    try {
      final info = await PackageInfo.fromPlatform();
      if (!mounted) return;
      final localVersion = info.version.trim();

      final remote = await _repository.fetchStatus();
      if (!mounted) return;

      final latest = (remote.latestVersion ?? '').trim();
      final maintenance = remote.maintenance == true;
      final message = remote.message;
      final updateUrl = remote.androidUpdateUrl;

      AppGateMode mode = AppGateMode.none;
      if (maintenance) {
        mode = AppGateMode.maintenance;
      } else if (latest.isNotEmpty && localVersion != latest) {
        mode = AppGateMode.updateRequired;
      }

      state = AppGateState(
        mode: mode,
        message: message,
        updateUrl: updateUrl,
        localVersion: localVersion,
        latestVersion: latest.isEmpty ? null : latest,
        checked: true,
        isLoading: false,
      );
    } catch (_) {
      if (!mounted) return;
      // Fail-open: do not lock users out if status API is unreachable.
      state = AppGateState(
        mode: AppGateMode.none,
        localVersion: state.localVersion,
        checked: true,
        isLoading: false,
      );
    }
  }
}

final appGateProvider =
    StateNotifierProvider<AppGateNotifier, AppGateState>((ref) {
  // read (not watch): recreating this notifier resets checked → splash loop.
  return AppGateNotifier(ref.read(appGateRepositoryProvider));
});
