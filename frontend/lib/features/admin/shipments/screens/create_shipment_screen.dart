import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../theme/app_theme.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../core/network/api_client_provider.dart';
import '../providers/shipment_provider.dart';
import '../repository/shipment_repository.dart';
import '../../dashboard/providers/dashboard_controller.dart';
import '../../../../shared/widgets/snackbar_helper.dart';

class TransferRowState {
  String? categoryId;
  String? productNameId;
  String? productModelId;
  int? productId; // resolved actual product database ID
  int? availableStock;

  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  bool isLoadingNames = false;
  bool isLoadingModels = false;
  bool isLoadingDetails = false;

  List<Map<String, String>> productNames = [];
  List<Map<String, String>> productModels = [];

  TransferRowState() {
    quantityController.text = '';
    priceController.text = '';
  }

  void dispose() {
    quantityController.dispose();
    priceController.dispose();
  }
}

class CreateShipmentScreen extends ConsumerStatefulWidget {
  const CreateShipmentScreen({super.key});

  @override
  ConsumerState<CreateShipmentScreen> createState() => _CreateShipmentScreenState();
}

class _CreateShipmentScreenState extends ConsumerState<CreateShipmentScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoadingSellers = false;
  bool _isLoadingCategories = false;
  bool _isSubmitting = false;

  List<SellerModel> _sellers = [];
  List<Map<String, String>> _categories = [];

  int? _selectedSellerId;
  DateTime? _dispatchDate;
  DateTime? _expectedArrivalDate;

  final List<TransferRowState> _rows = [];

  @override
  void initState() {
    super.initState();
    _dispatchDate = DateTime.now(); // default to today
    _addRow();
    _loadInitialData();
  }

  @override
  void dispose() {
    for (final row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

  void _addRow() {
    setState(() {
      _rows.add(TransferRowState());
    });
  }

  void _removeRow(int index) {
    if (_rows.length <= 1) return;
    setState(() {
      final removed = _rows.removeAt(index);
      removed.dispose();
    });
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoadingSellers = true;
      _isLoadingCategories = true;
    });

    try {
      final repo = ref.read(shipmentRepositoryProvider);
      final sellersList = await repo.getSellers();

      final api = ref.read(apiClientProvider).getProductsApi();
      final response = await api.apiProductsCategoriesGet();
      final catData = (response as dynamic).data;

      List<Map<String, String>> categoriesList = [];
      if (catData is Map<String, dynamic> && catData['data'] is List) {
        final list = catData['data'] as List;
        categoriesList = list.map((item) {
          return {
            'id': item['id'].toString(),
            'name': item['name'].toString(),
          };
        }).toList();
      }

      setState(() {
        _sellers = sellersList;
        _categories = categoriesList;
      });
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      setState(() {
        _isLoadingSellers = false;
        _isLoadingCategories = false;
      });
    }
  }

  Future<void> _loadProductNames(int rowIndex, String categoryId) async {
    final row = _rows[rowIndex];
    setState(() {
      row.isLoadingNames = true;
      row.productNames = [];
      row.productNameId = null;
      row.productModels = [];
      row.productModelId = null;
      row.productId = null;
      row.availableStock = null;
    });

    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final request = ApiProductsProductNamesListPostRequest((b) => b..categoryId = int.parse(categoryId));
      final response = await api.apiProductsProductNamesListPost(
        apiProductsProductNamesListPostRequest: request,
      );
      final data = (response as dynamic).data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        final list = data['data'] as List;
        setState(() {
          row.productNames = list.map((item) {
            return {
              'id': item['id'].toString(),
              'name': item['name'].toString(),
            };
          }).toList();
        });
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      setState(() {
        row.isLoadingNames = false;
      });
    }
  }

  Future<void> _loadProductModels(int rowIndex, String productNameId) async {
    final row = _rows[rowIndex];
    setState(() {
      row.isLoadingModels = true;
      row.productModels = [];
      row.productModelId = null;
      row.productId = null;
      row.availableStock = null;
    });

    try {
      final api = ref.read(apiClientProvider).getProductsApi();
      final request = ApiProductsProductModelsListPostRequest((b) => b
        ..categoryId = int.parse(row.categoryId!)
        ..productNameId = int.parse(productNameId));
      final response = await api.apiProductsProductModelsListPost(
        apiProductsProductModelsListPostRequest: request,
      );
      final data = (response as dynamic).data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        final list = data['data'] as List;
        setState(() {
          row.productModels = list.map((item) {
            return {
              'id': item['id'].toString(),
              'name': item['name'].toString(),
            };
          }).toList();
        });
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      setState(() {
        row.isLoadingModels = false;
      });
    }
  }

  Future<void> _loadProductDetails(int rowIndex, String productModelId) async {
    final row = _rows[rowIndex];
    setState(() {
      row.isLoadingDetails = true;
      row.availableStock = null;
      row.productId = null;
    });

    try {
      final inventoryApi = ref.read(apiClientProvider).getInventoryApi();
      final productsApi = ref.read(apiClientProvider).getProductsApi();

      // Fetch stock detail
      final detailsResponse = await inventoryApi.apiInventoryProductDetailsGet(
        categoryId: row.categoryId!,
        productNameId: row.productNameId!,
        productModelId: productModelId,
      );

      // Fetch exact product ID
      final productsResponse = await productsApi.apiProductsListPost(
        apiProductsListPostRequest: ApiProductsListPostRequest((b) => b
          ..categoryId = int.parse(row.categoryId!)
          ..productNameId = int.parse(row.productNameId!)
          ..productModelId = int.parse(productModelId)),
      );

      final details = detailsResponse.data?.data;
      final productsData = (productsResponse as dynamic).data;

      int? resolvedProdId;
      if (productsData is Map<String, dynamic> && productsData['data'] is List) {
        final list = productsData['data'] as List;
        if (list.isNotEmpty) {
          resolvedProdId = list.first['id'] as int;
        }
      }

      setState(() {
        row.availableStock = details?.currentStock ?? 0;
        row.productId = resolvedProdId;
      });
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      setState(() {
        row.isLoadingDetails = false;
      });
    }
  }

  Future<void> _selectDispatchDate(BuildContext context) async {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dispatchDate ?? todayStart,
      firstDate: todayStart,
      lastDate: todayStart.add(const Duration(days: 365)),
    );

    if (picked != null && picked != _dispatchDate) {
      setState(() {
        _dispatchDate = picked;
        if (_expectedArrivalDate != null && _expectedArrivalDate!.isBefore(picked)) {
          _expectedArrivalDate = null;
        }
      });
    }
  }

  Future<void> _selectArrivalDate(BuildContext context) async {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final minDate = _dispatchDate ?? todayStart;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _expectedArrivalDate ?? minDate,
      firstDate: minDate,
      lastDate: minDate.add(const Duration(days: 365)),
    );

    if (picked != null && picked != _expectedArrivalDate) {
      setState(() {
        _expectedArrivalDate = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedSellerId == null) {
      context.showErrorSnackBar('Seller is required');
      return;
    }
    if (_dispatchDate == null) {
      context.showErrorSnackBar('Dispatch Date is required');
      return;
    }
    if (_expectedArrivalDate == null) {
      context.showErrorSnackBar('Expected Arrival Date is required');
      return;
    }

    // Product duplicate check
    final productIds = <int>{};
    final List<Map<String, dynamic>> itemsPayload = [];

    for (int i = 0; i < _rows.length; i++) {
      final row = _rows[i];
      if (row.productId == null) {
        context.showErrorSnackBar('Please complete product selection on row ${i + 1}');
        return;
      }

      if (productIds.contains(row.productId!)) {
        context.showErrorSnackBar('Duplicate products are not allowed in the same shipment');
        return;
      }
      productIds.add(row.productId!);

      final quantity = int.tryParse(row.quantityController.text) ?? 0;
      final price = double.tryParse(row.priceController.text) ?? 0.0;

      if (quantity <= 0) {
        context.showErrorSnackBar('Quantity must be greater than zero on row ${i + 1}');
        return;
      }

      if (row.availableStock != null && quantity > row.availableStock!) {
        context.showErrorSnackBar('Quantity exceeds available stock on row ${i + 1}');
        return;
      }

      if (price <= 0) {
        context.showErrorSnackBar('Price must be greater than zero on row ${i + 1}');
        return;
      }

      itemsPayload.add({
        'product_id': row.productId!,
        'quantity': quantity,
        'price_per_piece': price,
      });
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final repo = ref.read(shipmentRepositoryProvider);
      await repo.createShipment(
        sellerId: _selectedSellerId!,
        items: itemsPayload,
      );

      if (mounted) {
        context.showSuccessSnackBar('Shipment created successfully');

        // Refresh list provider and dashboard data
        ref.invalidate(shipmentsListProvider);
        ref.read(dashboardControllerProvider).refreshAllData();

        // Navigate back to shipment list
        context.pop();
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Create Shipment / Transfer'),
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Seller & Dates Card
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Recipient Seller / Shop',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                      ),
                      const SizedBox(height: 8),
                      _isLoadingSellers
                          ? const Center(child: CircularProgressIndicator())
                          : DropdownMenu<int>(
                              expandedInsets: EdgeInsets.zero,
                              enableFilter: true,
                              hintText: 'Search & Select Seller',
                              requestFocusOnTap: true,
                              dropdownMenuEntries: _sellers.map((seller) {
                                return DropdownMenuEntry<int>(
                                  value: seller.id,
                                  label: '${seller.shopName} (${seller.userName})',
                                );
                              }).toList(),
                              onSelected: (id) {
                                setState(() {
                                  _selectedSellerId = id;
                                });
                              },
                            ),
                      const SizedBox(height: 20),

                      // Dates Row
                      Builder(
                        builder: (context) {
                          final isNarrow = MediaQuery.of(context).size.width < 440;
                          final datesContent = [
                            // Dispatch Date
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Dispatch Date',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                                ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: () => _selectDispatchDate(context),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[400]!),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _dispatchDate == null ? 'Select Date' : dateFormat.format(_dispatchDate!),
                                          style: const TextStyle(fontSize: 14, color: Color(0xFF191C1E)),
                                        ),
                                        const Icon(Icons.calendar_today, size: 18, color: Color(0xFF586377)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (isNarrow) const SizedBox(height: 16) else const SizedBox(width: 16),
                            // Expected Arrival Date
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Expected Arrival Date',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                                ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: () => _selectArrivalDate(context),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey[400]!),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _expectedArrivalDate == null ? 'Select Date' : dateFormat.format(_expectedArrivalDate!),
                                          style: const TextStyle(fontSize: 14, color: Color(0xFF191C1E)),
                                        ),
                                        const Icon(Icons.calendar_today, size: 18, color: Color(0xFF586377)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ];

                          return isNarrow
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: datesContent,
                                )
                              : Row(
                                  children: [
                                    Expanded(child: datesContent[0]),
                                    const SizedBox(width: 16),
                                    Expanded(child: datesContent[2]),
                                  ],
                                );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Transfer Items Section Title
                const Text(
                  'Transfer Items',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
                ),
                const SizedBox(height: 12),

                // Dynamic Transfer Items Rows
                ...List.generate(_rows.length, (index) {
                  final row = _rows[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppTheme.background,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x05000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Product Row #${index + 1}',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF006B2C)),
                            ),
                            if (_rows.length > 1)
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: AppTheme.error),
                                onPressed: () => _removeRow(index),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Category Dropdown
                        const Text(
                          'Category',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                        ),
                        const SizedBox(height: 6),
                        _isLoadingCategories
                            ? const Center(child: CircularProgressIndicator())
                            : DropdownMenu<String>(
                                expandedInsets: EdgeInsets.zero,
                                enableFilter: true,
                                hintText: 'Select Category',
                                requestFocusOnTap: true,
                                dropdownMenuEntries: _categories.map((cat) {
                                  return DropdownMenuEntry<String>(
                                    value: cat['id']!,
                                    label: cat['name']!,
                                  );
                                }).toList(),
                                onSelected: (id) {
                                  if (id != null) {
                                    setState(() {
                                      row.categoryId = id;
                                    });
                                    _loadProductNames(index, id);
                                  }
                                },
                              ),
                        const SizedBox(height: 16),

                        // Product Name Dropdown
                        const Text(
                          'Product Name',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                        ),
                        const SizedBox(height: 6),
                        row.isLoadingNames
                            ? const Center(child: CircularProgressIndicator())
                            : DropdownMenu<String>(
                                key: ValueKey('name_${index}_${row.categoryId}'),
                                expandedInsets: EdgeInsets.zero,
                                enableFilter: true,
                                enabled: row.categoryId != null,
                                hintText: 'Select Product Name',
                                requestFocusOnTap: true,
                                dropdownMenuEntries: row.productNames.map((name) {
                                  return DropdownMenuEntry<String>(
                                    value: name['id']!,
                                    label: name['name']!,
                                  );
                                }).toList(),
                                onSelected: (id) {
                                  if (id != null) {
                                    setState(() {
                                      row.productNameId = id;
                                    });
                                    _loadProductModels(index, id);
                                  }
                                },
                              ),
                        const SizedBox(height: 16),

                        // Product Model Dropdown
                        const Text(
                          'Product Model',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                        ),
                        const SizedBox(height: 6),
                        row.isLoadingModels
                            ? const Center(child: CircularProgressIndicator())
                            : DropdownMenu<String>(
                                key: ValueKey('model_${index}_${row.productNameId}'),
                                expandedInsets: EdgeInsets.zero,
                                enableFilter: true,
                                enabled: row.productNameId != null,
                                hintText: 'Select Product Model',
                                requestFocusOnTap: true,
                                dropdownMenuEntries: row.productModels.map((model) {
                                  return DropdownMenuEntry<String>(
                                    value: model['id']!,
                                    label: model['name']!,
                                  );
                                }).toList(),
                                onSelected: (id) {
                                  if (id != null) {
                                    setState(() {
                                      row.productModelId = id;
                                    });
                                    _loadProductDetails(index, id);
                                  }
                                },
                              ),
                        const SizedBox(height: 16),

                        // Info Box (Stock Detail)
                        if (row.productModelId != null) ...[
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFECEEF0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: row.isLoadingDetails
                                ? const SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : Text(
                                    'Available Stock: ${row.availableStock ?? 0}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF3E4A3D),
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Quantity & Price
                        Row(
                          children: [
                            // Quantity
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Quantity',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                                  ),
                                  const SizedBox(height: 6),
                                  TextFormField(
                                    controller: row.quantityController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Qty',
                                    ),
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) {
                                        return 'Required';
                                      }
                                      final parsed = int.tryParse(val);
                                      if (parsed == null || parsed <= 0) {
                                        return '> 0';
                                      }
                                      if (row.availableStock != null && parsed > row.availableStock!) {
                                        return 'Exceeds stock';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Price Per Piece
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Price per Piece',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                                  ),
                                  const SizedBox(height: 6),
                                  TextFormField(
                                    controller: row.priceController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Price',
                                      prefixText: '₹ ',
                                    ),
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) {
                                        return 'Required';
                                      }
                                      final parsed = double.tryParse(val);
                                      if (parsed == null || parsed <= 0) {
                                        return '> 0';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),

                // Add Another Product Button
                OutlinedButton.icon(
                  onPressed: _addRow,
                  icon: const Icon(Icons.add),
                  label: const Text('+ Add Another Product'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: Color(0xFF006B2C)),
                    foregroundColor: const Color(0xFF006B2C),
                  ),
                ),
                const SizedBox(height: 32),

                // Submit Button
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006B2C),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                          'Create Shipment & Transfer Stock',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
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
