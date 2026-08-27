import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../theme/app_theme.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../providers/shipment_provider.dart';
import '../repository/shipment_repository.dart';
import '../../../../shared/widgets/serial_scan_field.dart';
import '../../../../core/state/data_sync.dart';
import '../../../../shared/widgets/snackbar_helper.dart';

class TransferRowState {
  String? productNameId;
  String? productModelId;
  int? productId; // resolved actual product database ID
  int? availableStock;
  List<String> availableSerials = [];
  bool isLoadingSerials = false;

  final priceController = TextEditingController();
  final manualSerialController = TextEditingController();
  List<String> scannedSerials = [];

  List<Map<String, String>> productModels = [];

  TransferRowState() {
    priceController.text = '';
  }

  void dispose() {
    priceController.dispose();
    manualSerialController.dispose();
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
  bool _isLoadingNames = false;
  bool _isSubmitting = false;

  List<SellerModel> _sellers = [];
  List<InventoryProductNameGroup> _inventoryProducts = [];
  List<Map<String, String>> _productNames = [];

  int? _selectedSellerId;
  DateTime? _dispatchDate;
  DateTime? _expectedArrivalDate;

  final List<TransferRowState> _rows = [];
  int _expandedRow = 0;

  @override
  void initState() {
    super.initState();
    _dispatchDate = DateTime.now(); // default to today
    _addRow();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadInitialData();
    });
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
      _expandedRow = _rows.length - 1;
    });
  }

  void _removeRow(int index) {
    if (_rows.length <= 1) return;
    setState(() {
      final removed = _rows.removeAt(index);
      removed.dispose();
      if (_expandedRow >= _rows.length) {
        _expandedRow = _rows.length - 1;
      } else if (_expandedRow > index) {
        _expandedRow -= 1;
      }
    });
  }

  String _rowSummary(TransferRowState row) {
    final name = _productNames.where((n) => n['id'] == row.productNameId).map((n) => n['name']).firstOrNull;
    final model = row.productModels.where((m) => m['id'] == row.productModelId).map((m) => m['name']).firstOrNull;
    final product = [name, model].whereType<String>().where((s) => s.isNotEmpty).join(' / ');
    final scans = '${row.scannedSerials.length} scanned';
    return product.isEmpty ? scans : '$product · $scans';
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoadingSellers = true;
      _isLoadingNames = true;
    });

    try {
      final repo = ref.read(shipmentRepositoryProvider);
      final sellersList = await repo.getSellers();
      if (mounted) {
        setState(() {
          _sellers = sellersList;
          _isLoadingSellers = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading sellers: $e');
      if (mounted) setState(() => _isLoadingSellers = false);
    }

    try {
      final repo = ref.read(shipmentRepositoryProvider);
      final inventoryList = await repo.getInventoryProducts();

      final namesList = <Map<String, String>>[];
      for (final item in inventoryList) {
        final productName = item.productName ?? '';
        final productNameId = item.productNameId?.toString() ?? '';
        final models = item.models?.toList() ?? const [];
        final hasStock = models.any((m) => (m.availableQuantity ?? 0) > 0);
        if (productName.isNotEmpty && productNameId.isNotEmpty && hasStock) {
          namesList.add({'id': productNameId, 'name': productName});
        }
      }

      if (mounted) {
        setState(() {
          _inventoryProducts = inventoryList;
          _productNames = namesList;
          _isLoadingNames = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading inventory products: $e');
      if (mounted) setState(() => _isLoadingNames = false);
    }
  }

  void _onProductNameSelected(int rowIndex, String productNameId) {
    final row = _rows[rowIndex];

    InventoryProductNameGroup? group;
    for (final g in _inventoryProducts) {
      if (g.productNameId?.toString() == productNameId) {
        group = g;
        break;
      }
    }

    final List<Map<String, String>> models = [];
    for (final m in group?.models?.toList() ?? const <InventoryProductModelOption>[]) {
      if ((m.availableQuantity ?? 0) <= 0) continue;
      models.add({
        'id': m.productModelId?.toString() ?? '',
        'name': m.productModel ?? '',
      });
    }

    setState(() {
      row.productNameId = productNameId;
      row.productModels = models;
      row.productModelId = null;
      row.productId = null;
      row.availableStock = null;
      row.availableSerials = [];
      row.scannedSerials = [];
    });
  }

  void _onProductModelSelected(int rowIndex, String modelId) {
    final row = _rows[rowIndex];
    InventoryProductNameGroup? group;
    for (final g in _inventoryProducts) {
      if (g.productNameId?.toString() == row.productNameId) {
        group = g;
        break;
      }
    }

    int? resolvedProdId;
    int? stockCount;
    for (final m in group?.models?.toList() ?? const <InventoryProductModelOption>[]) {
      if (m.productModelId?.toString() == modelId) {
        resolvedProdId = m.id;
        stockCount = m.availableQuantity;
        break;
      }
    }

    setState(() {
      row.productModelId = modelId;
      row.productId = resolvedProdId;
      row.availableStock = stockCount ?? 0;
      row.scannedSerials = [];
      row.availableSerials = [];
    });
    _loadAvailableSerials(rowIndex);
  }

  Future<void> _loadAvailableSerials(int rowIndex) async {
    final row = _rows[rowIndex];
    final nameId = int.tryParse(row.productNameId ?? '');
    final modelId = int.tryParse(row.productModelId ?? '');
    if (nameId == null || modelId == null) return;

    setState(() => row.isLoadingSerials = true);
    try {
      final serials = await ref.read(shipmentRepositoryProvider).getAvailableSerials(
        productNameId: nameId,
        productModelId: modelId,
      );
      if (!mounted) return;
      if (row.productNameId != nameId.toString() || row.productModelId != modelId.toString()) return;
      setState(() {
        row.availableSerials = serials;
        row.availableStock = serials.length;
        row.isLoadingSerials = false;
      });
    } catch (e) {
      debugPrint('Error loading available serials: $e');
      if (mounted) {
        setState(() {
          row.availableSerials = [];
          row.isLoadingSerials = false;
        });
        context.showErrorSnackBar('Could not load serials for this product');
      }
    }
  }

  String? _canonicalInStock(TransferRowState row, String serial) {
    final lower = serial.toLowerCase();
    for (final s in row.availableSerials) {
      if (s.toLowerCase() == lower) return s;
    }
    return null;
  }

  bool _alreadyScanned(String serial) {
    final lower = serial.toLowerCase();
    for (final r in _rows) {
      for (final s in r.scannedSerials) {
        if (s.toLowerCase() == lower) return true;
      }
    }
    return false;
  }

  bool _tryAddSerial(TransferRowState row, String raw) {
    final serial = raw.trim();
    if (serial.isEmpty) return false;
    if (row.isLoadingSerials) {
      context.showErrorSnackBar('Loading available serials…');
      return false;
    }
    if (_alreadyScanned(serial)) {
      context.showErrorSnackBar('Serial number already added');
      return false;
    }
    final canonical = _canonicalInStock(row, serial);
    if (canonical == null) {
      context.showErrorSnackBar('Serial unavailable or not in admin inventory for this product');
      return false;
    }
    setState(() {
      row.scannedSerials.add(canonical);
      row.manualSerialController.clear();
    });
    return true;
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
    if (_isSubmitting) return;
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
    final List<CreateShipmentItem> itemsPayload = [];

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

      if (row.scannedSerials.isEmpty) {
        context.showErrorSnackBar('Please scan at least one serial number on row ${i + 1}');
        return;
      }

      final price = double.tryParse(row.priceController.text) ?? 0.0;

      if (row.availableStock != null && row.scannedSerials.length > row.availableStock!) {
        context.showErrorSnackBar('Quantity exceeds available stock on row ${i + 1}');
        return;
      }

      if (price <= 0) {
        context.showErrorSnackBar('Price must be greater than zero on row ${i + 1}');
        return;
      }

      itemsPayload.add(CreateShipmentItem((b) {
        b.productNameId = int.parse(row.productNameId!);
        b.productModelId = int.parse(row.productModelId!);
        b.serialNumbers.replace(row.scannedSerials);
        b.pricePerPiece = price;
      }));
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final repo = ref.read(shipmentRepositoryProvider);
      final result = await repo.createShipment(
        sellerId: _selectedSellerId!,
        items: itemsPayload,
      );

      if (mounted) {
        final count = result.transferredUnits > 0
            ? result.transferredUnits
            : itemsPayload.fold<int>(
                0,
                (sum, item) => sum + item.serialNumbers.length,
              );
        context.showSuccessSnackBar(
          'Transferred $count unit(s) to seller successfully',
        );
        // Refresh admin/seller inventory + shipment lists (SSOT).
        DataSync.afterShipmentMutation(ref);
        context.pop();
      }
    } catch (e) {
      // Handled automatically by ApiInterceptor (error snackbar)
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
                              : (_sellers.isEmpty
                                  ? TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        hintText: 'No sellers available. Please create one first.',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                      ),
                                    )
                                  : DropdownButtonFormField<int>(
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      hint: const Text('Search & Select Seller'),
                                      items: _sellers.map((seller) {
                                        return DropdownMenuItem<int>(
                                          value: seller.id,
                                          child: Text('${seller.shopName} (${seller.userName})'),
                                        );
                                      }).toList(),
                                      onChanged: (id) {
                                        if (id != null) {
                                          setState(() {
                                            _selectedSellerId = id;
                                          });
                                        }
                                      },
                                    )),
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
                      final expanded = _rows.length == 1 || _expandedRow == index;
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
                            InkWell(
                              onTap: _rows.length == 1
                                  ? null
                                  : () => setState(() => _expandedRow = index),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Product ${index + 1}',
                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF006B2C)),
                                        ),
                                        if (!expanded) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            _rowSummary(row),
                                            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  if (_rows.length > 1)
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, color: AppTheme.error),
                                      onPressed: () => _removeRow(index),
                                    ),
                                  if (_rows.length > 1)
                                    Icon(
                                      expanded ? Icons.expand_less : Icons.expand_more,
                                      color: const Color(0xFF64748B),
                                    ),
                                ],
                              ),
                            ),
                            if (expanded) ...[
                            const SizedBox(height: 12),

                            // Product Name Dropdown
                            const Text(
                              'Product Name',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                            ),
                            const SizedBox(height: 6),
                            _isLoadingNames
                                ? const Center(child: CircularProgressIndicator())
                                : (_productNames.isEmpty
                                    ? TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          hintText: 'No products available.',
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                          filled: true,
                                          fillColor: Colors.grey.shade100,
                                        ),
                                      )
                                    : DropdownButtonFormField<String>(
                                        key: ValueKey('name_$index'),
                                        value: _productNames.any((n) => n['id'] == row.productNameId)
                                            ? row.productNameId
                                            : null,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        hint: const Text('Select Product Name'),
                                        items: _productNames.map((name) {
                                          return DropdownMenuItem<String>(
                                            value: name['id']!,
                                            child: Text(name['name']!),
                                          );
                                        }).toList(),
                                        onChanged: (id) {
                                          if (id != null) {
                                            _onProductNameSelected(index, id);
                                          }
                                        },
                                      )),
                            const SizedBox(height: 16),

                            // Product Model Dropdown
                            const Text(
                              'Product Model',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
                            ),
                            const SizedBox(height: 6),
                            row.productNameId == null
                                ? TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      hintText: 'Select Product Name first',
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                    ),
                                  )
                                : (row.productModels.isEmpty
                                    ? TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          hintText: 'No models available.',
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                          filled: true,
                                          fillColor: Colors.grey.shade100,
                                        ),
                                      )
                                    : DropdownButtonFormField<String>(
                                        key: ValueKey('model_${index}_${row.productNameId}'),
                                        value: row.productModels.any((m) => m['id'] == row.productModelId)
                                            ? row.productModelId
                                            : null,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        hint: const Text('Select Product Model'),
                                        items: row.productModels.map((model) {
                                          return DropdownMenuItem<String>(
                                            value: model['id']!,
                                            child: Text(model['name']!),
                                          );
                                        }).toList(),
                                        onChanged: (id) {
                                          if (id != null) {
                                            _onProductModelSelected(index, id);
                                          }
                                        },
                                      )),
                            const SizedBox(height: 16),

                            // Info Box (Stock Detail)
                            if (row.productModelId != null) ...[
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFECEEF0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Serial Numbers
                                if (row.isLoadingSerials) ...[
                                  const LinearProgressIndicator(minHeight: 2),
                                  const SizedBox(height: 8),
                                ],
                                SerialScanField(
                                  serials: row.scannedSerials,
                                  manualController: row.manualSerialController,
                                  enabled: row.productModelId != null && !row.isLoadingSerials,
                                  availableStock: row.availableStock,
                                  onAdd: (s) => _tryAddSerial(row, s),
                                  onRemove: (s) {
                                    setState(() => row.scannedSerials.remove(s));
                                  },
                                ),
                                const SizedBox(height: 16),

                                // Price Per Piece
                                Column(
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
                              ],
                            ),
                            ],
                          ],
                        ),
                      );
                    }),

                    // Add Another Product Button
                    OutlinedButton.icon(
                      onPressed: _addRow,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Another Product'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFF006B2C)),
                        foregroundColor: const Color(0xFF006B2C),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _isSubmitting ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
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
                              'Create Shipment',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                    const SizedBox(height: 32),
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
