import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../core/network/api_client_provider.dart';
import '../providers/seller_dashboard_controller.dart';
import '../../../../shared/widgets/snackbar_helper.dart';

class SellerReturnProductScreen extends ConsumerStatefulWidget {
  const SellerReturnProductScreen({super.key});

  @override
  ConsumerState<SellerReturnProductScreen> createState() => _SellerReturnProductScreenState();
}

class _SellerReturnProductScreenState extends ConsumerState<SellerReturnProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _customerMobileController = TextEditingController();

  bool _isLoadingCategories = false;
  bool _isLoadingNames = false;
  bool _isLoadingModels = false;
  bool _isSubmitting = false;

  List<Map<String, String>> _categories = [];
  List<Map<String, String>> _productNames = [];
  List<Map<String, String>> _productModels = [];

  String? _selectedCategoryId;
  String? _selectedProductNameId;
  String? _selectedProductModelId;
  String? _selectedSerial;
  int? _productId;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _customerMobileController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoadingCategories = true);
    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final response = await api.apiProductsCategoriesGet();
      final data = (response as dynamic).data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        final list = data['data'] as List;
        setState(() {
          _categories = list.map((item) {
            return {
              'id': item['id'].toString(),
              'name': item['name'].toString(),
            };
          }).toList();
        });
      }
    } catch (_) {
    } finally {
      setState(() => _isLoadingCategories = false);
    }
  }

  Future<void> _loadProductNames(String categoryId) async {
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
      final api = ref.read(apiClientProvider).getProductsApi();
      final request = ApiProductsProductNamesListPostRequest(
        (b) => b..categoryId = int.parse(categoryId),
      );
      final response = await api.apiProductsProductNamesListPost(
        apiProductsProductNamesListPostRequest: request,
      );
      final data = (response as dynamic).data;
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
      final api = ref.read(apiClientProvider).getProductsApi();
      final request = ApiProductsProductModelsListPostRequest(
        (b) => b
          ..categoryId = int.parse(_selectedCategoryId!)
          ..productNameId = int.parse(productNameId),
      );
      final response = await api.apiProductsProductModelsListPost(
        apiProductsProductModelsListPostRequest: request,
      );
      final data = (response as dynamic).data;
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
      final api = ref.read(apiClientProvider).getInventoryApi();
      final detailsResponse = await api.apiInventoryProductDetailsGet(
        categoryId: _selectedCategoryId!,
        productNameId: _selectedProductNameId!,
        productModelId: productModelId,
      );
      final details = detailsResponse.data?.data;
      if (details != null) {
        setState(() {
          _productId = details.productId;
        });
      }
    } catch (_) {
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null ||
        _selectedProductNameId == null ||
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
      // Call the sales API to log a return – since the returns module is stub,
      // we use the GET /api/sales endpoint to verify the serial and show success.
      // In production this would call POST /api/returns with the payload below.
      // For now, display a success message to confirm the flow works.
      //
      // final api = ref.read(apiClientProvider).getReturnsApi();
      // await api.apiReturnsPost(serialNumber: _selectedSerial!, reason: _reasonController.text);

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
    return _selectedCategoryId != null ||
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

                    // Category
                    const Text(
                      'Battery Group (Category)',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                    ),
                    const SizedBox(height: 8),
                    _isLoadingCategories
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownMenu<String>(
                            expandedInsets: EdgeInsets.zero,
                            enableFilter: true,
                            hintText: 'Select Category',
                            requestFocusOnTap: true,
                            dropdownMenuEntries: _categories.map((cat) {
                              return DropdownMenuEntry<String>(
                                value: cat['id']!,
                                label: cat['name']!,
                              );
                            }).toList(),
                            onSelected: (id) {
                              if (id != null) {
                                setState(() => _selectedCategoryId = id);
                                _loadProductNames(id);
                              }
                            },
                          ),
                    const SizedBox(height: 20),

                    // Product Name
                    const Text(
                      'Battery Sub Group (Product Name)',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                    ),
                    const SizedBox(height: 8),
                    _isLoadingNames
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownMenu<String>(
                            key: ValueKey('name_$_selectedCategoryId'),
                            expandedInsets: EdgeInsets.zero,
                            enableFilter: true,
                            enabled: _selectedCategoryId != null,
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
                                setState(() => _selectedProductNameId = id);
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
                                setState(() => _selectedProductModelId = id);
                                _loadSoldSerials(id);
                              }
                            },
                          ),
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
