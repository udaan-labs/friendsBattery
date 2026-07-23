import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../shared/widgets/responsive_helper.dart';
import '../../../../../core/state/data_sync.dart';
import '../../../../../shared/widgets/snackbar_helper.dart';
import '../../../../shared/products/providers/product_catalog_providers.dart';

class AddProductNameForm extends ConsumerStatefulWidget {
  const AddProductNameForm({super.key});

  @override
  ConsumerState<AddProductNameForm> createState() => _AddProductNameFormState();
}

class _AddProductNameFormState extends ConsumerState<AddProductNameForm> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productModelController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _productNameController.dispose();
    _productModelController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final repo = ref.read(productCatalogRepositoryProvider);
      final productNameId = await repo.createProductName(
        _productNameController.text.trim(),
      );
      await repo.createProductModel(
        productNameId: productNameId,
        name: _productModelController.text.trim(),
      );

      if (mounted) {
        context.showSuccessSnackBar('Product Name and Model created successfully');
        DataSync.afterProductMutation(ref);
        context.pop();
      }
    } on DioException catch (e) {
      if (mounted) {
        final msg = e.response?.data?['message'] ?? 'Failed to create product name';
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
        title: const Text('Add Product Name'),
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
                        'Enter a new product name and its first model.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF3E4A3D)),
                      ),
                      const SizedBox(height: 24),
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
