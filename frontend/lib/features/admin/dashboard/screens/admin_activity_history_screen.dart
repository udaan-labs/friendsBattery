import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/admin_activity_history_provider.dart';
import '../widgets/activity_item_tile.dart';
import '../../../../shared/widgets/responsive_helper.dart';

class AdminActivityHistoryScreen extends ConsumerWidget {
  const AdminActivityHistoryScreen({super.key});

  String _periodLabel(ActivityPeriod p, DateTimeRange? custom) {
    switch (p) {
      case ActivityPeriod.today:
        return 'Today';
      case ActivityPeriod.week:
        return 'This week';
      case ActivityPeriod.month:
        return 'This month';
      case ActivityPeriod.custom:
        if (custom == null) return 'Date';
        final a = custom.start;
        final b = custom.end;
        String d(DateTime t) =>
            '${t.day.toString().padLeft(2, '0')}/${t.month.toString().padLeft(2, '0')}';
        return '${d(a)} – ${d(b)}';
    }
  }

  Future<void> _pickDates(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();
    final current = ref.read(adminActivityHistoryProvider).customRange;
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 2),
      lastDate: now,
      initialDateRange: current ??
          DateTimeRange(start: DateTime(now.year, now.month, now.day), end: now),
    );
    if (picked != null) {
      await ref.read(adminActivityHistoryProvider.notifier).setCustomRange(picked);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminActivityHistoryProvider);
    final notifier = ref.read(adminActivityHistoryProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Activity History', style: TextStyle(color: Color(0xFF006B2C))),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF191C1E)),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final p in ActivityPeriod.values) ...[
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(_periodLabel(p, state.customRange)),
                        selected: state.period == p,
                        onSelected: (_) {
                          if (p == ActivityPeriod.custom) {
                            _pickDates(context, ref);
                          } else {
                            notifier.setPeriod(p);
                          }
                        },
                        selectedColor: const Color(0xFFE8F5E9),
                        labelStyle: TextStyle(
                          color: state.period == p
                              ? const Color(0xFF006B2C)
                              : const Color(0xFF586377),
                          fontWeight:
                              state.period == p ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 13,
                        ),
                        side: BorderSide(
                          color: state.period == p
                              ? const Color(0xFF006B2C)
                              : const Color(0xFFECEEF0),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: notifier.refresh,
              color: const Color(0xFF006B2C),
              child: state.items.isEmpty && state.isLoading
                  ? ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.responsiveHorizontalMargin(context),
                        vertical: 16,
                      ),
                      itemCount: 8,
                      itemBuilder: (_, __) => const ActivityItemSkeleton(),
                    )
                  : state.items.isEmpty && state.error != null
                      ? ListView(
                          children: [
                            const SizedBox(height: 120),
                            Center(child: Text('Failed to load history: ${state.error}')),
                            Center(
                              child: ElevatedButton(
                                onPressed: notifier.refresh,
                                child: const Text('Retry'),
                              ),
                            ),
                          ],
                        )
                      : state.items.isEmpty
                          ? ListView(
                              children: const [
                                SizedBox(height: 120),
                                Center(child: Text('No activity found.')),
                              ],
                            )
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    ResponsiveHelper.responsiveHorizontalMargin(context),
                                vertical: 16,
                              ),
                              itemCount: state.items.length + (state.hasNextPage ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index == state.items.length) {
                                  if (state.isLoading) {
                                    return const Column(
                                      children: [
                                        ActivityItemSkeleton(),
                                        ActivityItemSkeleton(),
                                      ],
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                                    child: Center(
                                      child: ElevatedButton(
                                        onPressed: notifier.loadNextPage,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF006B2C),
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text('Load More'),
                                      ),
                                    ),
                                  );
                                }

                                final item = state.items[index];
                                return ActivityItemTile(
                                  title: item.title ?? '',
                                  subtitle: item.subtitle ?? '',
                                  time: relativeTimeLabel(item.time),
                                  icon: activityIconFor(item.icon),
                                );
                              },
                            ),
            ),
          ),
        ],
      ),
    );
  }
}
