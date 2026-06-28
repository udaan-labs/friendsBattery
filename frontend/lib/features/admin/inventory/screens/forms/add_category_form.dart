import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../../shared/widgets/responsive_helper.dart';
import '../../../../../core/network/api_client_provider.dart';
import '../../../../../shared/widgets/snackbar_helper.dart';

class AddCategoryForm extends ConsumerStatefulWidget {
  const AddCategoryForm({super.key});

  @override
  ConsumerState<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends ConsumerState<AddCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();
  final _productNameController = TextEditingController();
  final _productModelController = TextEditingController();

  bool _isLoadingGroups = false;
  bool _isSubmitting = false;

  List<Map<String, String>> _groups = [];
  String? _selectedGroupId;

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  @override
  void dispose() {
    _categoryController.dispose();
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedGroupId == null) {
      context.showErrorSnackBar('Please select a Group');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final api = ref.read(apiClientProvider).getProductsApi();

      // 1. Create Category
      final catReq = ApiProductsCategoriesPostRequest((b) => b
        ..groupId = int.parse(_selectedGroupId!)
        ..name = _categoryController.text.trim());
      final catRes = await api.apiProductsCategoriesPost(apiProductsCategoriesPostRequest: catReq);
      final catData = (catRes as dynamic).data['data'];
      final categoryId = catData['id'] as int;

      // 2. Create Product Name
      final nameReq = ApiProductsProductNamesPostRequest((b) => b
        ..categoryId = categoryId
        ..name = _productNameController.text.trim());
      final nameRes = await api.apiProductsProductNamesPost(apiProductsProductNamesPostRequest: nameReq);
      final nameData = (nameRes as dynamic).data['data'];
      final productNameId = nameData['id'] as int;

      // 3. Create Product Model
      final modelReq = ApiProductsProductModelsPostRequest((b) => b
        ..productNameId = productNameId
        ..name = _productModelController.text.trim());
      await api.apiProductsProductModelsPost(apiProductsProductModelsPostRequest: modelReq);

      if (mounted) {
        context.showSuccessSnackBar('Category and descendants created successfully');
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
        title: const Text('Add New Category'),
        backgroundColor: const Color(0xFFF7F9FB),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
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
                padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Group',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                      ),
                      const SizedBox(height: 8),
                      _isLoadingGroups
                          ? const Center(child: CircularProgressIndicator())
                          : DropdownMenu<String>(
                              expandedInsets: EdgeInsets.zero,
                              enableFilter: true,
                              hintText: 'Select Existing Group',
                              dropdownMenuEntries: _groups.map((g) {
                                return DropdownMenuEntry<String>(value: g['id']!, label: g['name']!);
                              }).toList(),
                              onSelected: (id) => setState(() => _selectedGroupId = id),
                            ),
                      const SizedBox(height: 16),

                      _buildTextField('Category Name', _categoryController),
                      const SizedBox(height: 16),
                      _buildTextField('Product Name', _productNameController),
                      const SizedBox(height: 16),
                      _buildTextField('Product Model', _productModelController),
                      const SizedBox(height: 32),

                      ElevatedButton(
                        onPressed: _isSubmitting ? null : _submit,
                        child: _isSubmitting
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('Save Category'),
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
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter $label'),
          validator: (value) {
            if (value == null || value.trim().isEmpty) return '$label is required';
            return null;
          },
        ),
      ],
    );
  }
}
