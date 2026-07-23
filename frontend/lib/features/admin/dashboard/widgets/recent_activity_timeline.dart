import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../providers/dashboard_providers.dart';
import 'activity_item_tile.dart';

class RecentActivityTimeline extends ConsumerWidget {
  const RecentActivityTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityState = ref.watch(recentActivityProvider);

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.responsiveHorizontalMargin(context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.isSmallPhone(context) ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF191C1E),
                  ),
                ),
                InkWell(
                  onTap: () => context.push('/admin/activity-history'),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View all',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF006B2C),
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xFF006B2C),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ResponsiveHelper.isSmallPhone(context) ? 12 : 16),
          activityState.when(
            data: (activities) {
              if (activities.isEmpty) {
                return const Text('No recent activity.');
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final item = activities[index];
                  return ActivityItemTile(
                    title: item.title ?? '',
                    subtitle: item.subtitle ?? '',
                    time: relativeTimeLabel(item.time),
                    icon: activityIconFor(item.icon),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
