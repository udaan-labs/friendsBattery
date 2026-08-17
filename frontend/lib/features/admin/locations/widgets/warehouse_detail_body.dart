import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/utils/app_formatters.dart';
import '../../../shared/inventory/providers/inventory_provider.dart';
import '../../../shared/staff/providers/staff_providers.dart';
import '../../../shared/staff/widgets/people_search_field.dart';
import '../../../shared/staff/widgets/staff_member_group.dart';
import '../providers/locations_providers.dart';
import 'location_header_card.dart';
import 'location_staff_actions.dart';
import 'location_stock_section.dart';
import 'warehouse_shops_section.dart';

/// Warehouse: header + team + shops + stock.
class WarehouseDetailBody extends ConsumerWidget {
  const WarehouseDetailBody({
    super.key,
    required this.locationId,
    this.cached,
  });

  final int locationId;
  final LocationItem? cached;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSuperAdmin = ref.watch(authProvider).role == UserRole.superAdmin;
    final staffAsync = ref.watch(locationStaffProvider(locationId));
    final staffQuery = ref.watch(locationStaffQueryProvider(locationId));

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(allLocationsProvider);
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
              final onToggle = isSuperAdmin
                  ? (ShopStaffMember m, bool next) => setLocationStaffActive(
                        context,
                        ref,
                        locationId: locationId,
                        member: m,
                        isActive: next,
                      )
                  : null;
              final onMove = isSuperAdmin
                  ? (ShopStaffMember m) => moveLocationEmployee(
                        context,
                        ref,
                        locationId: locationId,
                        member: m,
                      )
                  : null;
              return Column(
                children: [
                  PeopleSearchField(
                    hint: 'Search admin or employee…',
                    onChanged: (v) => ref
                        .read(locationStaffQueryProvider(locationId).notifier)
                        .state = v,
                  ),
                  const SizedBox(height: 12),
                  StaffMemberGroup(
                    title: 'Admins',
                    icon: Icons.admin_panel_settings_outlined,
                    color: const Color(0xFF7C3AED),
                    members: (data.admins?.toList() ?? [])
                        .where((m) => staffMatchesQuery(m, staffQuery))
                        .toList(),
                    emptyLabel: staffQuery.trim().isEmpty
                        ? 'No admin at this warehouse'
                        : 'No match for this search',
                    showRoleChip: true,
                    addLabel: 'Add admin',
                    onAdd: isSuperAdmin
                        ? () => context.push(
                              '/admin/add-admin?locationId=$locationId',
                            )
                        : null,
                    onToggleActive: onToggle,
                  ),
                  const SizedBox(height: 12),
                  StaffMemberGroup(
                    title: 'Employees',
                    icon: Icons.badge_rounded,
                    color: const Color(0xFF2563EB),
                    members: (data.employees?.toList() ?? [])
                        .where((m) => staffMatchesQuery(m, staffQuery))
                        .toList(),
                    emptyLabel: staffQuery.trim().isEmpty
                        ? 'No employees at this warehouse'
                        : 'No match for this search',
                    showRoleChip: true,
                    onToggleActive: onToggle,
                    onMove: onMove,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          WarehouseShopsSection(warehouseId: locationId),
          const SizedBox(height: 16),
          LocationStockSection(locationId: locationId),
        ],
      ),
    );
  }
}
