import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';

enum ActivityPeriod { today, week, month, custom }

class ActivityHistoryState {
  final List<ActivityItem> items;
  final String? nextCursor;
  final bool hasNextPage;
  final bool isLoading;
  final String? error;
  final ActivityPeriod period;
  final DateTimeRange? customRange;

  ActivityHistoryState({
    this.items = const [],
    this.nextCursor,
    this.hasNextPage = true,
    this.isLoading = false,
    this.error,
    this.period = ActivityPeriod.today,
    this.customRange,
  });

  ActivityHistoryState copyWith({
    List<ActivityItem>? items,
    String? nextCursor,
    bool? hasNextPage,
    bool? isLoading,
    String? error,
    ActivityPeriod? period,
    DateTimeRange? customRange,
  }) {
    return ActivityHistoryState(
      items: items ?? this.items,
      nextCursor: nextCursor ?? this.nextCursor,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      period: period ?? this.period,
      customRange: customRange ?? this.customRange,
    );
  }
}

class AdminActivityHistoryNotifier extends StateNotifier<ActivityHistoryState> {
  final FriendsBatteryApi _api;

  AdminActivityHistoryNotifier(this._api) : super(ActivityHistoryState()) {
    loadNextPage();
  }

  ({DateTime? from, DateTime? to}) _range() {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    switch (state.period) {
      case ActivityPeriod.today:
        return (from: todayStart, to: now);
      case ActivityPeriod.week:
        final weekStart = todayStart.subtract(Duration(days: now.weekday - 1));
        return (from: weekStart, to: now);
      case ActivityPeriod.month:
        return (from: DateTime(now.year, now.month, 1), to: now);
      case ActivityPeriod.custom:
        final r = state.customRange;
        if (r == null) return (from: todayStart, to: now);
        final end = DateTime(r.end.year, r.end.month, r.end.day, 23, 59, 59);
        return (from: r.start, to: end);
    }
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || !state.hasNextPage) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final range = _range();
      final response = await _api.getDashboardApi().apiDashboardActivityHistoryGet(
        cursor: state.nextCursor,
        limit: 20,
        // Iso8601DateTimeSerializer rejects non-UTC DateTimes.
        fromDate: range.from?.toUtc(),
        toDate: range.to?.toUtc(),
      );
      final body = response.data;

      state = state.copyWith(
        items: [...state.items, ...body?.data?.toList() ?? const []],
        nextCursor: body?.pagination?.nextCursor,
        hasNextPage: body?.pagination?.hasNextPage ?? false,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = ActivityHistoryState(
      period: state.period,
      customRange: state.customRange,
    );
    await loadNextPage();
  }

  Future<void> setPeriod(ActivityPeriod period) async {
    if (period == ActivityPeriod.custom && state.customRange == null) return;
    state = ActivityHistoryState(
      period: period,
      customRange: period == ActivityPeriod.custom ? state.customRange : null,
    );
    await loadNextPage();
  }

  Future<void> setCustomRange(DateTimeRange range) async {
    state = ActivityHistoryState(
      period: ActivityPeriod.custom,
      customRange: range,
    );
    await loadNextPage();
  }
}

final adminActivityHistoryProvider =
    StateNotifierProvider.autoDispose<AdminActivityHistoryNotifier, ActivityHistoryState>((ref) {
  return AdminActivityHistoryNotifier(ref.watch(apiClientProvider));
});
