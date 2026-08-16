import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../providers/locations_providers.dart';
import 'location_map_picker.dart';

/// Name + address + map pin. Type / code / warehouse stay as-is.
class EditLocationForm extends ConsumerStatefulWidget {
  const EditLocationForm({
    super.key,
    required this.locationId,
    required this.location,
  });

  final int locationId;
  final LocationItem location;

  @override
  ConsumerState<EditLocationForm> createState() => _EditLocationFormState();
}

class _EditLocationFormState extends ConsumerState<EditLocationForm> {
  static const double _defaultLat = 23.0225;
  static const double _defaultLng = 72.5714;

  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  late final TextEditingController _radiusController;

  late double _latitude;
  late double _longitude;
  bool _submitting = false;

  bool get _isShop => widget.location.type == LocationItemTypeEnum.SHOP;

  @override
  void initState() {
    super.initState();
    final loc = widget.location;
    _nameController = TextEditingController(text: loc.name ?? '');
    _addressController = TextEditingController(text: loc.address ?? '');
    _radiusController = TextEditingController(
      text: '${loc.allowedRadius ?? 100}',
    );
    _latitude = loc.latitude?.toDouble() ?? _defaultLat;
    _longitude = loc.longitude?.toDouble() ?? _defaultLng;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
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
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      context.showErrorSnackBar('Name is required');
      return;
    }

    final radius = int.tryParse(_radiusController.text.trim());
    if (radius == null || radius < 10 || radius > 5000) {
      context.showErrorSnackBar('Allowed radius must be 10–5000 meters');
      return;
    }

    setState(() => _submitting = true);
    try {
      await ref.read(locationsRepositoryProvider).update(
            locationId: widget.locationId,
            name: name,
            address: _addressController.text.trim(),
            latitude: _latitude,
            longitude: _longitude,
            allowedRadius: radius,
          );
      if (!mounted) return;
      context.showSuccessSnackBar('Location updated');
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
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
      child: Container(
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
            TextField(
              controller: _nameController,
              enabled: !_submitting,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: _isShop ? 'e.g. Andheri Shop' : 'e.g. Main Warehouse',
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
            const SizedBox(height: 20),
            const Text(
              'Map location',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
                  : const Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
