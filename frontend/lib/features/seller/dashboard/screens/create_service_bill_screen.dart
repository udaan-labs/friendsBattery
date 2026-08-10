import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../sales/providers/seller_sales_provider.dart';

/// Default charges (UI prefill only; backend accepts any positive amount).
const _defaultAmounts = <String, num>{
  'BATTERY_CHECK_2W': 30,
  'BATTERY_CHECK_4W': 70,
  'BATTERY_CHARGING': 0,
  'JUMPSTART': 0,
  'INVERTER_SERVICE': 1000,
};

const _serviceLabels = <String, String>{
  'BATTERY_CHECK_2W': 'Battery check (2W)',
  'BATTERY_CHECK_4W': 'Battery check (4W)',
  'BATTERY_CHARGING': 'Battery charging',
  'JUMPSTART': 'Jumpstart',
  'INVERTER_SERVICE': 'Inverter service',
};

class CreateServiceBillScreen extends ConsumerStatefulWidget {
  const CreateServiceBillScreen({super.key});

  @override
  ConsumerState<CreateServiceBillScreen> createState() =>
      _CreateServiceBillScreenState();
}

class _CreateServiceBillScreenState
    extends ConsumerState<CreateServiceBillScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _customerMobileController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _amountController = TextEditingController(text: '30');
  final _placeController = TextEditingController();

  String _serviceType = 'BATTERY_CHECK_2W';
  bool _isSubmitting = false;

  bool get _needsPlace => _serviceType == 'JUMPSTART';

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerMobileController.dispose();
    _vehicleNumberController.dispose();
    _amountController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  void _onServiceTypeChanged(String? type) {
    if (type == null) return;
    setState(() {
      _serviceType = type;
      final def = _defaultAmounts[type];
      if (def != null && def > 0) {
        _amountController.text = def.toStringAsFixed(0);
      } else if (def == 0) {
        _amountController.clear();
      }
    });
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;
    final amount = num.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      context.showErrorSnackBar('Enter a valid amount');
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await ref.read(sellerSalesRepositoryProvider).createServiceBill(
            serviceType: _serviceType,
            amount: amount,
            customerName: _customerNameController.text.trim(),
            customerNumber: _customerMobileController.text.trim(),
            vehicleNumber: _vehicleNumberController.text.trim().isEmpty
                ? null
                : _vehicleNumberController.text.trim(),
            place: _needsPlace ? _placeController.text.trim() : null,
          );
      if (!mounted) return;
      context.showSuccessSnackBar('Service bill created');
      context.pop();
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
      appBar: AppBar(title: const Text('Service bill')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              DropdownButtonFormField<String>(
                key: ValueKey(_serviceType),
                initialValue: _serviceType,
                decoration: const InputDecoration(labelText: 'Service type'),
                items: _serviceLabels.entries
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                      ),
                    )
                    .toList(),
                onChanged: _onServiceTypeChanged,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Amount (₹)',
                  hintText: 'Charge amount',
                ),
                validator: (v) {
                  final n = num.tryParse(v?.trim() ?? '');
                  if (n == null || n <= 0) return 'Amount required';
                  return null;
                },
              ),
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
                controller: _vehicleNumberController,
                decoration: const InputDecoration(
                  labelText: 'Vehicle number (optional)',
                ),
              ),
              if (_needsPlace) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _placeController,
                  decoration: const InputDecoration(
                    labelText: 'Place / site',
                    hintText: 'Where jumpstart is done',
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Place required' : null,
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
                    : const Text('Create service bill'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
