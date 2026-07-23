import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';

class ActivityHistoryState {
  final List<ActivityItem> items;
  final int page;
  final bool hasNextPage;
  final bool isLoading;
  final String? error;

  ActivityHistoryState({
    this.items = const [],
    this.page = 1,
    this.hasNextPage = true,
    this.isLoading = false,
    this.error,
  });

  ActivityHistoryState copyWith({
    List<ActivityItem>? items,
    int? page,
    bool? hasNextPage,
    bool? isLoading,
    String? error,
  }) {
    return ActivityHistoryState(
      items: items ?? this.items,
      page: page ?? this.page,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AdminActivityHistoryNotifier extends StateNotifier<ActivityHistoryState> {
  final FriendsBatteryApi _api;

  AdminActivityHistoryNotifier(this._api) : super(ActivityHistoryState()) {
    loadNextPage();
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || !state.hasNextPage) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _api.getDashboardApi().apiDashboardActivityHistoryGet(
        page: state.page,
        limit: 20,
      );
      final body = response.data;

      state = state.copyWith(
        items: [...state.items, ...body?.data?.toList() ?? const []],
        page: state.page + 1,
        hasNextPage: body?.pagination?.hasNextPage ?? false,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = ActivityHistoryState();
    await loadNextPage();
  }
}

final adminActivityHistoryProvider =
    StateNotifierProvider.autoDispose<AdminActivityHistoryNotifier, ActivityHistoryState>((ref) {
  return AdminActivityHistoryNotifier(ref.watch(apiClientProvider));
});
