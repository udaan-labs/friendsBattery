import 'package:flutter/material.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'confirm_mark_active.dart';

/// Shared employees/sellers list card used by admin shop team + seller My Team.
class StaffMemberGroup extends StatelessWidget {
  const StaffMemberGroup({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.members,
    required this.emptyLabel,
    this.showRoleChip = false,
    this.onAdd,
    this.addLabel,
    this.onToggleActive,
  });

  final String title;
  final IconData icon;
  final Color color;
  final List<ShopStaffMember> members;
  final String emptyLabel;
  final bool showRoleChip;
  final VoidCallback? onAdd;
  final String? addLabel;
  final Future<void> Function(ShopStaffMember member, bool isActive)? onToggleActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$title (${members.length})',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: color,
                  ),
                ),
              ),
              if (onAdd != null)
                TextButton.icon(
                  onPressed: onAdd,
                  icon: const Icon(Icons.person_add_alt_1, size: 18),
                  label: Text(addLabel!),
                  style: TextButton.styleFrom(
                    foregroundColor: color,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          if (members.isEmpty)
            Text(
              emptyLabel,
              style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
            )
          else
            ...members.map(
              (m) => _Tile(
                member: m,
                accent: color,
                showRoleChip: showRoleChip,
                onToggleActive: onToggleActive,
              ),
            ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.member,
    required this.accent,
    required this.showRoleChip,
    this.onToggleActive,
  });

  final ShopStaffMember member;
  final Color accent;
  final bool showRoleChip;
  final Future<void> Function(ShopStaffMember member, bool isActive)?
      onToggleActive;

  Future<void> _onTap(BuildContext context) async {
    final cb = onToggleActive;
    if (cb == null) return;
    final active = member.isActive != false;
    final ok = await confirmMarkActive(
      context,
      name: member.userName ?? member.userId ?? 'this account',
      currentlyActive: active,
    );
    if (ok) await cb(member, !active);
  }

  @override
  Widget build(BuildContext context) {
    final name = member.userName ?? 'Unknown';
    final phone = member.userNumber ?? '';
    final jobTitle = member.employeeRole?.name;
    final roleLabel = member.role?.name ?? member.role?.toString() ?? '';
    final active = member.isActive != false;
    final canToggle = onToggleActive != null && member.id != null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: canToggle ? () => _onTap(context) : null,
        borderRadius: BorderRadius.circular(8),
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
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
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
          if (showRoleChip)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    roleLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: accent,
                    ),
                  ),
                ),
                if (!active)
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'Inactive',
                      style: TextStyle(fontSize: 10, color: Color(0xFFBA1A1A)),
                    ),
                  ),
              ],
            ),
        ],
        ),
      ),
    );
  }
}
