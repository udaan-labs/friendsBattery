import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../core/network/api_client.dart';
import '../providers/seller_dashboard_controller.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import 'seller_shell_screen.dart';

class SellerReturnProductScreen extends ConsumerStatefulWidget {
  const SellerReturnProductScreen({super.key});

  @override
  ConsumerState<SellerReturnProductScreen> createState() => _SellerReturnProductScreenState();
}

class _SellerReturnProductScreenState extends ConsumerState<SellerReturnProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _customerMobileController = TextEditingController();
  final _serialController = TextEditingController();

  bool _isVerifying = false;
  bool _isSubmitting = false;

  String? _verifiedProductName;
  String? _verifiedProductModel;
  String? _verifiedStatus;
  bool _isVerifiedValid = false;

  @override
  void dispose() {
    _reasonController.dispose();
    _customerMobileController.dispose();
    _serialController.dispose();
    super.dispose();
  }

  Future<void> _verifySerialNumber() async {
    final serial = _serialController.text.trim();
    if (serial.isEmpty) {
      context.showErrorSnackBar('Please enter a serial number');
      return;
    }

    setState(() {
      _isVerifying = true;
      _isVerifiedValid = false;
      _verifiedProductName = null;
      _verifiedProductModel = null;
      _verifiedStatus = null;
    });

    try {
      final dio = ApiClient().dio;
      final response = await dio.post('/api/product-units/verify', data: {
        'identifier': serial,
      });

      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] != null) {
        final productUnit = data['data']['productUnit'];
        final product = data['data']['product'];
        
        final status = productUnit['status'];

        setState(() {
          _verifiedProductName = product['name'];
          _verifiedProductModel = product['model'];
          _verifiedStatus = status;

          if (status == 'SOLD') {
            _isVerifiedValid = true;
            context.showSuccessSnackBar('Product verified successfully.');
          } else {
            context.showErrorSnackBar('Product is not in SOLD status (Current: $status)');
          }
        });
      }
    } catch (e) {
      if (mounted) {
        String errorMsg = 'Failed to verify product.';
        if (e is DioException && e.response?.data != null) {
          errorMsg = e.response?.data['message'] ?? errorMsg;
        }
        context.showErrorSnackBar(errorMsg);
      }
    } finally {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_isVerifiedValid) {
      context.showErrorSnackBar('Please verify a valid sold product first.');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final dio = ApiClient().dio;
      await dio.post('/api/returns', data: {
        'serial_number': _serialController.text.trim(),
        'reason': _reasonController.text.trim(),
      });

      if (mounted) {
        context.showSuccessSnackBar('Return request submitted successfully');
        await ref.read(sellerDashboardControllerProvider).refreshAllData();
        if (mounted) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            context.go('/seller/dashboard');
          }
        }
      }
    } catch (e) {
      if (mounted) {
        String errorMsg = 'Failed to submit return. Please try again.';
        if (e is DioException && e.response?.data != null) {
          errorMsg = e.response?.data['message'] ?? errorMsg;
        }
        context.showErrorSnackBar(errorMsg);
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  bool _hasUnsavedChanges() {
    return _serialController.text.isNotEmpty ||
        _customerMobileController.text.isNotEmpty ||
        _reasonController.text.isNotEmpty;
  }

  Future<void> _onBackPressed() async {
    if (!_hasUnsavedChanges()) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        context.go('/seller/dashboard');
      }
      return;
    }

    final shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discard Changes?'),
        content: const Text('You have unsaved changes. Are you sure you want to discard them and leave?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Discard'),
          ),
        ],
      ),
    );

    if (shouldDiscard == true && mounted) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        context.go('/seller/dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Navigator.of(context).canPop() && !_hasUnsavedChanges(),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onBackPressed();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text(
          'Return Product',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E4A3D)),
          onPressed: _onBackPressed,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info banner
              Container(
                padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                decoration: BoxDecoration(
                  color: const Color(0xFFD5E0F8).withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD5E0F8)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.qr_code_scanner, color: Color(0xFF16A34A), size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Scan or enter the battery serial number to verify the product before returning.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF3E4A3D)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Verify Product',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF191C1E),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Battery Serial Number',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _serialController,
                            decoration: InputDecoration(
                              hintText: 'Enter serial number',
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Serial number is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: _isVerifying ? null : _verifySerialNumber,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A73E8),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: _isVerifying
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Verify', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),

                    if (_verifiedProductName != null) ...[
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isVerifiedValid ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _isVerifiedValid ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product: $_verifiedProductName',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Model: $_verifiedProductModel',
                              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Text('Status: ', style: TextStyle(fontSize: 14)),
                                Text(
                                  '$_verifiedStatus',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _isVerifiedValid ? Colors.green.shade700 : Colors.red.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),

              if (_isVerifiedValid) ...[
                // Return Reason
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Return Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF191C1E),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Customer Mobile (optional)',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _customerMobileController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Enter customer mobile for lookup',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Reason for Return',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _reasonController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Describe the reason for returning this product...',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Please provide a reason for the return';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16A34A),
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Submit Return Request',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
            ),
          ),
        ),
      ),
    ),
  ),
);
}
}
