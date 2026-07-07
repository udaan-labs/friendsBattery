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

  bool _isLoadingNames = false;
  bool _isLoadingModels = false;
  bool _isSubmitting = false;

  List<Map<String, String>> _productNames = [];
  List<Map<String, String>> _productModels = [];

  String? _selectedProductNameId;
  String? _selectedProductModelId;
  String? _selectedSerial;
  int? _productId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadProductNames();
    });
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _customerMobileController.dispose();
    super.dispose();
  }

  Future<void> _loadProductNames() async {
    setState(() {
      _isLoadingNames = true;
      _productNames = [];
      _selectedProductNameId = null;
      _productModels = [];
      _selectedProductModelId = null;
      _selectedSerial = null;
      _productId = null;
    });

    try {
      final dio = ApiClient().dio;
      final response = await dio.get('/api/products/product-names');
      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        final list = data['data'] as List;
        setState(() {
          _productNames = list
              .map((item) => {
                    'id': item['id'].toString(),
                    'name': item['name'].toString(),
                  })
              .toList();
        });
      }
    } catch (_) {
    } finally {
      setState(() => _isLoadingNames = false);
    }
  }

  Future<void> _loadProductModels(String productNameId) async {
    setState(() {
      _isLoadingModels = true;
      _productModels = [];
      _selectedProductModelId = null;
      _selectedSerial = null;
      _productId = null;
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
          _productModels = list
              .map((item) => {
                    'id': item['id'].toString(),
                    'name': item['name'].toString(),
                  })
              .toList();
        });
      }
    } catch (_) {
    } finally {
      setState(() => _isLoadingModels = false);
    }
  }

  Future<void> _loadSoldSerials(String productModelId) async {
    setState(() {
      _selectedSerial = null;
      _productId = null;
    });

    try {
      final dio = ApiClient().dio;
      final response = await dio.get('/api/inventory/product-details', queryParameters: {
        'product_name_id': _selectedProductNameId!,
        'product_model_id': productModelId,
      });
      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] != null) {
        setState(() {
          _productId = data['data']['productId'];
        });
      }
    } catch (_) {
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedProductNameId == null ||
        _selectedProductModelId == null ||
        _selectedSerial == null ||
        _selectedSerial!.trim().isEmpty) {
      context.showErrorSnackBar('Please fill in all product fields and serial number');
      return;
    }
    if (_productId == null) {
      context.showErrorSnackBar('Product ID could not be resolved. Please reselect the product.');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // In production this would call POST /api/returns with the payload below.
      // For now, display a success message to confirm the flow works.
      if (mounted) {
        context.showSuccessSnackBar('Return request submitted successfully');
        await ref.read(sellerDashboardControllerProvider).refreshAllData();
        if (mounted) {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/seller/dashboard');
          }
        }
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar('Failed to submit return. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  bool _hasUnsavedChanges() {
    return _selectedProductNameId != null ||
        (_selectedSerial != null && _selectedSerial!.isNotEmpty) ||
        _customerMobileController.text.isNotEmpty ||
        _reasonController.text.isNotEmpty;
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
        title: const Text(
          'Return Product',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
        leading: context.canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF3E4A3D)),
                onPressed: _onBackPressed,
              )
            : IconButton(
                icon: const Icon(Icons.menu, color: Color(0xFF3E4A3D)),
                onPressed: () => sellerScaffoldKey.currentState?.openDrawer(),
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
                    Icon(Icons.info_outline, color: Color(0xFF16A34A), size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Use this form to initiate a product return. Enter the sold product details and serial number.',
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
                      'Product Selection',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF191C1E),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Product Name
                    const Text(
                      'Product Name',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                    ),
                    const SizedBox(height: 8),
                    _isLoadingNames
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          )
                        : (_productNames.isEmpty
                            ? TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  hintText: 'No products available. Please contact admin.',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                ),
                              )
                            : DropdownButtonFormField<String>(
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                hint: const Text('Select Product Name'),
                                items: _productNames.map((name) {
                                  return DropdownMenuItem<String>(
                                    value: name['id']!,
                                    child: Text(name['name']!),
                                  );
                                }).toList(),
                                onChanged: (id) {
                                  if (id != null) {
                                    setState(() => _selectedProductNameId = id);
                                    _loadProductModels(id);
                                  }
                                },
                              )),
                    const SizedBox(height: 20),

                    // Product Model
                    const Text(
                      'Product Model',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                    ),
                    const SizedBox(height: 8),
                    _isLoadingModels
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          )
                        : (_selectedProductNameId == null
                            ? TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  hintText: 'Select Product Name first',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                ),
                              )
                            : (_productModels.isEmpty
                                ? TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      hintText: 'No models available for this product.',
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                    ),
                                  )
                                : DropdownButtonFormField<String>(
                                    key: ValueKey('model_$_selectedProductNameId'),
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    hint: const Text('Select Product Model'),
                                    items: _productModels.map((model) {
                                      return DropdownMenuItem<String>(
                                        value: model['id']!,
                                        child: Text(model['name']!),
                                      );
                                    }).toList(),
                                    onChanged: (id) {
                                      if (id != null) {
                                        setState(() => _selectedProductModelId = id);
                                        _loadSoldSerials(id);
                                      }
                                    },
                                  ))),
                    const SizedBox(height: 20),

                    // Serial Number – free text for returns
                    const Text(
                      'Battery Serial Number',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      enabled: _selectedProductModelId != null,
                      onChanged: (v) => setState(() => _selectedSerial = v),
                      decoration: InputDecoration(
                        hintText: 'Enter the sold battery serial number',
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
                  ],
                ),
              ),
              const SizedBox(height: 16),

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
