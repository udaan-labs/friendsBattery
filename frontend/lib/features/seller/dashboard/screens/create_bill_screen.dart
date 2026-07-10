import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import '../../../../theme/app_theme.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../core/network/api_client.dart';
import '../providers/seller_dashboard_controller.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../../shared/widgets/scanner_screen.dart';
import 'seller_shell_screen.dart';

class CreateBillScreen extends ConsumerStatefulWidget {
  const CreateBillScreen({super.key});

  @override
  ConsumerState<CreateBillScreen> createState() => _CreateBillScreenState();
}

class _CreateBillScreenState extends ConsumerState<CreateBillScreen> {
  final _formKey = GlobalKey<FormState>();
  final _serialNumberController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerMobileController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _sellPriceController = TextEditingController();

  bool _isFetchingDetails = false;
  bool _isSubmitting = false;

  String? _selectedProductNameId;
  String? _selectedProductModelId;
  String? _selectedProductName;
  String? _selectedProductModel;
  String? _fetchedSerialNumber;

  int? _productId;
  num? _minPrice;
  num? _userSellPrice;

  @override
  void initState() {
    super.initState();
    _sellPriceController.addListener(() {
      final val = num.tryParse(_sellPriceController.text);
      setState(() {
        _userSellPrice = val;
      });
    });
  }

  @override
  void dispose() {
    _serialNumberController.dispose();
    _customerNameController.dispose();
    _customerMobileController.dispose();
    _vehicleNumberController.dispose();
    _sellPriceController.dispose();
    super.dispose();
  }

