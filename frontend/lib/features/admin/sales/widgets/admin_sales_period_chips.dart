import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../theme/app_theme.dart';
import '../providers/admin_sales_history_provider.dart';

class AdminSalesPeriodChips extends ConsumerWidget {
  const AdminSalesPeriodChips({super.key});

  Future<void> _pickDate(BuildContext context, WidgetRef ref) async {
    final state = ref.read(adminSalesHistoryProvider);
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: state.customDate ?? now,
      firstDate: DateTime(2020),
      lastDate: now,
    );
    if (picked != null) {
      ref.read(adminSalesHistoryProvider.notifier).setCustomDate(picked);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminSalesHistoryProvider);

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final p in AdminSalesPeriod.values)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(p.label(state.customDate)),
                  selected: state.period == p,
                  onSelected: (_) => p == AdminSalesPeriod.custom
                      ? _pickDate(context, ref)
                      : ref.read(adminSalesHistoryProvider.notifier).setPeriod(p),
                  selectedColor: const Color(0xFFE8F5E9),
                  labelStyle: TextStyle(
                    color: state.period == p
                        ? AppTheme.primary
                        : const Color(0xFF586377),
                    fontWeight: state.period == p
                        ? FontWeight.w600
                        : FontWeight.normal,
                    fontSize: 13,
                  ),
                  side: BorderSide(
                    color: state.period == p
                        ? AppTheme.primary
                        : const Color(0xFFECEEF0),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
