import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../theme/app_theme.dart';
import '../providers/admin_sales_history_provider.dart';

const _types = <(String?, String)>[
  (null, 'All types'),
  ('NORMAL', 'Normal'),
  ('SCRAP', 'Scrap'),
  ('MECHANIC', 'Mechanic'),
  ('SERVICE', 'Service'),
  ('RENT', 'Rent'),
];

class AdminSalesTypeFilter extends ConsumerWidget {
  const AdminSalesTypeFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(adminSalesHistoryProvider).saleType;

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final (value, label) in _types)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(label),
                  selected: selected == value,
                  onSelected: (_) => ref
                      .read(adminSalesHistoryProvider.notifier)
                      .setSaleType(value),
                  selectedColor: AppTheme.primary,
                  backgroundColor: const Color(0xFFF1F5F9),
                  showCheckmark: false,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelStyle: TextStyle(
                    color: selected == value ? Colors.white : const Color(0xFF475569),
                    fontWeight:
                        selected == value ? FontWeight.bold : FontWeight.w500,
                    fontSize: 13,
                  ),
                  side: BorderSide(
                    color: selected == value
                        ? AppTheme.primary
                        : const Color(0xFFE2E8F0),
                  ),
                ),
              ),
          ],
        ),
    );
  }
}
