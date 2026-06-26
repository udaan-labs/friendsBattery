import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../../core/network/api_client_provider.dart';
import '../../../../../shared/widgets/snackbar_helper.dart';

class AddProductNameForm extends ConsumerStatefulWidget {
  const AddProductNameForm({super.key});

  @override
  ConsumerState<AddProductNameForm> createState() => _AddProductNameFormState();
}

class _AddProductNameFormState extends ConsumerState<AddProductNameForm> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productModelController = TextEditingController();

  bool _isLoadingGroups = false;
  bool _isLoadingCategories = false;
  bool _isSubmitting = false;

  List<Map<String, String>> _groups = [];
  List<Map<String, String>> _categories = [];
  
  String? _selectedGroupId;
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productModelController.dispose();
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null) {
      context.showErrorSnackBar('Please select a Category');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final api = ref.read(apiClientProvider).getProductsApi();

      // 1. Create Product Name
      final nameReq = ApiProductsProductNamesPostRequest((b) => b
        ..categoryId = int.parse(_selectedCategoryId!)
        ..name = _productNameController.text.trim());
      final nameRes = await api.apiProductsProductNamesPost(apiProductsProductNamesPostRequest: nameReq);
      final nameData = (nameRes as dynamic).data['data'];
      final productNameId = nameData['id'] as int;

      // 2. Create Product Model
      final modelReq = ApiProductsProductModelsPostRequest((b) => b
        ..productNameId = productNameId
        ..name = _productModelController.text.trim());
      await api.apiProductsProductModelsPost(apiProductsProductModelsPostRequest: modelReq);

      if (mounted) {
        context.showSuccessSnackBar('Product Name and Model created successfully');
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
        title: const Text('Add Product Name'),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
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
                              key: ValueKey('cat_$_selectedGroupId'),
                              expandedInsets: EdgeInsets.zero,
                              enableFilter: true,
                              enabled: _selectedGroupId != null,
                              hintText: 'Select Existing Category',
                              dropdownMenuEntries: _categories.map((c) => DropdownMenuEntry(value: c['id']!, label: c['name']!)).toList(),
                              onSelected: (id) => setState(() => _selectedCategoryId = id),
                            ),
                      const SizedBox(height: 16),

                      _buildTextField('Product Name', _productNameController),
                      const SizedBox(height: 16),
                      _buildTextField('Product Model', _productModelController),
                      const SizedBox(height: 32),

                      ElevatedButton(
                        onPressed: _isSubmitting ? null : _submit,
                        child: _isSubmitting
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('Save Product Name'),
                      ),
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E))),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter $label'),
          validator: (value) => value == null || value.trim().isEmpty ? '$label is required' : null,
        ),
      ],
    );
  }
}
