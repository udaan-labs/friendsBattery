import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../../core/network/api_client_provider.dart';
import '../../../../../shared/widgets/snackbar_helper.dart';

class CreateProductForm extends ConsumerStatefulWidget {
  const CreateProductForm({super.key});

  @override
  ConsumerState<CreateProductForm> createState() => _CreateProductFormState();
}

class _CreateProductFormState extends ConsumerState<CreateProductForm> {
  final _formKey = GlobalKey<FormState>();
  
  final _minPriceController = TextEditingController();
  final _offerPriceController = TextEditingController();
  final _minUnitAdminController = TextEditingController();
  final _minUnitSellerController = TextEditingController();

  bool _isLoadingGroups = false;
  bool _isLoadingCategories = false;
  bool _isLoadingNames = false;
  bool _isLoadingModels = false;
  bool _isSubmitting = false;

  List<Map<String, String>> _groups = [];
  List<Map<String, String>> _categories = [];
  List<Map<String, String>> _productNames = [];
  List<Map<String, String>> _productModels = [];
  
  String? _selectedGroupId;
  String? _selectedCategoryId;
  String? _selectedProductNameId;
  String? _selectedProductModelId;

  bool _onSale = false;

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _offerPriceController.dispose();
    _minUnitAdminController.dispose();
    _minUnitSellerController.dispose();
    super.dispose();
  }

  Future<void> _loadGroups() async {
    setState(() => _isLoadingGroups = true);
    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final response = await api.apiProductsGroupsGet();
      final data = (response as dynamic).data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        final list = data['data'] as List;
        setState(() {
          _groups = list.map((item) => {
            'id': item['id'].toString(),
            'name': item['name'].toString(),
          }).toList();
        });
      }
    } catch (e) {
      // Error handled by interceptor
    } finally {
      if (mounted) setState(() => _isLoadingGroups = false);
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
    });
    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final request = ApiProductsCategoriesListPostRequest((b) => b..groupId = int.parse(groupId));
      final response = await api.apiProductsCategoriesListPost(apiProductsCategoriesListPostRequest: request);
      final data = (response as dynamic).data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        final list = data['data'] as List;
        setState(() {
          _categories = list.map((item) => {
            'id': item['id'].toString(),
            'name': item['name'].toString(),
          }).toList();
        });
      }
    } catch (e) {
      // Error handled by interceptor
    } finally {
      if (mounted) setState(() => _isLoadingCategories = false);
    }
  }

  Future<void> _loadProductNames(String categoryId) async {
    setState(() {
      _isLoadingNames = true;
      _productNames = [];
      _selectedProductNameId = null;
      _productModels = [];
      _selectedProductModelId = null;
    });
    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final request = ApiProductsProductNamesListPostRequest((b) => b..categoryId = int.parse(categoryId));
      final response = await api.apiProductsProductNamesListPost(apiProductsProductNamesListPostRequest: request);
      final data = (response as dynamic).data;
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
      // Error handled by interceptor
    } finally {
      if (mounted) setState(() => _isLoadingNames = false);
    }
  }

  Future<void> _loadProductModels(String productNameId) async {
    setState(() {
      _isLoadingModels = true;
      _productModels = [];
      _selectedProductModelId = null;
    });
    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final request = ApiProductsProductModelsListPostRequest((b) => b
        ..categoryId = int.parse(_selectedCategoryId!)
        ..productNameId = int.parse(productNameId));
      final response = await api.apiProductsProductModelsListPost(apiProductsProductModelsListPostRequest: request);
      final data = (response as dynamic).data;
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
      // Error handled by interceptor
    } finally {
      if (mounted) setState(() => _isLoadingModels = false);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null || _selectedProductNameId == null || _selectedProductModelId == null) {
      context.showErrorSnackBar('Please select Category, Product Name, and Product Model');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final api = ref.read(apiClientProvider).getProductsApi();

      final minPrice = _minPriceController.text.isNotEmpty ? num.parse(_minPriceController.text) : 0;
      final offerPrice = _offerPriceController.text.isNotEmpty ? num.parse(_offerPriceController.text) : null;
      final minUnitCountAdmin = _minUnitAdminController.text.isNotEmpty ? int.parse(_minUnitAdminController.text) : 0;
      final minUnitCountSeller = _minUnitSellerController.text.isNotEmpty ? int.parse(_minUnitSellerController.text) : 0;

      final productReq = ApiProductsPostRequest((b) => b
        ..categoryId = int.parse(_selectedCategoryId!)
        ..productNameId = int.parse(_selectedProductNameId!)
        ..productModelId = int.parse(_selectedProductModelId!)
        ..minPrice = minPrice
        ..onSale = _onSale
        ..offerPrice = offerPrice
        ..minUnitCountAdmin = minUnitCountAdmin
        ..minUnitCountSeller = minUnitCountSeller);

      await api.apiProductsPost(apiProductsPostRequest: productReq);

      if (mounted) {
        context.showSuccessSnackBar('Product configured successfully');
        context.pop();
      }
    } catch (e) {
      // Error handled by interceptor
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Configure Product Pricing & Units'),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 4)),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Hierarchical Selection
                    const Text('Group', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E))),
                    const SizedBox(height: 8),
                    _isLoadingGroups
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownMenu<String>(
                            expandedInsets: EdgeInsets.zero,
                            enableFilter: true,
                            hintText: 'Select Existing Group',
                            dropdownMenuEntries: _groups.map((g) => DropdownMenuEntry(value: g['id']!, label: g['name']!)).toList(),
                            onSelected: (id) {
                              if (id != null) {
                                setState(() => _selectedGroupId = id);
                                _loadCategories(id);
                              }
                            },
                          ),
                    const SizedBox(height: 16),

                    const Text('Category', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E))),
                    const SizedBox(height: 8),
                    _isLoadingCategories
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownMenu<String>(
                            expandedInsets: EdgeInsets.zero,
                            enableFilter: true,
                            hintText: 'Select Existing Category',
                            dropdownMenuEntries: _categories.map((c) => DropdownMenuEntry(value: c['id']!, label: c['name']!)).toList(),
                            onSelected: (id) {
                              if (id != null) {
                                setState(() => _selectedCategoryId = id);
                                _loadProductNames(id);
                              }
                            },
                          ),
                    const SizedBox(height: 16),

                    const Text('Product Name', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E))),
                    const SizedBox(height: 8),
                    _isLoadingNames
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownMenu<String>(
                            expandedInsets: EdgeInsets.zero,
                            enableFilter: true,
                            hintText: 'Select Existing Product Name',
                            dropdownMenuEntries: _productNames.map((n) => DropdownMenuEntry(value: n['id']!, label: n['name']!)).toList(),
                            onSelected: (id) {
                              if (id != null) {
                                setState(() => _selectedProductNameId = id);
                                _loadProductModels(id);
                              }
                            },
                          ),
                    const SizedBox(height: 16),

                    const Text('Product Model', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E))),
                    const SizedBox(height: 8),
                    _isLoadingModels
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownMenu<String>(
                            expandedInsets: EdgeInsets.zero,
                            enableFilter: true,
                            hintText: 'Select Existing Product Model',
                            dropdownMenuEntries: _productModels.map((m) => DropdownMenuEntry(value: m['id']!, label: m['name']!)).toList(),
                            onSelected: (id) {
                              if (id != null) {
                                setState(() => _selectedProductModelId = id);
                              }
                            },
                          ),
                    const SizedBox(height: 32),
                    
                    // Pricing Section
                    const Divider(),
                    const SizedBox(height: 16),
                    const Text('Pricing Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF191C1E))),
                    const SizedBox(height: 16),

                    const Text('Minimum Price', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E))),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _minPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Enter minimum allowed price', prefixText: '₹ '),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return 'Minimum Price is required';
                        if (num.tryParse(value) == null) return 'Must be a valid number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    CheckboxListTile(
                      title: const Text('Is On Sale?', style: TextStyle(fontWeight: FontWeight.w600)),
                      contentPadding: EdgeInsets.zero,
                      value: _onSale,
                      onChanged: (val) {
                        setState(() => _onSale = val ?? false);
                      },
                    ),
                    const SizedBox(height: 16),

                    if (_onSale) ...[
                      const Text('Offer Price', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E))),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _offerPriceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: 'Enter offer price', prefixText: '₹ '),
                        validator: (value) {
                          if (_onSale && (value == null || value.trim().isEmpty)) return 'Offer Price is required if on sale';
                          if (value != null && value.trim().isNotEmpty && num.tryParse(value) == null) return 'Must be a valid number';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Minimum Units Section
                    const Divider(),
                    const SizedBox(height: 16),
                    const Text('Threshold Configuration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF191C1E))),
                    const SizedBox(height: 16),

                    const Text('Minimum Units for Admin', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E))),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _minUnitAdminController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Enter minimum units for admin alert'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return 'Minimum Units for Admin is required';
                        if (int.tryParse(value) == null || int.parse(value) < 0) return 'Must be a non-negative integer';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    const Text('Minimum Units for Seller', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E))),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _minUnitSellerController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Enter minimum units for seller alert'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return 'Minimum Units for Seller is required';
                        if (int.tryParse(value) == null || int.parse(value) < 0) return 'Must be a non-negative integer';
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _isSubmitting ? null : _submit,
                      child: _isSubmitting
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : const Text('Save Configuration'),
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
