import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../theme/app_theme.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../employee/attendance/location_service.dart';
import '../../../employee/attendance/location_exceptions.dart';

/// Pan map under a fixed pin, or seed from device GPS.
class LocationMapPicker extends StatefulWidget {
  const LocationMapPicker({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.onChanged,
    this.enabled = true,
  });

  final double latitude;
  final double longitude;
  final ValueChanged<LatLng> onChanged;
  final bool enabled;

  @override
  State<LocationMapPicker> createState() => _LocationMapPickerState();
}

class _LocationMapPickerState extends State<LocationMapPicker> {
  static const _gps = LocationService();
  final _map = MapController();
  bool _locating = false;

  @override
  void dispose() {
    _map.dispose();
    super.dispose();
  }

  Future<void> _useCurrent() async {
    if (!widget.enabled || _locating) return;
    setState(() => _locating = true);
    try {
      final pos = await _gps.getCurrentLocation();
      final point = LatLng(pos.latitude, pos.longitude);
      _map.move(point, 17);
      widget.onChanged(point);
    } on LocationException catch (e) {
      if (!mounted) return;
      context.showErrorSnackBar(e.message);
    } catch (_) {
      if (!mounted) return;
      context.showErrorSnackBar('Could not get current location');
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: widget.enabled && !_locating ? _useCurrent : null,
            icon: _locating
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.my_location, size: 18),
            label: Text(_locating ? 'Locating…' : 'Use current'),
            style: TextButton.styleFrom(foregroundColor: AppTheme.primary),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                FlutterMap(
                  mapController: _map,
                  options: MapOptions(
                    initialCenter: LatLng(widget.latitude, widget.longitude),
                    initialZoom: 16,
                    interactionOptions: InteractionOptions(
                      flags: widget.enabled
                          ? InteractiveFlag.all & ~InteractiveFlag.rotate
                          : InteractiveFlag.none,
                    ),
                    onPositionChanged: (camera, hasGesture) {
                      if (hasGesture && widget.enabled) {
                        widget.onChanged(camera.center);
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.friends.batteryapp',
                    ),
                  ],
                ),
                const IgnorePointer(
                  child: Icon(
                    Icons.location_on,
                    size: 40,
                    color: AppTheme.primary,
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${widget.latitude.toStringAsFixed(5)}, '
                      '${widget.longitude.toStringAsFixed(5)}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
