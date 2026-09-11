import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../theme/app_theme.dart';
import '../providers/admin_sales_history_provider.dart';

const _modes = <(String?, String, bool)>[
  (null, 'All pay', false),
  ('CASH', 'Cash', false),
  ('ONLINE', 'Online', false),
  ('CREDIT', 'Credit', false),
  ('CREDIT', 'Due', true),
];

class AdminSalesPaymentFilter extends ConsumerWidget {
  const AdminSalesPaymentFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminSalesHistoryProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final (value, label, unpaid) in _modes)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(label),
                selected: state.paymentMode == value && state.unpaid == unpaid,
                onSelected: (_) => ref
                    .read(adminSalesHistoryProvider.notifier)
                    .setPaymentMode(value, unpaid: unpaid),
                selectedColor: AppTheme.primary,
                backgroundColor: const Color(0xFFF1F5F9),
                showCheckmark: false,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelStyle: TextStyle(
                  color: state.paymentMode == value && state.unpaid == unpaid
                      ? Colors.white
                      : const Color(0xFF475569),
                  fontWeight: state.paymentMode == value && state.unpaid == unpaid
                      ? FontWeight.bold
                      : FontWeight.w500,
                  fontSize: 13,
                ),
                side: BorderSide(
                  color: state.paymentMode == value && state.unpaid == unpaid
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
