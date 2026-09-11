import 'package:flutter/material.dart';
import '../../../../theme/app_theme.dart';

class BillPaymentModePicker extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final Widget? creditExtra;
  /// When false, CREDIT tile is hidden (service/rent have no pay-later API).
  final bool allowCredit;

  const BillPaymentModePicker({
    super.key,
    required this.value,
    required this.onChanged,
    this.creditExtra,
    this.allowCredit = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _tile(value: 'CASH', label: 'Cash', icon: Icons.payments_outlined),
            const SizedBox(width: 8),
            _tile(value: 'ONLINE', label: 'Online', icon: Icons.smartphone_outlined),
            if (allowCredit) ...[
              const SizedBox(width: 8),
              _tile(value: 'CREDIT', label: 'Credit', icon: Icons.schedule_outlined),
            ],
          ],
        ),
        if (allowCredit && value == 'CREDIT') ...[
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Customer pays later. Enter any amount paid now.',
              style: TextStyle(fontSize: 12, color: Color(0xFFC2410C)),
            ),
          ),
          if (creditExtra != null) creditExtra!,
        ],
      ],
    );
  }

  Widget _tile({required String value, required String label, required IconData icon}) {
    final selected = this.value == value;
    final credit = value == 'CREDIT' && selected;
    final bg = credit
        ? const Color(0xFFFFF7ED)
        : selected
            ? AppTheme.primary
            : const Color(0xFFF8FAFC);
    final fg = credit
        ? const Color(0xFFC2410C)
        : selected
            ? Colors.white
            : const Color(0xFF475569);
    return Expanded(
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => onChanged(value),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: credit
                    ? const Color(0xFFC2410C)
                    : selected
                        ? AppTheme.primary
                        : const Color(0xFFE2E8F0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: fg),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
