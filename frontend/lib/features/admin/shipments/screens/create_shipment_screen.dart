import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/state/data_sync.dart';
import '../../../../shared/utils/app_formatters.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../../theme/app_theme.dart';
import '../providers/shipment_provider.dart';
import '../repository/shipment_repository.dart';
import '../widgets/shipment_seller_card.dart';
import '../widgets/shipment_serial_scan.dart';

class CreateShipmentScreen extends ConsumerStatefulWidget {
  const CreateShipmentScreen({super.key});

  @override
  ConsumerState<CreateShipmentScreen> createState() => _CreateShipmentScreenState();
}

class _CreateShipmentScreenState extends ConsumerState<CreateShipmentScreen> {
  final _manualSerialController = TextEditingController();
  final List<ScannedShipmentUnit> _units = [];
  int? _selectedSellerId;
  bool _isSubmitting = false;
  bool _isLookingUp = false;

  @override
  void dispose() {
    _manualSerialController.dispose();
    super.dispose();
  }

  bool _alreadyScanned(String serial) {
    final lower = serial.toLowerCase();
    return _units.any((u) => u.serial.toLowerCase() == lower);
  }

  Future<void> _addSerial(String raw) async {
    final serial = raw.trim();
    if (serial.isEmpty || _isLookingUp) return;
    if (_alreadyScanned(serial)) {
      context.showErrorSnackBar('Serial number already added');
      return;
    }
    setState(() => _isLookingUp = true);
    try {
      final unit = await ref.read(shipmentRepositoryProvider).scanSerial(serial);
      if (!mounted) return;
      if (_alreadyScanned(unit.serial)) {
        context.showErrorSnackBar('Serial number already added');
        return;
      }
      setState(() {
        _units.add(unit);
        _manualSerialController.clear();
      });
    } catch (_) {
      // ApiInterceptor shows the error
    } finally {
      if (mounted) setState(() => _isLookingUp = false);
    }
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;
    if (_selectedSellerId == null) {
      context.showErrorSnackBar('Seller is required');
      return;
    }
    if (_units.isEmpty) {
      context.showErrorSnackBar('Scan or type at least one serial number');
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final result = await ref.read(shipmentRepositoryProvider).createShipment(
            sellerId: _selectedSellerId!,
            serialNumbers: _units.map((u) => u.serial).toList(),
          );
      if (!mounted) return;
      context.showSuccessSnackBar(
        'Shipment created with ${result.transferredUnits} unit(s)',
      );
      DataSync.afterShipmentMutation(ref);
      context.go('/admin/shipments/${result.shipmentId}');
    } catch (_) {
      // ApiInterceptor shows the error
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sellersAsync = ref.watch(shipmentSellersProvider);

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ShipmentSellerCard(
                    sellers: sellersAsync.valueOrNull ?? const [],
                    isLoading: sellersAsync.isLoading,
                    loadError: sellersAsync.hasError
                        ? friendlyError(sellersAsync.error!)
                        : null,
                    selectedSellerId: _selectedSellerId,
                    onSelected: (id) => setState(() => _selectedSellerId = id),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.background,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                    child: ShipmentSerialScan(
                      units: _units,
                      manualController: _manualSerialController,
                      busy: _isLookingUp,
                      onAdd: _addSerial,
                      onRemove: (s) => setState(
                        () => _units.removeWhere((u) => u.serial == s),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
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
    );
  }
}
