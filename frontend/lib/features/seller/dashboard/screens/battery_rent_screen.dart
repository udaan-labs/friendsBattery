import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/state/data_sync.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/widgets/scanner_screen.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../sales/providers/seller_sales_provider.dart';
import '../models/sale_success_data.dart';
import '../widgets/bill_payment_mode_picker.dart';

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
  String _paymentMode = 'CASH';
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
        final customerName = _customerNameController.text.trim();
        final customerNumber = _customerMobileController.text.trim();
        final serial = _serialController.text.trim();
        final r = await repo.createRent(
          serialNumber: serial,
          customerName: customerName,
          customerNumber: customerNumber,
          deposit: deposit,
          paymentMode: _paymentMode,
        );
        if (!mounted) return;
        DataSync.afterSaleMutation(ref);
        context.showSuccessSnackBar(
          'Rented out · deposit ₹${r.deposit ?? deposit}',
        );
        _goShare(
          customerName: customerName,
          customerNumber: customerNumber,
          productName: 'Battery Rent',
          serialNumber: r.serialNumber ?? serial,
          amount: (r.deposit ?? deposit).toDouble(),
          invoiceNumber: 'RENT-${r.rentId}',
          paymentMode: _paymentMode,
        );
      } else {
        final fee = num.parse(_feeController.text.trim());
        final serial = _serialController.text.trim();
        final r = await repo.returnRent(
          serialNumber: serial,
          rentFee: fee,
        );
        if (!mounted) return;
        DataSync.afterSaleMutation(ref);
        final refund = r.refundAmount ?? 0;
        context.showSuccessSnackBar(
          'Returned · fee ₹${r.rentFee ?? fee} · refund ₹$refund',
        );
        _goShare(
          customerName: r.customerName ?? '',
          customerNumber: r.customerNumber ?? '',
          productName: 'Battery Rent Return · refund ₹$refund',
          serialNumber: r.serialNumber ?? serial,
          amount: (r.rentFee ?? fee).toDouble(),
          invoiceNumber: 'RET-${r.rentId}',
        );
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

  void _goShare({
    required String customerName,
    required String customerNumber,
    required String productName,
    required String serialNumber,
    required double amount,
    required String invoiceNumber,
    String paymentMode = 'CASH',
  }) {
    final role = ref.read(authProvider).role;
    final successPath = switch (role) {
      UserRole.admin || UserRole.superAdmin => '/admin/sale-success',
      UserRole.employee => '/employee/sale-success',
      _ => '/seller/sale-success',
    };
    final sellerLabel = switch (role) {
      UserRole.admin || UserRole.superAdmin => 'Friends Battery Admin',
      UserRole.employee => 'Friends Battery Employee',
      _ => 'Friends Battery Seller',
    };
    context.go(
      successPath,
      extra: SaleSuccessData(
        customerName: customerName,
        customerNumber: customerNumber,
        productName: productName,
        serialNumber: serialNumber,
        sellPrice: amount,
        invoiceNumber: invoiceNumber,
        saleDate: DateTime.now(),
        sellerName: sellerLabel,
        paymentMode: paymentMode,
      ),
    );
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
                const SizedBox(height: 16),
                BillPaymentModePicker(
                  value: _paymentMode,
                  onChanged: (v) => setState(() => _paymentMode = v),
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
