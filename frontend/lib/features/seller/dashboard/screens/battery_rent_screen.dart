import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/state/data_sync.dart';
import '../../../../shared/widgets/scanner_screen.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../sales/providers/seller_sales_provider.dart';

/// Rent out with deposit, or return (fee from deposit → refund).
class BatteryRentScreen extends ConsumerStatefulWidget {
  const BatteryRentScreen({super.key});

  @override
  ConsumerState<BatteryRentScreen> createState() => _BatteryRentScreenState();
}

class _BatteryRentScreenState extends ConsumerState<BatteryRentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _serialController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerMobileController = TextEditingController();
  final _depositController = TextEditingController(text: '1000');
  final _feeController = TextEditingController(text: '100');

  /// out | return
  String _mode = 'out';
  bool _isSubmitting = false;

  @override
  void dispose() {
    _serialController.dispose();
    _customerNameController.dispose();
    _customerMobileController.dispose();
    _depositController.dispose();
    _feeController.dispose();
    super.dispose();
  }

  Future<void> _scan() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const ScannerScreen()),
    );
    if (result != null && result.isNotEmpty) {
      _serialController.text = result;
    }
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    try {
      final repo = ref.read(sellerSalesRepositoryProvider);
      if (_mode == 'out') {
        final deposit = num.parse(_depositController.text.trim());
        final r = await repo.createRent(
          serialNumber: _serialController.text.trim(),
          customerName: _customerNameController.text.trim(),
          customerNumber: _customerMobileController.text.trim(),
          deposit: deposit,
        );
        if (!mounted) return;
        DataSync.afterSaleMutation(ref);
        context.showSuccessSnackBar(
          'Rented out · deposit ₹${r.deposit ?? deposit}',
        );
        context.pop();
      } else {
        final fee = num.parse(_feeController.text.trim());
        final r = await repo.returnRent(
          serialNumber: _serialController.text.trim(),
          rentFee: fee,
        );
        if (!mounted) return;
        DataSync.afterSaleMutation(ref);
        context.showSuccessSnackBar(
          'Returned · fee ₹${r.rentFee ?? fee} · refund ₹${r.refundAmount ?? 0}',
        );
        context.pop();
      }
    } catch (e) {
      // DioExceptions handled by ApiInterceptor (same as CreateBillScreen)
      if (mounted && e is! DioException) {
        context.showErrorSnackBar(e.toString());
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Battery rent')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'out', label: Text('Rent out')),
                  ButtonSegment(value: 'return', label: Text('Return')),
                ],
                selected: {_mode},
                onSelectionChanged: (s) => setState(() => _mode = s.first),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _serialController,
                decoration: InputDecoration(
                  labelText: 'Serial number',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.qr_code_scanner),
                    onPressed: _scan,
                  ),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              if (_mode == 'out') ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _customerNameController,
                  decoration: const InputDecoration(labelText: 'Customer name'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _customerMobileController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration:
                      const InputDecoration(labelText: 'Mobile (10 digits)'),
                  validator: (v) {
                    if (v == null || v.trim().length != 10) {
                      return '10 digit mobile required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _depositController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Deposit (₹)',
                    hintText: 'e.g. 1000',
                  ),
                  validator: (v) {
                    final n = num.tryParse(v?.trim() ?? '');
                    if (n == null || n <= 0) return 'Deposit required';
                    return null;
                  },
                ),
              ] else ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _feeController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Rent fee from deposit (₹)',
                    hintText: 'e.g. 100 — rest refunded',
                  ),
                  validator: (v) {
                    final n = num.tryParse(v?.trim() ?? '');
                    if (n == null || n < 0) return 'Fee required';
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(_mode == 'out' ? 'Rent out' : 'Return battery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
