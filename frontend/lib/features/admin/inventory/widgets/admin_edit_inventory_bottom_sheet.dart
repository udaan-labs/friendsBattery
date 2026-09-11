import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/state/data_sync.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../shared/inventory/providers/inventory_provider.dart';
import '../../../shared/inventory/repository/shared_inventory_repository.dart';

class AdminEditInventoryBottomSheet extends ConsumerStatefulWidget {
  final SharedInventoryItemModel item;

  const AdminEditInventoryBottomSheet({
    super.key,
    required this.item,
  });

  @override
  ConsumerState<AdminEditInventoryBottomSheet> createState() => _AdminEditInventoryBottomSheetState();
}

class _AdminEditInventoryBottomSheetState extends ConsumerState<AdminEditInventoryBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _minPriceController = TextEditingController();
  final _minAdminQuantityController = TextEditingController();
  final _minSellerQuantityController = TextEditingController();
  bool _onSale = false;
  bool _isSubmitting = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _minPriceController.text = widget.item.minPrice.toStringAsFixed(0);
    _minAdminQuantityController.text = widget.item.minUnitCountAdmin.toString();
    _minSellerQuantityController.text = widget.item.minUnitCountSeller.toString();
    _onSale = widget.item.onSale;
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _minAdminQuantityController.dispose();
    _minSellerQuantityController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final repo = ref.read(sharedInventoryRepositoryProvider);
      final minPrice = num.tryParse(_minPriceController.text);
      final minAdminQty = int.tryParse(_minAdminQuantityController.text);
      final minSellerQty = int.tryParse(_minSellerQuantityController.text);

      if (minPrice != null ||
          minAdminQty != null ||
          minSellerQty != null ||
          _onSale != widget.item.onSale) {
        await repo.updateStock(
          productNameId: widget.item.productNameId,
          productModelId: widget.item.productModelId,
          minSellPrice: minPrice,
          minUnitCountAdmin: minAdminQty,
          minUnitCountSeller: minSellerQty,
          onSale: _onSale,
        );
      }

      if (!mounted) return;
      context.showSuccessSnackBar('Stock updated successfully!');
      DataSync.afterInventoryMutation(ref, productId: widget.item.productId);
      Navigator.of(context).pop();
    } on DioException catch (e) {
      if (mounted) {
        final msg = e.response?.data?['message'] ?? 'Failed to update stock';
        context.showErrorSnackBar(msg);
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar('An error occurred: $e');
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _confirmRemoveSerial(String serial) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Serial Number'),
        content: Text('Are you sure you want to remove unit "$serial" from inventory?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFFBA1A1A)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (ok != true || !mounted) return;
    try {
      await ref.read(sharedInventoryRepositoryProvider).removeSerialUnit(serial);
      DataSync.afterInventoryMutation(ref, productId: widget.item.productId);
      if (!mounted) return;
      context.showSuccessSnackBar('Serial number $serial removed');
    } catch (e) {
      if (!mounted) return;
      context.showErrorSnackBar('Failed to remove unit: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quick Edit Inventory',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF191C1E),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.inventory_2, color: Color(0xFF545F73)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.productModel,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          '${widget.item.productName} • ${widget.item.quantity} in stock',
                          style: const TextStyle(color: Color(0xFF545F73), fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      context.push('/shared/inventory/${widget.item.productId}');
                    },
                    icon: const Icon(Icons.open_in_new_rounded, size: 16),
                    label: const Text('Details'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Available Serial Numbers',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            ref
                .watch(
                  sharedInventoryProductDetailProvider(
                    (productId: widget.item.productId, locationId: null),
                  ),
                )
                .when(
                  data: (detail) {
                    if (detail.serialNumbers.isEmpty) {
                      return const Text(
                        'No serial numbers available.',
                        style: TextStyle(color: Color(0xFF545F73), fontSize: 13),
                      );
                    }
                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: detail.serialNumbers.map((serial) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.qr_code, size: 14, color: Color(0xFF545F73)),
                              const SizedBox(width: 6),
                              Text(
                                serial,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 4),
                              InkWell(
                                onTap: () => _confirmRemoveSerial(serial),
                                borderRadius: BorderRadius.circular(8),
                                child: const Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Icon(Icons.close_rounded, size: 16, color: Color(0xFFBA1A1A)),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const SizedBox(
                    height: 24,
                    child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  ),
                  error: (_, __) => const SizedBox.shrink(),
                ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ponytail: qty remove disabled — scrap via serial chips only (C4/B10)
                  const Text(
                    'Minimum Sell Price',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _minPriceController,
                    keyboardType: TextInputType.number,
                    enabled: _isEditing,
                    decoration: InputDecoration(
                      hintText: 'Update minimum price',
                      prefixText: '₹ ',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Price cannot be empty';
                      }
                      final val = num.tryParse(value);
                      if (val == null || val < 0) return 'Enter a valid price';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Minimum Admin Quantity',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _minAdminQuantityController,
                    keyboardType: TextInputType.number,
                    enabled: _isEditing,
                    decoration: InputDecoration(
                      hintText: 'Enter minimum alert threshold',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final val = int.tryParse(value);
                        if (val == null || val < 0) return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Minimum Seller Quantity',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _minSellerQuantityController,
                    keyboardType: TextInputType.number,
                    enabled: _isEditing,
                    decoration: InputDecoration(
                      hintText: 'Enter minimum alert threshold for sellers',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final val = int.tryParse(value);
                        if (val == null || val < 0) return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Is On Sale',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      Switch(
                        value: _onSale,
                        onChanged: _isEditing ? (val) => setState(() => _onSale = val) : null,
                        activeTrackColor: const Color(0xFF006B2C),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isEditing 
                          ? (_isSubmitting ? null : _submit)
                          : () => setState(() => _isEditing = true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isEditing ? const Color(0xFF006B2C) : const Color(0xFF191C1E),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              _isEditing ? 'Update Inventory' : 'Edit Inventory',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
