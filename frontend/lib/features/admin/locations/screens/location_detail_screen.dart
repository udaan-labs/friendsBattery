import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/utils/app_formatters.dart';
import '../../../shared/staff/providers/staff_providers.dart';
import '../../../shared/staff/widgets/staff_member_group.dart';

/// Admin: sellers + employees at one shop/warehouse.
class LocationDetailScreen extends ConsumerWidget {
  const LocationDetailScreen({
    super.key,
    required this.locationId,
    this.title,
  });

  final int locationId;

  /// Optional name for the app bar while staff loads (from list navigation).
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(locationStaffProvider(locationId));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          title ?? 'Location Details',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_outlined, color: Color(0xFF006B2C)),
            tooltip: 'Export Location Sales PDF',
            onPressed: () {
              context.push('/admin/sales');
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push(
            Uri(
              path: '/admin/add-employee',
              queryParameters: {'locationId': '$locationId'},
            ).toString(),
          );
          ref.invalidate(locationStaffProvider(locationId));
        },
        backgroundColor: const Color(0xFF006B2C),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Add employee'),
      ),
      body: staffAsync.when(
        data: (data) => RefreshIndicator(
          onRefresh: () =>
              ref.refresh(locationStaffProvider(locationId).future),
          child: _StaffList(data: data),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  friendlyError(e),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () =>
                      ref.invalidate(locationStaffProvider(locationId)),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StaffList extends StatelessWidget {
  const _StaffList({required this.data});

  final ShopStaffData data;

  @override
  Widget build(BuildContext context) {
    final location = data.location;
    final isShop = location?.type != 'WAREHOUSE';
    final sellers = data.sellers?.toList() ?? [];
    final employees = data.employees?.toList() ?? [];
    final empty = sellers.isEmpty && employees.isEmpty;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      children: [
        if (location != null) ...[
          Text(
            '${location.name ?? (isShop ? 'Shop' : 'Warehouse')}'
            '${location.code != null ? ' · ${location.code}' : ''}',
            style: const TextStyle(fontSize: 13, color: Color(0xFF545F73)),
          ),
          const SizedBox(height: 16),
        ],
        if (empty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.groups_outlined, size: 48, color: Colors.grey),
                const SizedBox(height: 12),
                const Text(
                  'No team yet',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  isShop
                      ? 'Assign a seller to this shop or add an employee.'
                      : 'Add an employee assigned to this warehouse.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFF64748B)),
                ),
              ],
            ),
          )
        else ...[
          StaffMemberGroup(
            title: 'Sellers',
            icon: Icons.storefront_rounded,
            color: const Color(0xFF006B2C),
            members: sellers,
            emptyLabel: 'No sellers at this location',
            showRoleChip: true,
          ),
          const SizedBox(height: 12),
          StaffMemberGroup(
            title: 'Employees',
            icon: Icons.badge_rounded,
            color: const Color(0xFF2563EB),
            members: employees,
            emptyLabel: 'No employees at this location',
            showRoleChip: true,
          ),
        ],
      ],
    );
  }
}
