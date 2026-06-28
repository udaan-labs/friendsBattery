import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../theme/app_theme.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../core/network/api_client_provider.dart';
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

  bool _isLoadingGroups = false;
  bool _isLoadingCategories = false;
  bool _isLoadingNames = false;
  bool _isLoadingModels = false;
  bool _isLoadingDetails = false;
  bool _isSubmitting = false;

  List<Map<String, String>> _groups = [];
  List<Map<String, String>> _categories = [];
  List<Map<String, String>> _productNames = [];
  List<Map<String, String>> _productModels = [];

  String? _selectedGroupId;
  String? _selectedCategoryId;
  String? _selectedProductNameId;
  String? _selectedProductModelId;

  int? _currentStock;
  num? _currentMinPrice;

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _minPriceController.dispose();
    super.dispose();
  }

  Future<void> _loadGroups() async {
    setState(() {
      _isLoadingGroups = true;
    });
    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final response = await api.apiProductsGroupsGet();
      final data = (response as dynamic).data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        final list = data['data'] as List;
        setState(() {
          _groups = list.map((item) {
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
        _isLoadingGroups = false;
      });
    }
  }

  Future<void> _loadCategories(String groupId) async {
    setState(() {
      _isLoadingCategories = true;
      _categories = [];
      _selectedCategoryId = null;
      _productNames = [];
      _selectedProductNameId = null;
      _productModels = [];
      _selectedProductModelId = null;
      _currentStock = null;
      _currentMinPrice = null;
    });

    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final request = ApiProductsCategoriesListPostRequest((b) => b..groupId = int.parse(groupId));
      final response = await api.apiProductsCategoriesListPost(
        apiProductsCategoriesListPostRequest: request,
      );
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
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      setState(() {
        _isLoadingCategories = false;
      });
    }
  }

  Future<void> _loadProductNames(String categoryId) async {
    setState(() {
      _isLoadingNames = true;
      _productNames = [];
      _selectedProductNameId = null;
      _productModels = [];
      _selectedProductModelId = null;
      _currentStock = null;
      _currentMinPrice = null;
    });

    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final request = ApiProductsProductNamesListPostRequest((b) => b..categoryId = int.parse(categoryId));
      final response = await api.apiProductsProductNamesListPost(
        apiProductsProductNamesListPostRequest: request,
      );
      final data = (response as dynamic).data;
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
      _currentStock = null;
      _currentMinPrice = null;
    });

    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final request = ApiProductsProductModelsListPostRequest((b) => b
        ..categoryId = int.parse(_selectedCategoryId!)
        ..productNameId = int.parse(productNameId));
      final response = await api.apiProductsProductModelsListPost(
        apiProductsProductModelsListPostRequest: request,
      );
      final data = (response as dynamic).data;
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
      _isLoadingDetails = true;
      _currentStock = null;
      _currentMinPrice = null;
    });

    try {
      final api = ref.read(apiClientProvider).getInventoryApi();
      final response = await api.apiInventoryProductDetailsGet(
        categoryId: _selectedCategoryId!,
        productNameId: _selectedProductNameId!,
        productModelId: productModelId,
      );

      final details = response.data?.data;
      if (details != null) {
        setState(() {
          _currentStock = details.currentStock ?? 0;
          _currentMinPrice = details.minSellPrice ?? 0;
        });
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      setState(() {
        _isLoadingDetails = false;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedGroupId == null || _selectedCategoryId == null || _selectedProductNameId == null || _selectedProductModelId == null) {
      context.showErrorSnackBar('Please select all product fields');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final api = ref.read(apiClientProvider).getInventoryApi();
      final quantity = int.parse(_quantityController.text);
      final minPrice = _minPriceController.text.isNotEmpty ? num.parse(_minPriceController.text) : null;

      final request = ApiInventoryUpdateStockPostRequest((b) => b
        ..productCategoryId = int.parse(_selectedCategoryId!)
        ..productNameId = int.parse(_selectedProductNameId!)
        ..productModelId = int.parse(_selectedProductModelId!)
        ..quantity = quantity
        ..minSellPrice = minPrice);

      await api.apiInventoryUpdateStockPost(
        apiInventoryUpdateStockPostRequest: request,
      );

      if (mounted) {
        context.showSuccessSnackBar('Stock updated successfully');
        // Refresh dashboard statistics
        ref.read(dashboardControllerProvider).refreshAllData();
        // Refresh inventory list
        ref.invalidate(inventoryListProvider);
        context.pop();
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      setState(() {
        _isSubmitting = false;
      });
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
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Product Group
                          const Text(
                            'Product Group',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                          ),
                          const SizedBox(height: 8),
                          _isLoadingGroups
                              ? const Center(child: CircularProgressIndicator())
                              : DropdownMenu<String>(
                                  expandedInsets: EdgeInsets.zero,
                                  enableFilter: true,
                                  hintText: 'Select Group',
                                  requestFocusOnTap: true,
                                  dropdownMenuEntries: _groups.map((group) {
                                    return DropdownMenuEntry<String>(
                                      value: group['id']!,
                                      label: group['name']!,
                                    );
                                  }).toList(),
                                  onSelected: (id) {
                                    if (id != null) {
                                      setState(() {
                                        _selectedGroupId = id;
                                      });
                                      _loadCategories(id);
                                    }
                                  },
                                ),
                          const SizedBox(height: 20),

                          // Product Category
                          const Text(
                            'Product Category',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                          ),
                          const SizedBox(height: 8),
                          _isLoadingCategories
                              ? const Center(child: CircularProgressIndicator())
                              : DropdownMenu<String>(
                                  key: ValueKey('category_$_selectedGroupId'),
                                  expandedInsets: EdgeInsets.zero,
                                  enableFilter: true,
                                  enabled: _selectedGroupId != null,
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
                                      setState(() {
                                        _selectedCategoryId = id;
                                      });
                                      _loadProductNames(id);
                                    }
                                  },
                                ),
                          const SizedBox(height: 20),

                          // Product Name
                          const Text(
                            'Product Name',
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

                          // Product Information Section
                          if (_selectedProductModelId != null) ...[
                            Container(
                              padding: const EdgeInsets.all(16),
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

                          // Quantity to Add
                          const Text(
                            'Quantity to Add',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Enter quantity',
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Quantity is required';
                              }
                              final parsed = int.tryParse(value);
                              if (parsed == null || parsed <= 0) {
                                return 'Quantity must be greater than 0';
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
