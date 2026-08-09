import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../../theme/app_theme.dart';
import '../providers/locations_providers.dart';
import '../widgets/location_map_picker.dart';

/// Admin create shop or warehouse — same form, type is chosen here.
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
  double _latitude = _defaultLat;
  double _longitude = _defaultLng;
  bool _submitting = false;

  bool get _isShop => _type == 'SHOP';

  @override
  void initState() {
    super.initState();
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

  void _onMapChanged(LatLng point) {
    setState(() {
      _latitude = point.latitude;
      _longitude = point.longitude;
    });
  }

  Future<void> _submit() async {
    final code = _codeController.text.trim();
    final name = _nameController.text.trim();
    if (code.isEmpty || name.isEmpty) {
      context.showErrorSnackBar('Code and name are required');
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
            code: code,
            name: name,
            type: _type,
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
      context.showErrorSnackBar(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          : (s) => setState(() => _type = s.first),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _codeController,
                      enabled: !_submitting,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        labelText: 'Code',
                        hintText: _isShop ? 'e.g. SHOP002' : 'e.g. WH002',
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
