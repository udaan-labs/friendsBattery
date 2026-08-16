import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../../theme/app_theme.dart';
import '../providers/locations_providers.dart';
import '../widgets/location_map_picker.dart';

/// Create shop or warehouse. Super Admin: either. Shop Admin: shop only.
class AddLocationScreen extends ConsumerStatefulWidget {
  const AddLocationScreen({super.key, this.initialType = 'SHOP'});

  /// `SHOP` or `WAREHOUSE` default selection.
  final String initialType;

  @override
  ConsumerState<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends ConsumerState<AddLocationScreen> {
  /// Default map center (Ahmedabad area — matches geofence tests).
  static const double _defaultLat = 23.0225;
  static const double _defaultLng = 72.5714;

  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _radiusController = TextEditingController(text: '100');

  late String _type;
  int? _warehouseId;
  double _latitude = _defaultLat;
  double _longitude = _defaultLng;
  bool _submitting = false;

  bool get _isShop => _type == 'SHOP';

  @override
  void initState() {
    super.initState();
    // Default SHOP; SA can switch in UI. Shop Admin always submits SHOP (backend enforces).
    _type = widget.initialType == 'WAREHOUSE' ? 'WAREHOUSE' : 'SHOP';
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _radiusController.dispose();
    super.dispose();
  }

  String _previewCode(WidgetRef ref, String type) {
    final prefix = type == 'WAREHOUSE' ? 'WH' : 'SHOP';
    final rows = ref.read(allLocationsProvider).asData?.value ?? const [];
    var max = 0;
    final re = RegExp('^$prefix(\\d+)\$', caseSensitive: false);
    for (final loc in rows) {
      final m = re.firstMatch(loc.code ?? '');
      if (m != null) {
        final n = int.tryParse(m.group(1)!) ?? 0;
        if (n > max) max = n;
      }
    }
    return '$prefix${(max + 1).toString().padLeft(3, '0')}';
  }

  void _onMapChanged(LatLng point) {
    setState(() {
      _latitude = point.latitude;
      _longitude = point.longitude;
    });
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      context.showErrorSnackBar('Name is required');
      return;
    }

    final isSuperAdmin = ref.read(authProvider).role == UserRole.superAdmin;
    final type = isSuperAdmin ? _type : 'SHOP';
    if (type == 'SHOP' && _warehouseId == null) {
      context.showErrorSnackBar('Pick a warehouse for this shop');
      return;
    }

    final radius = int.tryParse(_radiusController.text.trim());
    if (radius == null || radius < 10 || radius > 5000) {
      context.showErrorSnackBar('Allowed radius must be 10–5000 meters');
      return;
    }

    setState(() => _submitting = true);
    try {
      await ref.read(locationsRepositoryProvider).create(
            code: _previewCode(ref, type),
            name: name,
            type: type,
            warehouseId: type == 'SHOP' ? _warehouseId : null,
            address: _addressController.text.trim(),
            phone: _phoneController.text.trim(),
            latitude: _latitude,
            longitude: _longitude,
            allowedRadius: radius,
          );
      ref.invalidate(allLocationsProvider);
      ref.invalidate(locationsByTypeProvider);
      if (!mounted) return;
      context.showSuccessSnackBar(
        _isShop ? 'Shop created' : 'Warehouse created',
      );
      context.pop(true);
    } catch (e) {
      if (!mounted) return;
      context.showFriendlyError(e);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSuperAdmin = ref.watch(authProvider).role == UserRole.superAdmin;
    ref.watch(allLocationsProvider);
    final autoCode = _previewCode(ref, isSuperAdmin ? _type : 'SHOP');
    if (_codeController.text != autoCode) {
      _codeController.text = autoCode;
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Add location',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.add_location_alt_outlined,
                size: 48,
                color: AppTheme.primary,
              ),
              const SizedBox(height: 12),
              const Text(
                'Create a shop or warehouse — same form, pick the type.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Color(0xFF545F73)),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!isSuperAdmin)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Creating a shop (warehouses are Super Admin only)',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF586377),
                          ),
                        ),
                      )
                    else ...[
                      const Text(
                        'Type',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(
                            value: 'SHOP',
                            label: Text('Shop'),
                            icon: Icon(Icons.storefront_outlined, size: 18),
                          ),
                          ButtonSegment(
                            value: 'WAREHOUSE',
                            label: Text('Warehouse'),
                            icon: Icon(Icons.warehouse_outlined, size: 18),
                          ),
                        ],
                        selected: {_type},
                        onSelectionChanged: _submitting
                            ? null
                            : (s) => setState(() {
                                  _type = s.first;
                                  if (_type != 'SHOP') _warehouseId = null;
                                }),
                      ),
                      const SizedBox(height: 20),
                    ],
                    if (_isShop) ...[
                      _WarehousePicker(
                        value: _warehouseId,
                        enabled: !_submitting,
                        onChanged: (v) => setState(() => _warehouseId = v),
                      ),
                      const SizedBox(height: 16),
                    ],
                    TextField(
                      controller: _codeController,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Code',
                        helperText: 'Assigned automatically',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      enabled: !_submitting,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: _isShop
                            ? 'e.g. Andheri Shop'
                            : 'e.g. Main Warehouse',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _addressController,
                      enabled: !_submitting,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Address (optional)',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _phoneController,
                      enabled: !_submitting,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone (optional)',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Map location',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Pan to set pin, or use current GPS. Used for employee check-in.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                    LocationMapPicker(
                      latitude: _latitude,
                      longitude: _longitude,
                      onChanged: _onMapChanged,
                      onAddressFound: (a) => _addressController.text = a,
                      enabled: !_submitting,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _radiusController,
                      enabled: !_submitting,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Allowed radius (meters)',
                        hintText: '100',
                      ),
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: _submitting ? null : _submit,
                      child: _submitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              _isShop ? 'Create shop' : 'Create warehouse',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WarehousePicker extends ConsumerWidget {
  const _WarehousePicker({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final int? value;
  final bool enabled;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(locationsByTypeProvider('WAREHOUSE'));
    return async.when(
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text('$e', style: const TextStyle(color: AppTheme.error)),
      data: (rows) {
        if (rows.isEmpty) {
          return const Text(
            'Create a warehouse first, then add a shop.',
            style: TextStyle(color: AppTheme.error),
          );
        }
        final ok = value != null && rows.any((w) => w.id == value);
        return DropdownButtonFormField<int>(
          // ignore: deprecated_member_use
          value: ok ? value : null,
          decoration: const InputDecoration(labelText: 'Warehouse'),
          items: [
            for (final w in rows)
              DropdownMenuItem<int>(
                value: w.id,
                child: Text(
                  '${w.code} · ${w.name}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
          onChanged: enabled ? onChanged : null,
        );
      },
    );
  }
}
