import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/staff/providers/staff_providers.dart';
import '../../../shared/staff/widgets/staff_member_group.dart';

/// Admin: list sellers and employees for this shop location.
class ShopStaffSection extends ConsumerWidget {
  final int sellerId;

  const ShopStaffSection({super.key, required this.sellerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(shopStaffProvider(sellerId));

    return staffAsync.when(
      data: (data) => _StaffBody(data: data, sellerId: sellerId),
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shop team',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => ref.invalidate(shopStaffProvider(sellerId)),
              child: const Text('Retry loading staff'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StaffBody extends StatelessWidget {
  final ShopStaffData data;
  final int sellerId;

  const _StaffBody({required this.data, required this.sellerId});

  void _openAddEmployee(BuildContext context) {
    final locationId = data.location?.id;
    context.push(
      Uri(
        path: '/admin/add-employee',
        queryParameters: {
          'sellerId': '$sellerId',
          if (locationId != null) 'locationId': '$locationId',
        },
      ).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final location = data.location;
    final sellers = data.sellers?.toList() ?? [];
    final employees = data.employees?.toList() ?? [];
    final noLocation = location == null;
    final empty = sellers.isEmpty && employees.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Shop team',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            if (!noLocation)
              TextButton.icon(
                onPressed: () => _openAddEmployee(context),
                icon: const Icon(Icons.person_add_alt_1, size: 18),
                label: const Text('Add employee'),
              ),
          ],
        ),
        if (location != null) ...[
          const SizedBox(height: 4),
          Text(
            '${location.name ?? 'Shop'}${location.code != null ? ' · ${location.code}' : ''}',
            style: const TextStyle(fontSize: 13, color: Color(0xFF545F73)),
          ),
        ],
        const SizedBox(height: 12),
        if (noLocation)
          _EmptyCard(
            icon: Icons.store_mall_directory_outlined,
            title: 'No location assigned',
            subtitle: 'Assign this seller to a shop location to see team members.',
          )
        else if (empty)
          _EmptyCard(
            icon: Icons.groups_outlined,
            title: 'No team at this shop',
            subtitle: 'No sellers or employees yet. Add an employee to this location.',
          )
        else ...[
          StaffMemberGroup(
            title: 'Sellers',
            icon: Icons.storefront_rounded,
            color: const Color(0xFF006B2C),
            members: sellers,
            emptyLabel: 'No sellers at this shop',
            showRoleChip: true,
          ),
          const SizedBox(height: 12),
          StaffMemberGroup(
            title: 'Employees',
            icon: Icons.badge_rounded,
            color: const Color(0xFF2563EB),
            members: employees,
            emptyLabel: 'No employees at this shop',
            showRoleChip: true,
          ),
        ],
      ],
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.grey),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
