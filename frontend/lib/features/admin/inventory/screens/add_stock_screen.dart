import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import '../../../../theme/app_theme.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../core/network/api_client.dart';
import '../../../../shared/widgets/scanner_screen.dart';
import '../providers/inventory_provider.dart';
import '../../dashboard/providers/dashboard_controller.dart';
import '../../../../shared/widgets/snackbar_helper.dart';

class AddStockScreen extends ConsumerStatefulWidget {
  const AddStockScreen({super.key});

  @override
  ConsumerState<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends ConsumerState<AddStockScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _minPriceController = TextEditingController();

  bool _isLoadingNames = false;
  bool _isLoadingModels = false;
  bool _isLoadingDetails = false;
  bool _isSubmitting = false;

  List<Map<String, String>> _productNames = [];
  List<Map<String, String>> _productModels = [];

  String? _selectedProductNameId;
  String? _selectedProductModelId;

  int? _currentStock;
  num? _currentMinPrice;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadProductNames();
    });
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _minPriceController.dispose();
    super.dispose();
  }

  Future<void> _loadProductNames() async {
    setState(() => _isLoadingNames = true);
    try {
      final dio = ApiClient().dio;
      final response = await dio.get('/api/products/product-names');
      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        final list = data['data'] as List;
        setState(() {
          _productNames = list.map((item) => {
            'id': item['id'].toString(),
            'name': item['name'].toString(),
          }).toList();
        });
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      if (mounted) setState(() => _isLoadingNames = false);
    }
  }

  Future<void> _loadProductModels(String productNameId) async {
    setState(() {
      _isLoadingModels = true;
      _productModels = [];
      _selectedProductModelId = null;
      _currentStock = null;
      _currentMinPrice = null;
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
          _productModels = list.map((item) => {
            'id': item['id'].toString(),
            'name': item['name'].toString(),
          }).toList();
        });
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      if (mounted) setState(() => _isLoadingModels = false);
    }
  }

  Future<void> _loadProductDetails(String productModelId) async {
    setState(() {
      _isLoadingDetails = true;
      _currentStock = null;
      _currentMinPrice = null;
    });

    try {
      final dio = ApiClient().dio;
      final response = await dio.get('/api/inventory/product-details', queryParameters: {
        'product_name_id': _selectedProductNameId!,
        'product_model_id': productModelId,
      });

      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] != null) {
        final details = data['data'];
        setState(() {
          _currentStock = details['currentStock'] ?? 0;
          _currentMinPrice = details['minSellPrice'] ?? 0;
        });
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      if (mounted) setState(() => _isLoadingDetails = false);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedProductNameId == null || _selectedProductModelId == null) {
      context.showErrorSnackBar('Please select Product Name and Product Model');
      return;
    }
    if (_quantityController.text.trim().isEmpty) {
      context.showErrorSnackBar('Please enter a quantity');
      return;
    }
    final quantity = int.tryParse(_quantityController.text.trim());
    if (quantity == null || quantity <= 0) {
      context.showErrorSnackBar('Quantity must be a positive number');
      return;
    }
    if (_selectedProductNameId == null || _selectedProductModelId == null) {
      context.showErrorSnackBar('Please select Product Name and Product Model');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final dio = ApiClient().dio;
      final minPrice = _minPriceController.text.isNotEmpty ? num.parse(_minPriceController.text) : null;

      await dio.post('/api/inventory/update-stock', data: {
        'productNameId': int.parse(_selectedProductNameId!),
        'productModelId': int.parse(_selectedProductModelId!),
        'quantity': quantity,
        if (minPrice != null) 'minSellPrice': minPrice,
      });

      if (mounted) {
        context.showSuccessSnackBar('Stock updated successfully');
        // Refresh dashboard statistics
        ref.read(dashboardControllerProvider).refreshAllData();
        // Refresh inventory list
        ref.invalidate(inventoryListProvider);
        context.pop();
      }
    } on DioException catch (e) {
      if (mounted) {
        final msg = e.response?.data?['message'] ?? 'Failed to update stock';
        context.showErrorSnackBar(msg);
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Add Stock'),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3E4A3D)),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/admin/dashboard');
            }
          },
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
                                        hintText: 'No products available. Please create one first.',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                      ),
                                    )
                                  : DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                          ),
                                        )
                                      : DropdownButtonFormField<String>(
                                          key: ValueKey('model_$_selectedProductNameId'),
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
                                              _loadProductDetails(id);
                                            }
                                          },
                                        ))),
                          const SizedBox(height: 20),

                          // Product Information Section
                          if (_selectedProductModelId != null) ...[
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
                                    'Product Information',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
                                  ),
                                  const SizedBox(height: 8),
                                  _isLoadingDetails
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Current Stock: ${_currentStock ?? 0}',
                                              style: const TextStyle(fontSize: 13, color: Color(0xFF3E4A3D)),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Current Min Price: ₹${_currentMinPrice ?? 0}',
                                              style: const TextStyle(fontSize: 13, color: Color(0xFF3E4A3D)),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],

                          // Quantity
                          const Text(
                            'Quantity',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Enter quantity to add',
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a quantity';
                              }
                              final parsed = int.tryParse(value);
                              if (parsed == null || parsed <= 0) {
                                return 'Quantity must be a positive number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Minimum Selling Price
                          const Text(
                            'Minimum Selling Price (Optional)',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _minPriceController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Enter minimum selling price',
                              prefixText: '₹ ',
                            ),
                            validator: (value) {
                              if (value != null && value.trim().isNotEmpty) {
                                final parsed = num.tryParse(value);
                                if (parsed == null || parsed < 0) {
                                  return 'Minimum price must be greater than or equal to 0';
                                }
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),

                          // Submit Button
                          ElevatedButton(
                            onPressed: _isSubmitting ? null : _submit,
                            child: _isSubmitting
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Update Stock',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
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
    );
  }
}
