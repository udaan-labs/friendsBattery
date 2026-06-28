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

  bool _isLoadingNames = false;
  bool _isLoadingModels = false;
  bool _isSubmitting = false;

  List<Map<String, String>> _productNames = [];
  List<Map<String, String>> _productModels = [];

  String? _selectedProductNameId;
  String? _selectedProductModelId;

  int? _productId;
  num? _minPrice;
  num? _userSellPrice;

  @override
  void initState() {
    super.initState();
    _loadProductNames();
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
      setState(() {
        _serialNumberController.text = result;
      });
    }
  }

  Future<void> _loadProductNames() async {
    setState(() {
      _isLoadingNames = true;
    });

    try {
      final dio = ApiClient().dio;
      final response = await dio.get('/api/products/product-names');
      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        final list = data['data'] as List;
        setState(() {
          _productNames = list.map((item) {
            return {
              'id': item['id'].toString(),
              'name': item['name'].toString(),
            };
          }).toList();
        });
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      setState(() {
        _isLoadingNames = false;
      });
    }
  }

  Future<void> _loadProductModels(String productNameId) async {
    setState(() {
      _isLoadingModels = true;
      _productModels = [];
      _selectedProductModelId = null;
      _serialNumberController.clear();
      _productId = null;
      _minPrice = null;
    });

    try {
      final dio = ApiClient().dio;
      final response = await dio.post('/api/products/product-models/list', data: {
        'product_name_id': int.parse(productNameId),
      });
      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        final list = data['data'] as List;
        setState(() {
          _productModels = list.map((item) {
            return {
              'id': item['id'].toString(),
              'name': item['name'].toString(),
            };
          }).toList();
        });
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      setState(() {
        _isLoadingModels = false;
      });
    }
  }

  Future<void> _loadProductDetails(String productModelId) async {
    setState(() {
      _serialNumberController.clear();
      _productId = null;
      _minPrice = null;
    });

    try {
      final dio = ApiClient().dio;
      
      // Load stock details & min price
      final response = await dio.get('/api/inventory/product-details', queryParameters: {
        'product_name_id': _selectedProductNameId!,
        'product_model_id': productModelId,
      });

      final details = response.data['data'];
      if (details != null) {
        setState(() {
          _productId = details['productId'];
          _minPrice = details['minSellPrice'] ?? 0;
        });
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedProductNameId == null || _selectedProductModelId == null) {
      context.showErrorSnackBar('Please select all product fields');
      return;
    }
    if (_productId == null) {
      context.showErrorSnackBar('Product ID could not be resolved');
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
        'product_id': _productId!,
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
          context.pop();
        }
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  bool _hasUnsavedChanges() {
    return _selectedProductNameId != null ||
        _serialNumberController.text.isNotEmpty ||
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
    final selectedModelName = _productModels.firstWhere(
      (m) => m['id'] == _selectedProductModelId,
      orElse: () => {'name': ''},
    )['name'];

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
                      // Product Name
                      const Text(
                        'Product Name',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                      ),
                      const SizedBox(height: 8),
                      _isLoadingNames
                          ? const Center(child: CircularProgressIndicator())
                          : DropdownMenu<String>(
                              expandedInsets: EdgeInsets.zero,
                              enableFilter: true,
                              hintText: 'Select Product Name',
                              requestFocusOnTap: true,
                              dropdownMenuEntries: _productNames.map((name) {
                                return DropdownMenuEntry<String>(
                                  value: name['id']!,
                                  label: name['name']!,
                                );
                              }).toList(),
                              onSelected: (id) {
                                if (id != null) {
                                  setState(() {
                                    _selectedProductNameId = id;
                                  });
                                  _loadProductModels(id);
                                }
                              },
                            ),
                      const SizedBox(height: 20),

                      // Product Model
                      const Text(
                        'Product Model',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                      ),
                      const SizedBox(height: 8),
                      _isLoadingModels
                          ? const Center(child: CircularProgressIndicator())
                          : DropdownMenu<String>(
                              key: ValueKey('model_$_selectedProductNameId'),
                              expandedInsets: EdgeInsets.zero,
                              enableFilter: true,
                              enabled: _selectedProductNameId != null,
                              hintText: 'Select Product Model',
                              requestFocusOnTap: true,
                              dropdownMenuEntries: _productModels.map((model) {
                                return DropdownMenuEntry<String>(
                                  value: model['id']!,
                                  label: model['name']!,
                                );
                              }).toList(),
                                onSelected: (id) {
                                  if (id != null) {
                                    setState(() {
                                      _selectedProductModelId = id;
                                    });
                                    _loadProductDetails(id);
                                  }
                                },
                            ),
                      const SizedBox(height: 20),

                      // Serial Number TextField
                      const Text(
                        'Serial Number',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _serialNumberController,
                        decoration: InputDecoration(
                          hintText: 'Enter product serial number',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.qr_code_scanner),
                            onPressed: _scanSerialNumber,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Serial Number is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Product Information Card
                      if (_productId != null) ...[
                        Container(
                          padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                          decoration: BoxDecoration(
                            color: const Color(0xFFECEEF0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Product Details',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Model: $selectedModelName',
                                style: const TextStyle(fontSize: 13, color: Color(0xFF3E4A3D)),
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
                          if (value.trim().length < 10) {
                            return 'Mobile number must be at least 10 digits';
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
                        // Vehicle number is optional per the API
                        validator: null,
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
                            color: const Color(0xFFD5E0F8).withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFD5E0F8)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedModelName ?? 'Product',
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
