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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primary,
              onPrimary: Colors.white,
              onSurface: Color(0xFF0F172A),
            ),
          ),
          child: child!,
        );
      },
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
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
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
                  selectedColor: AppTheme.primary,
                  backgroundColor: const Color(0xFFF1F5F9),
                  showCheckmark: false,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelStyle: TextStyle(
                    color: state.period == p ? Colors.white : const Color(0xFF475569),
                    fontWeight: state.period == p ? FontWeight.bold : FontWeight.w500,
                    fontSize: 13,
                  ),
                  side: BorderSide(
                    color: state.period == p ? AppTheme.primary : const Color(0xFFE2E8F0),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

