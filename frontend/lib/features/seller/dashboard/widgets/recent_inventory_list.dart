import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../providers/seller_dashboard_providers.dart';
import '../../../../shared/widgets/snackbar_helper.dart';

class RecentInventoryList extends ConsumerWidget {
  const RecentInventoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentData = ref.watch(sellerRecentInventoryProvider);

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Inventory',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191C1E),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push('/seller/inventory');
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFF16A34A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          recentData.when(
            data: (items) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  color: Color(0xFFECEEF0),
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.cardPadding(context), vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFECEEF0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.battery_charging_full,
                                  color: Color(0xFF16A34A),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF191C1E),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.serialNumber,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF545F73),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 0,
                          child: _buildStatusBadge(item.status, context),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            loading: () => Center(
              child: Padding(
                padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (e, st) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status, BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Available':
        bgColor = const Color(0xFF16A34A).withValues(alpha: 0.1);
        textColor = const Color(0xFF16A34A);
        break;
      case 'Low Stock':
        bgColor = const Color(0xFFBA1A1A).withValues(alpha: 0.1);
        textColor = const Color(0xFFBA1A1A);
        break;
      case 'Sold':
      default:
        bgColor = const Color(0xFF545F73).withValues(alpha: 0.1);
        textColor = const Color(0xFF545F73);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isSmallPhone(context) ? 8 : 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
