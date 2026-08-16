import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../theme/app_theme.dart';
import '../providers/accounts_providers.dart';

const _roles = <(String, String)>[
  ('ADMIN', 'Admins'),
  ('SELLER', 'Sellers'),
  ('EMPLOYEE', 'Employees'),
];

class AccountsRoleChips extends ConsumerWidget {
  const AccountsRoleChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(accountsRoleFilterProvider);

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Row(
        children: [
          for (final role in _roles)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(role.$2),
                selected: selected == role.$1,
                onSelected: (_) =>
                    ref.read(accountsRoleFilterProvider.notifier).state = role.$1,
                selectedColor: const Color(0xFFE8F5E9),
                labelStyle: TextStyle(
                  color: selected == role.$1
                      ? AppTheme.primary
                      : const Color(0xFF586377),
                  fontWeight:
                      selected == role.$1 ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 13,
                ),
                side: BorderSide(
                  color: selected == role.$1
                      ? AppTheme.primary
                      : const Color(0xFFECEEF0),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
