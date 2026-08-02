import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../providers/shop_staff_provider.dart';

/// Admin: list sellers and employees for this shop location.
class ShopStaffSection extends ConsumerWidget {
  final int sellerId;

  const ShopStaffSection({super.key, required this.sellerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(shopStaffProvider(sellerId));

    return staffAsync.when(
      data: (data) => _StaffBody(data: data, onRetry: () => ref.invalidate(shopStaffProvider(sellerId))),
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
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
  final VoidCallback onRetry;

  const _StaffBody({required this.data, required this.onRetry});

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
        const Text(
          'Shop team',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
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
            subtitle: 'No sellers or employees are linked to this location yet.',
          )
        else ...[
          _RoleGroup(
            title: 'Sellers',
            icon: Icons.storefront_rounded,
            color: const Color(0xFF006B2C),
            members: sellers,
            emptyLabel: 'No sellers at this shop',
          ),
          const SizedBox(height: 12),
          _RoleGroup(
            title: 'Employees',
            icon: Icons.badge_rounded,
            color: const Color(0xFF2563EB),
            members: employees,
            emptyLabel: 'No employees at this shop',
          ),
        ],
      ],
    );
  }
}

class _RoleGroup extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<ShopStaffMember> members;
  final String emptyLabel;

  const _RoleGroup({
    required this.title,
    required this.icon,
    required this.color,
    required this.members,
    required this.emptyLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
              Text(
                '$title (${members.length})',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (members.isEmpty)
            Text(emptyLabel, style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)))
          else
            ...members.map((m) => _MemberTile(member: m, accent: color)),
        ],
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final ShopStaffMember member;
  final Color accent;

  const _MemberTile({required this.member, required this.accent});

  @override
  Widget build(BuildContext context) {
    final name = member.userName ?? 'Unknown';
    final phone = member.userNumber ?? '';
    final roleLabel = member.role?.name ?? member.role?.toString() ?? '';
    final jobTitle = member.employeeRole?.name;
    final active = member.isActive != false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: accent.withValues(alpha: 0.12),
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: TextStyle(color: accent, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(
                  [
                    if (member.userId != null) member.userId!,
                    if (phone.isNotEmpty) phone,
                    if (jobTitle != null && jobTitle.isNotEmpty) jobTitle,
                  ].join(' · '),
                  style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  roleLabel,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: accent),
                ),
              ),
              if (!active)
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text('Inactive', style: TextStyle(fontSize: 10, color: Color(0xFFBA1A1A))),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyCard({required this.icon, required this.title, required this.subtitle});

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
