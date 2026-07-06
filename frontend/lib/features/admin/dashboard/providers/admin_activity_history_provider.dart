import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';
import '../services/dashboard_api_service.dart';

class ActivityHistoryState {
  final List<dynamic> items;
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
    List<dynamic>? items,
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
  final DashboardApiService _apiService;

  AdminActivityHistoryNotifier(this._apiService) : super(ActivityHistoryState()) {
    loadNextPage();
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || !state.hasNextPage) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiService.getActivityHistory(state.page, 20);
      final newItems = response['data'] as List<dynamic>? ?? [];
      final pagination = response['pagination'] as Map<String, dynamic>?;

      final hasNextPage = pagination?['hasNextPage'] ?? false;

      state = state.copyWith(
        items: [...state.items, ...newItems],
        page: state.page + 1,
        hasNextPage: hasNextPage,
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

final adminActivityHistoryProvider = StateNotifierProvider.autoDispose<AdminActivityHistoryNotifier, ActivityHistoryState>((ref) {
  final dio = ref.watch(dioProvider);
  final apiService = DashboardApiService(dio: dio);
  return AdminActivityHistoryNotifier(apiService);
});
