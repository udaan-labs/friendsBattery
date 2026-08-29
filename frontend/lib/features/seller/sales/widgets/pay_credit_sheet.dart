import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../theme/app_theme.dart';

/// Collect remaining credit. Returns amount, or null if cancelled.
Future<double?> showPayCreditSheet(
  BuildContext context, {
  required double amountDue,
}) {
  return showModalBottomSheet<double>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) => _PayCreditSheet(amountDue: amountDue),
  );
}

class _PayCreditSheet extends StatefulWidget {
  final double amountDue;
  const _PayCreditSheet({required this.amountDue});

  @override
  State<_PayCreditSheet> createState() => _PayCreditSheetState();
}

class _PayCreditSheetState extends State<_PayCreditSheet> {
  late final TextEditingController _amount;

  @override
  void initState() {
    super.initState();
    _amount = TextEditingController(text: widget.amountDue.toStringAsFixed(2));
  }

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  void _submit() {
    final n = double.tryParse(_amount.text.trim());
    if (n == null || n <= 0) return;
    if (n > widget.amountDue + 0.001) return;
    Navigator.pop(context, n);
  }

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 16 + pad),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Collect payment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(
            'Due ₹${widget.amountDue.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 13, color: Color(0xFFC2410C)),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amount,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: FilledButton(
              onPressed: _submit,
              style: FilledButton.styleFrom(backgroundColor: AppTheme.primary),
              child: const Text('Record payment'),
            ),
          ),
        ],
      ),
    );
  }
}
