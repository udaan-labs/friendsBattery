import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../../shared/widgets/responsive_helper.dart';
import '../../../../../core/network/api_client_provider.dart';
import '../../../../../shared/widgets/snackbar_helper.dart';

class CreateCompleteHierarchyForm extends ConsumerStatefulWidget {
  const CreateCompleteHierarchyForm({super.key});

  @override
  ConsumerState<CreateCompleteHierarchyForm> createState() => _CreateCompleteHierarchyFormState();
}

class _CreateCompleteHierarchyFormState extends ConsumerState<CreateCompleteHierarchyForm> {
  final _formKey = GlobalKey<FormState>();
  final _groupController = TextEditingController();
  final _categoryController = TextEditingController();
  final _productNameController = TextEditingController();
  final _productModelController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _groupController.dispose();
    _categoryController.dispose();
    _productNameController.dispose();
    _productModelController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final api = ref.read(apiClientProvider).getProductsApi();

      // 1. Create Group
      final groupReq = ApiProductsGroupsPostRequest((b) => b..name = _groupController.text.trim());
      final groupRes = await api.apiProductsGroupsPost(apiProductsGroupsPostRequest: groupReq);
      final groupData = (groupRes as dynamic).data['data'];
      final groupId = groupData['id'] as int;

      // 2. Create Category
      final catReq = ApiProductsCategoriesPostRequest((b) => b
        ..groupId = groupId
        ..name = _categoryController.text.trim());
      final catRes = await api.apiProductsCategoriesPost(apiProductsCategoriesPostRequest: catReq);
      final catData = (catRes as dynamic).data['data'];
      final categoryId = catData['id'] as int;

      // 3. Create Product Name
      final nameReq = ApiProductsProductNamesPostRequest((b) => b
        ..categoryId = categoryId
        ..name = _productNameController.text.trim());
      final nameRes = await api.apiProductsProductNamesPost(apiProductsProductNamesPostRequest: nameReq);
      final nameData = (nameRes as dynamic).data['data'];
      final productNameId = nameData['id'] as int;

      // 4. Create Product Model
      final modelReq = ApiProductsProductModelsPostRequest((b) => b
        ..productNameId = productNameId
        ..name = _productModelController.text.trim());
      await api.apiProductsProductModelsPost(apiProductsProductModelsPostRequest: modelReq);

      if (mounted) {
        context.showSuccessSnackBar('Complete hierarchy created successfully');
        context.pop();
      }
    } catch (e) {
      // Handled by interceptor, or we can show specific error if we cast to DioException
      // For now we'll just stop loading
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Complete Hierarchy'),
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
                      const Text(
                        'Create a complete product hierarchy from scratch.',
                        style: TextStyle(color: Color(0xFF3E4A3D)),
                      ),
                      const SizedBox(height: 24),
                      
                      _buildTextField('Group Name', _groupController),
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
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Text('Create Hierarchy'),
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
            if (value == null || value.trim().isEmpty) {
              return '$label is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
