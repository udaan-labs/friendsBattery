import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import '../../../../../shared/widgets/responsive_helper.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../shared/widgets/snackbar_helper.dart';

class AddProductModelForm extends ConsumerStatefulWidget {
  const AddProductModelForm({super.key});

  @override
  ConsumerState<AddProductModelForm> createState() => _AddProductModelFormState();
}

class _AddProductModelFormState extends ConsumerState<AddProductModelForm> {
  final _formKey = GlobalKey<FormState>();
  final _productModelController = TextEditingController();

  bool _isLoadingNames = false;
  bool _isSubmitting = false;

  List<Map<String, String>> _productNames = [];
  String? _selectedProductNameId;

  @override
  void initState() {
    super.initState();
    _loadProductNames();
  }

  @override
  void dispose() {
    _productModelController.dispose();
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
      // Error handled by interceptor
    } finally {
      if (mounted) setState(() => _isLoadingNames = false);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedProductNameId == null) {
      context.showErrorSnackBar('Please select a Product Name');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final dio = ApiClient().dio;
      await dio.post('/api/products/product-models', data: {
        'product_name_id': int.parse(_selectedProductNameId!),
        'name': _productModelController.text.trim(),
      });

      if (mounted) {
        context.showSuccessSnackBar('Product Model created successfully');
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
                      _isLoadingNames
                          ? const Center(child: CircularProgressIndicator())
                          : DropdownMenu<String>(
                              expandedInsets: EdgeInsets.zero,
                              enableFilter: true,
                              hintText: 'Select Existing Product Name',
                              dropdownMenuEntries: _productNames.map((n) => DropdownMenuEntry(value: n['id']!, label: n['name']!)).toList(),
                              onSelected: (id) => setState(() => _selectedProductNameId = id),
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
