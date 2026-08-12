import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../shared/widgets/responsive_helper.dart';
import '../../../../../core/state/data_sync.dart';
import '../../../../../shared/widgets/snackbar_helper.dart';
import '../../../../shared/products/providers/product_catalog_providers.dart';

class CreateProductForm extends ConsumerStatefulWidget {
  /// Pre-select name/model when arriving from Add Name / Add Model.
  final String? initialProductNameId;
  final String? initialProductModelId;

  const CreateProductForm({
    super.key,
    this.initialProductNameId,
    this.initialProductModelId,
  });

  @override
  ConsumerState<CreateProductForm> createState() => _CreateProductFormState();
}

class _CreateProductFormState extends ConsumerState<CreateProductForm> {
  final _formKey = GlobalKey<FormState>();

  final _minPriceController = TextEditingController();
  final _offerPriceController = TextEditingController();
  final _minUnitAdminController = TextEditingController();
  final _minUnitSellerController = TextEditingController();

  bool _isSubmitting = false;

  String? _selectedProductNameId;
  String? _selectedProductModelId;

  bool _onSale = false;

  @override
  void initState() {
    super.initState();
    _selectedProductNameId = widget.initialProductNameId;
    _selectedProductModelId = widget.initialProductModelId;
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _offerPriceController.dispose();
    _minUnitAdminController.dispose();
    _minUnitSellerController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;
    if (_selectedProductNameId == null || _selectedProductModelId == null) {
      context.showErrorSnackBar('Please select Product Name and Product Model');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final minPrice = _minPriceController.text.isNotEmpty ? num.parse(_minPriceController.text) : 0;
      final offerPrice = _offerPriceController.text.isNotEmpty ? num.parse(_offerPriceController.text) : null;
      final minUnitCountAdmin = _minUnitAdminController.text.isNotEmpty ? int.parse(_minUnitAdminController.text) : 0;
      final minUnitCountSeller = _minUnitSellerController.text.isNotEmpty ? int.parse(_minUnitSellerController.text) : 0;

      await ref.read(productCatalogRepositoryProvider).createProduct(
            productNameId: int.parse(_selectedProductNameId!),
            productModelId: int.parse(_selectedProductModelId!),
            minPrice: minPrice,
            onSale: _onSale,
            offerPrice: offerPrice,
            minUnitCountAdmin: minUnitCountAdmin,
            minUnitCountSeller: minUnitCountSeller,
          );

      if (mounted) {
        context.showSuccessSnackBar('Product configured successfully');
        await DataSync.afterProductMutation(ref);
        if (mounted) context.pop(true);
      }
    } on DioException catch (e) {
      if (mounted) {
        final msg = e.response?.data?['message'] ?? 'Failed to create product';
        context.showErrorSnackBar(msg);
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final namesAsync = ref.watch(productNamesProvider);
    final selectedNameId = int.tryParse(_selectedProductNameId ?? '');
    final modelsAsync = selectedNameId == null
        ? null
        : ref.watch(productModelsProvider(selectedNameId));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Configure Product Pricing & Units'),
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
                                value: productNames.any((n) => n.id == _selectedProductNameId)
                                    ? _selectedProductNameId
                                    : null,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                hint: const Text('Select Existing Product Name'),
                                items: productNames
                                    .map((n) => DropdownMenuItem(value: n.id, child: Text(n.name)))
                                    .toList(),
                                onChanged: (id) {
                                  setState(() {
                                    _selectedProductNameId = id;
                                    _selectedProductModelId = null;
                                  });
                                },
                              ),
                      ),
                      const SizedBox(height: 16),

                      const Text('Product Model', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E))),
                      const SizedBox(height: 8),
                      if (_selectedProductNameId == null)
                        TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            hintText: 'Select Product Name first',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                          ),
                        )
                      else if (modelsAsync == null)
                        const SizedBox.shrink()
                      else
                        modelsAsync.when(
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
                            onPressed: () {
                              final id = int.tryParse(_selectedProductNameId ?? '');
                              if (id != null) ref.invalidate(productModelsProvider(id));
                            },
                            child: const Text('Failed to load models. Retry'),
                          ),
                          data: (productModels) => productModels.isEmpty
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
                                  value: productModels.any((m) => m.id == _selectedProductModelId)
                                      ? _selectedProductModelId
                                      : null,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  hint: const Text('Select Existing Product Model'),
                                  items: productModels
                                      .map((m) => DropdownMenuItem(value: m.id, child: Text(m.name)))
                                      .toList(),
                                  onChanged: (id) => setState(() => _selectedProductModelId = id),
                                ),
                        ),
                      const SizedBox(height: 32),

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
                        onChanged: (val) => setState(() => _onSale = val ?? false),
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
                            if (value != null && value.trim().isNotEmpty && num.tryParse(value) == null) {
                              return 'Must be a valid number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                      ],

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
      ),
    );
  }
}
