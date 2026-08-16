import 'package:flutter/material.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../theme/app_theme.dart';
import '../../../shared/staff/widgets/confirm_mark_active.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({
    super.key,
    required this.user,
    required this.onSetActive,
  });

  final AccountUser user;
  final Future<void> Function(bool isActive) onSetActive;

  @override
  Widget build(BuildContext context) {
    final active = user.isActive != false;
    final location = user.location?.name;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECEEF0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.userName ?? '—',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF191C1E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${user.userId ?? ''}${location == null || location.isEmpty ? '' : ' · $location'}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: active,
            activeThumbColor: AppTheme.primary,
            onChanged: (next) async {
              final ok = await confirmMarkActive(
                context,
                name: user.userName ?? user.userId ?? 'this account',
                currentlyActive: active,
              );
              if (ok) await onSetActive(next);
            },
          ),
        ],
      ),
    );
  }
}