  Future<void> _scanSerialNumber() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const ScannerScreen()),
    );
    
    if (result != null && result.isNotEmpty) {
      _serialNumberController.text = result;
      _fetchProductDetails(result);
    }
  }

  Future<void> _fetchProductDetails(String serial) async {
    if (serial.trim().isEmpty) return;

    setState(() {
      _isFetchingDetails = true;
      _productId = null;
      _selectedProductNameId = null;
      _selectedProductModelId = null;
      _selectedProductName = null;
      _selectedProductModel = null;
      _fetchedSerialNumber = null;
      _minPrice = null;
    });

    try {
      final dio = ApiClient().dio;
      final response = await dio.get(
        '/api/inventory/scan-for-sale',
        queryParameters: {'serial_number': serial.trim()},
      );

      final body = response.data;
      if (body is Map<String, dynamic> && body['success'] == true) {
        final data = body['data'] as Map<String, dynamic>;
        setState(() {
          _productId = data['productId'] as int?;
          _selectedProductNameId = data['productNameId']?.toString();
          _selectedProductModelId = data['productModelId']?.toString();
          _selectedProductName = data['productName'] as String?;
          _selectedProductModel = data['productModel'] as String?;
          _fetchedSerialNumber = serial.trim();
          _minPrice = data['minSellPrice'] as num?;
        });
        if (mounted) {
          context.showSuccessSnackBar('Product details fetched successfully!');
        }
      } else {
        if (mounted) {
          context.showErrorSnackBar(body['message'] ?? 'Failed to fetch details');
        }
      }
    } catch (e) {
      if (mounted) {
        if (e is DioException && e.response != null) {
          final errorData = e.response!.data;
          context.showErrorSnackBar(errorData['message'] ?? 'Product not found in your available inventory');
        } else {
          context.showErrorSnackBar('Error: $e');
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isFetchingDetails = false;
        });
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_productId == null || _selectedProductNameId == null || _selectedProductModelId == null) {
      context.showErrorSnackBar('Please scan a valid serial number and fetch product details');
      return;
    }

    final serialValue = _serialNumberController.text.trim();
    if (_fetchedSerialNumber == null || _fetchedSerialNumber != serialValue) {
      context.showErrorSnackBar('Serial number changed. Please fetch product details again.');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final dio = ApiClient().dio;
      final sellPrice = double.parse(_sellPriceController.text);
      final serialValue = _serialNumberController.text.trim();

      await dio.post('/api/sales', data: {
        'product_name_id': int.parse(_selectedProductNameId!),
        'product_model_id': int.parse(_selectedProductModelId!),
        'serial_number': serialValue,
        'customer_name': _customerNameController.text,
        'customer_number': _customerMobileController.text,
        if (_vehicleNumberController.text.isNotEmpty) 'vehicle_number': _vehicleNumberController.text,
        'sell_price': sellPrice,
      });

      if (mounted) {
        context.showSuccessSnackBar('Sale recorded successfully');
        // Refresh dashboard statistics, recent inventories & current stock
        await ref.read(sellerDashboardControllerProvider).refreshAllData();
        if (mounted) {
          final saleData = {
            'customer_name': _customerNameController.text,
            'customer_number': _customerMobileController.text,
            'product_name': '$_selectedProductName $_selectedProductModel',
            'serial_number': serialValue,
            'sell_price': sellPrice,
            'invoice_number': 'INV-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
            'sale_date': DateTime.now(),
            'seller_name': 'Friends Battery Seller',
          };
          
          context.go('/seller/sale-success', extra: saleData);
        }
      }
    } catch (e) {
      if (mounted && e is! DioException) {
        context.showErrorSnackBar('Error: $e');
      }
      // DioExceptions are handled automatically by ApiInterceptor
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  bool _hasUnsavedChanges() {
    return _serialNumberController.text.isNotEmpty ||
        _customerNameController.text.isNotEmpty ||
        _customerMobileController.text.isNotEmpty ||
        _vehicleNumberController.text.isNotEmpty ||
        _sellPriceController.text.isNotEmpty;
  }

  Future<void> _onBackPressed() async {
    if (!_hasUnsavedChanges()) {
      if (context.canPop()) {
        context.pop();
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
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/seller/dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasUnsavedChanges(),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onBackPressed();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FB),
        appBar: AppBar(
          title: const Text('Create Bill'),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.background,
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Serial Number First
                            const Text(
                              'Serial Number',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.qr_code_scanner),
                              label: const Text('Scan Serial Number'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                backgroundColor: const Color(0xFF006B2C),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: _scanSerialNumber,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _serialNumberController,
                                    decoration: InputDecoration(
                                      hintText: 'Manual Add (Fallback)',
                                      isDense: true,
                                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'Serial Number is required';
                                      }
                                      return null;
                                    },
                                    onFieldSubmitted: (val) {
                                      _fetchProductDetails(val);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: _isFetchingDetails
                                      ? null
                                      : () => _fetchProductDetails(_serialNumberController.text),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(0, 48), // override infinite width from theme
                                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                    backgroundColor: const Color(0xFF191C1E),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: _isFetchingDetails
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                        )
                                      : const Text('Fetch Details'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Product Information Card
                            if (_productId != null) ...[
                              Container(
                                padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F5E9),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFF006B2C)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(Icons.check_circle, color: Color(0xFF006B2C), size: 16),
                                        SizedBox(width: 6),
                                        Text(
                                          'Product Verified',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF006B2C)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Brand: $_selectedProductName',
                                      style: const TextStyle(fontSize: 13, color: Color(0xFF191C1E), fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Model: $_selectedProductModel',
                                      style: const TextStyle(fontSize: 13, color: Color(0xFF191C1E), fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Min Sell Price: ₹${_minPrice ?? 0}',
                                      style: const TextStyle(fontSize: 13, color: Color(0xFF3E4A3D)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],

                            // Customer Name
                            const Text(
                              'Customer Name',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _customerNameController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Customer Name',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Customer Name is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Customer Mobile Number
                            const Text(
                              'Customer Mobile Number',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _customerMobileController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: 'Enter Mobile Number',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Mobile number is required';
                                }
                                if (value.trim().length != 10) {
                                  return 'Mobile number must be exactly 10 digits';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Vehicle Number
                            const Text(
                              'Vehicle Number',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _vehicleNumberController,
                              textCapitalization: TextCapitalization.characters,
                              decoration: const InputDecoration(
                                hintText: 'e.g. MH12AB1234 (optional)',
                              ),
                              validator: (value) {
                                if (value != null && value.trim().isNotEmpty) {
                                  final vehicleRegex = RegExp(r'^[A-Z]{2}[0-9]{1,2}[A-Z]{1,2}[0-9]{4}$');
                                  if (!vehicleRegex.hasMatch(value.trim().replaceAll(' ', '').toUpperCase())) {
                                    return 'Enter a valid Vehicle Number (e.g. MH12AB1234)';
                                  }
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Sell Price
                            const Text(
                              'Selling Price',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _sellPriceController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Enter Final Sale Price',
                                prefixText: '₹ ',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Sell price is required';
                                }
                                final parsed = double.tryParse(value);
                                if (parsed == null || parsed <= 0) {
                                  return 'Sell price must be greater than 0';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // Selling below recommended warning
                            if (_minPrice != null && _userSellPrice != null && _userSellPrice! < _minPrice!) ...[
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFEBEE),
                                  border: Border.all(color: const Color(0xFFDC2626)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.warning_amber_rounded, color: Color(0xFFDC2626)),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Warning: Selling below minimum recommended price.',
                                        style: TextStyle(color: Color(0xFFDC2626), fontSize: 13, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],

                            // Summary Card
                            if (_productId != null && _customerNameController.text.isNotEmpty && _userSellPrice != null) ...[
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD5E0F8).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFFD5E0F8)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _selectedProductModel ?? 'Product',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Customer: ${_customerNameController.text}',
                                      style: const TextStyle(fontSize: 13, color: Color(0xFF191C1E)),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Price:', style: TextStyle(fontSize: 13, color: Color(0xFF545F73))),
                                        Text(
                                          '₹${_userSellPrice!.toStringAsFixed(0)}',
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF006B2C)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],

                            // Generate Bill Button
                            ElevatedButton(
                              onPressed: _isSubmitting ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(56),
                                backgroundColor: const Color(0xFF006B2C),
                                foregroundColor: Colors.white,
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
                                      'Generate Bill',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
