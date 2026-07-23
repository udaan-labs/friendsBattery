import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../shared/widgets/responsive_helper.dart';
import '../../../../../core/state/data_sync.dart';
import '../../../../../shared/widgets/snackbar_helper.dart';
import '../../../../shared/products/providers/product_catalog_providers.dart';

class AddProductModelForm extends ConsumerStatefulWidget {
  const AddProductModelForm({super.key});

  @override
  ConsumerState<AddProductModelForm> createState() => _AddProductModelFormState();
}

class _AddProductModelFormState extends ConsumerState<AddProductModelForm> {
  final _formKey = GlobalKey<FormState>();
  final _productModelController = TextEditingController();

  bool _isSubmitting = false;
  String? _selectedProductNameId;

  @override
  void dispose() {
    _productModelController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedProductNameId == null) {
      context.showErrorSnackBar('Please select a Product Name');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await ref.read(productCatalogRepositoryProvider).createProductModel(
            productNameId: int.parse(_selectedProductNameId!),
            name: _productModelController.text.trim(),
          );

      if (mounted) {
        context.showSuccessSnackBar('Product Model created successfully');
        DataSync.afterProductMutation(ref);
        context.pop();
      }
    } on DioException catch (e) {
      if (mounted) {
        final msg = e.response?.data?['message'] ?? 'Failed to create product model';
        context.showErrorSnackBar(msg);
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final namesAsync = ref.watch(productNamesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Add Product Model'),
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
                      const Text('Product Name', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E))),
                      const SizedBox(height: 8),
                      namesAsync.when(
                        loading: () => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        ),
                        error: (_, __) => TextButton(
                          onPressed: () => ref.invalidate(productNamesProvider),
                          child: const Text('Failed to load product names. Retry'),
                        ),
                        data: (productNames) => productNames.isEmpty
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
                                value: _selectedProductNameId,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                hint: const Text('Select Existing Product Name'),
                                items: productNames.map((n) {
                                  return DropdownMenuItem<String>(
                                    value: n.id,
                                    child: Text(n.name),
                                  );
                                }).toList(),
                                onChanged: (id) => setState(() => _selectedProductNameId = id),
                              ),
                      ),
                      const SizedBox(height: 16),

                      _buildTextField('Product Model Name', _productModelController),
                      const SizedBox(height: 32),

                      ElevatedButton(
                        onPressed: _isSubmitting ? null : _submit,
                        child: _isSubmitting
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('Save Product Model'),
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
