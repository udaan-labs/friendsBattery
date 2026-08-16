import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

import '../../../../shared/utils/app_formatters.dart';
import '../../../shared/inventory/providers/inventory_provider.dart';
import '../../../shared/staff/providers/staff_providers.dart';
import '../../../shared/staff/widgets/staff_member_group.dart';
import 'location_header_card.dart';
import 'location_stock_section.dart';

/// Shop: header + admin/seller/employee + stock.
class ShopDetailBody extends ConsumerWidget {
  const ShopDetailBody({
    super.key,
    required this.locationId,
    this.cached,
  });

  final int locationId;
  final LocationItem? cached;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(locationStaffProvider(locationId));

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          ref.refresh(locationStaffProvider(locationId).future),
          ref.refresh(locationInventoryProvider(locationId).future),
        ]);
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        children: [
          LocationHeaderCard(
            staffLocation: staffAsync.valueOrNull?.location,
            cached: cached,
          ),
          const SizedBox(height: 16),
          staffAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Column(
              children: [
                Text(friendlyError(e), textAlign: TextAlign.center),
                TextButton(
                  onPressed: () =>
                      ref.invalidate(locationStaffProvider(locationId)),
                  child: const Text('Retry'),
                ),
              ],
            ),
            data: (data) {
              final admins = data.admins?.toList() ?? [];
              final leads = admins.isNotEmpty
                  ? admins
                  : (data.sellers?.toList() ?? []);
              return Column(
                children: [
                  StaffMemberGroup(
                    title: 'Admin / seller',
                    icon: Icons.storefront_rounded,
                    color: const Color(0xFF006B2C),
                    members: leads,
                    emptyLabel: 'No admin or seller at this shop',
                    showRoleChip: true,
                  ),
                  const SizedBox(height: 12),
                  StaffMemberGroup(
                    title: 'Employees',
                    icon: Icons.badge_rounded,
                    color: const Color(0xFF2563EB),
                    members: data.employees?.toList() ?? [],
                    emptyLabel: 'No employees at this shop',
                    showRoleChip: true,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          LocationStockSection(locationId: locationId),
        ],
      ),
    );
  }
}
