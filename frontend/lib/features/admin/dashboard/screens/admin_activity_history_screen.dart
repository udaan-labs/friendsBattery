import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/admin_activity_history_provider.dart';
import '../widgets/activity_item_tile.dart';
import '../../../../shared/widgets/responsive_helper.dart';

class AdminActivityHistoryScreen extends ConsumerWidget {
  const AdminActivityHistoryScreen({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text('All'),
                    selected: true,
                    onSelected: (_) {},
                    selectedColor: const Color(0xFFE8F5E9),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Today'),
                    selected: false,
                    onSelected: (_) {},
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('This Week'),
                    selected: false,
                    onSelected: (_) {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: notifier.refresh,
              color: const Color(0xFF006B2C),
              child: state.items.isEmpty && state.isLoading
                  ? const Center(child: CircularProgressIndicator())

            : state.items.isEmpty && state.error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Failed to load history: ${state.error}'),
                        ElevatedButton(
                          onPressed: notifier.refresh,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : state.items.isEmpty
                    ? const Center(child: Text('No activity found.'))
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.responsiveHorizontalMargin(context),
                          vertical: 16,
                        ),
                        itemCount: state.items.length + 1,
                        itemBuilder: (context, index) {
                          if (index == state.items.length) {
                            if (state.hasNextPage) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 24.0),
                                child: Center(
                                  child: state.isLoading
                                      ? const CircularProgressIndicator()
                                      : ElevatedButton(
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
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.0),
                              child: Center(
                                child: Text(
                                  'No more activities',
                                  style: TextStyle(color: Colors.grey),
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

