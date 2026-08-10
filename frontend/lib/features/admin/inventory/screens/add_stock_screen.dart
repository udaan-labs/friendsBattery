import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../core/state/data_sync.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../shared/inventory/providers/inventory_provider.dart';
import '../../../shared/products/providers/product_catalog_providers.dart';
import '../../locations/providers/locations_providers.dart';

class AddStockScreen extends ConsumerStatefulWidget {
  const AddStockScreen({super.key});

  @override
  ConsumerState<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends ConsumerState<AddStockScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _minPriceController = TextEditingController();

  bool _isSubmitting = false;

  String? _selectedProductNameId;
  String? _selectedProductModelId;
  /// Target warehouse for new units (null → API default WH / actor location).
  int? _selectedWarehouseId;

  @override
  void dispose() {
    _quantityController.dispose();
    _minPriceController.dispose();
    super.dispose();
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

    setState(() => _isSubmitting = true);

    try {
      final repo = ref.read(sharedInventoryRepositoryProvider);
      final minPrice = _minPriceController.text.isNotEmpty
          ? num.parse(_minPriceController.text)
          : null;

      final isSuperAdmin =
          ref.read(authProvider).role == UserRole.superAdmin;
      await repo.updateStock(
        productNameId: int.parse(_selectedProductNameId!),
        productModelId: int.parse(_selectedProductModelId!),
        quantity: quantity,
        minSellPrice: minPrice,
        // Shop Admin: omit — backend forces own shop location
        locationId: isSuperAdmin ? _selectedWarehouseId : null,
      );

      if (mounted) {
        context.showSuccessSnackBar('Stock updated successfully');
        DataSync.afterInventoryMutation(ref);
        final nameId = int.tryParse(_selectedProductNameId ?? '');
        final modelId = int.tryParse(_selectedProductModelId ?? '');
        if (nameId != null && modelId != null) {
          ref.invalidate(productStockDetailsProvider((nameId: nameId, modelId: modelId)));
        }
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
    final isSuperAdmin = ref.watch(authProvider).role == UserRole.superAdmin;
    final namesAsync = ref.watch(productNamesProvider);
    final warehousesAsync = isSuperAdmin
        ? ref.watch(locationsByTypeProvider('WAREHOUSE'))
        : null;
    final selectedNameId = int.tryParse(_selectedProductNameId ?? '');
    final modelsAsync = selectedNameId == null
        ? null
        : ref.watch(productModelsProvider(selectedNameId));

    final selectedModelId = int.tryParse(_selectedProductModelId ?? '');
    final detailsAsync = (selectedNameId != null && selectedModelId != null)
        ? ref.watch(productStockDetailsProvider((nameId: selectedNameId, modelId: selectedModelId)))
        : null;

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
                          const Text(
                            'Product Name',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                          ),
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
                                    hint: const Text('Select Product Name'),
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
                          const SizedBox(height: 20),

                          const Text(
                            'Product Model',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                          ),
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
                          else if (modelsAsync != null)
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
                                      value: _selectedProductModelId,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      hint: const Text('Select Product Model'),
                                      items: productModels
                                          .map((m) => DropdownMenuItem(value: m.id, child: Text(m.name)))
                                          .toList(),
                                      onChanged: (id) => setState(() => _selectedProductModelId = id),
                                    ),
                            ),
                          const SizedBox(height: 20),

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
                                  if (detailsAsync == null)
                                    const SizedBox.shrink()
                                  else
                                    detailsAsync.when(
                                      loading: () => const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                      error: (_, __) => const Text(
                                        'Could not load current stock details',
                                        style: TextStyle(fontSize: 13, color: Color(0xFF3E4A3D)),
                                      ),
                                      data: (details) => Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Current Stock: ${details.stock}',
                                            style: const TextStyle(fontSize: 13, color: Color(0xFF3E4A3D)),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Current Min Price: ₹${details.minPrice}',
                                            style: const TextStyle(fontSize: 13, color: Color(0xFF3E4A3D)),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],

                          // Super Admin: pick any warehouse. Shop Admin: API uses own shop.
                          if (isSuperAdmin && warehousesAsync != null) ...[
                            const Text(
                              'Warehouse',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                            ),
                            const SizedBox(height: 8),
                            warehousesAsync.when(
                              loading: () => const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Center(
                                  child: SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                ),
                              ),
                              error: (_, __) => TextButton(
                                onPressed: () =>
                                    ref.invalidate(locationsByTypeProvider('WAREHOUSE')),
                                child: const Text('Failed to load warehouses. Retry'),
                              ),
                              data: (warehouses) {
                                if (warehouses.isEmpty) {
                                  return TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      hintText:
                                          'No warehouses yet — default WH used if configured',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                    ),
                                  );
                                }
                                // Auto-select single warehouse once
                                if (_selectedWarehouseId == null &&
                                    warehouses.length == 1 &&
                                    warehouses.first.id != null) {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    if (mounted && _selectedWarehouseId == null) {
                                      setState(() =>
                                          _selectedWarehouseId = warehouses.first.id);
                                    }
                                  });
                                }
                                return DropdownButtonFormField<int>(
                                  isExpanded: true,
                                  value: _selectedWarehouseId != null &&
                                          warehouses.any((w) => w.id == _selectedWarehouseId)
                                      ? _selectedWarehouseId
                                      : null,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  hint: const Text('Select warehouse'),
                                  items: warehouses
                                      .where((w) => w.id != null)
                                      .map(
                                        (w) => DropdownMenuItem(
                                          value: w.id,
                                          child: Text(
                                            '${w.name ?? w.code ?? 'WH'} (${w.code ?? w.id})',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (id) =>
                                      setState(() => _selectedWarehouseId = id),
                                  validator: (value) {
                                    if (warehouses.isNotEmpty && value == null) {
                                      return 'Please select a warehouse';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                          ],

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
