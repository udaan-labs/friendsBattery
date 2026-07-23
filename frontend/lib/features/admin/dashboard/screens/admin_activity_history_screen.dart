import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/admin_activity_history_provider.dart';
import '../providers/dashboard_providers.dart';
import '../../../../shared/widgets/responsive_helper.dart';

class AdminActivityHistoryScreen extends ConsumerWidget {
  const AdminActivityHistoryScreen({super.key});

  IconData getIconData(String iconName) {
    switch (iconName) {
      case 'inventory_2':
        return Icons.inventory_2_outlined;
      case 'person_add':
        return Icons.person_add_alt_1_outlined;
      case 'local_shipping':
        return Icons.local_shipping_outlined;
      case 'point_of_sale':
        return Icons.point_of_sale_outlined;
      case 'assignment_return':
        return Icons.assignment_return_outlined;
      default:
        return Icons.notifications_outlined;
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
      body: RefreshIndicator(
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
                        itemCount: state.items.length + 1, // +1 for the loading/View More indicator
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
                            } else {
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
                          }

                          final item = state.items[index];
                          return _ActivityItem(
                            title: item.title ?? '',
                            subtitle: item.subtitle ?? '',
                            time: activityTimeLabel(item.time),
                            icon: getIconData(item.icon ?? ''),
                          );
                        },
                      ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;

  const _ActivityItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECEEF0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.isSmallPhone(context) ? 12 : 16,
        vertical: ResponsiveHelper.isSmallPhone(context) ? 10 : 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFF006B2C),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF191C1E),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF586377),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time, // Optionally format the time here
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF586377),
            ),
          ),
        ],
      ),
    );
  }
}
