import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import '../providers/dashboard_providers.dart';

class RecentActivityTimeline extends ConsumerWidget {
  const RecentActivityTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityState = ref.watch(recentActivityProvider);

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
        default:
          return Icons.notifications_outlined;
      }
    }

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.responsiveHorizontalMargin(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.isSmallPhone(context) ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF191C1E),
                  ),
                ),
              InkWell(
                onTap: () {
                  context.push('/admin/activity-history');
                },
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
                  return _ActivityItem(
                    title: item['title'] ?? '',
                    subtitle: item['subtitle'] ?? '',
                    time: item['time'] ?? '',
                    icon: getIconData(item['icon'] ?? ''),
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
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isSmallPhone(context) ? 12 : 16, vertical: ResponsiveHelper.isSmallPhone(context) ? 10 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9), // light green
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFF006B2C), // dark green
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
            _formatTime(time),
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF586377),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(String timeIso) {
    try {
      final dt = DateTime.parse(timeIso).toLocal();
      // Only show date and time without milliseconds
      return '${dt.day.toString().padLeft(2, '0')} ${_getMonth(dt.month)} ${dt.hour > 12 ? dt.hour - 12 : dt.hour == 0 ? 12 : dt.hour}:${dt.minute.toString().padLeft(2, '0')} ${dt.hour >= 12 ? 'PM' : 'AM'}';
    } catch (e) {
      return timeIso;
    }
  }

  String _getMonth(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}
