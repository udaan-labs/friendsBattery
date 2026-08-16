import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../theme/app_theme.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../employee/attendance/location_service.dart';
import '../../../employee/attendance/location_exceptions.dart';
import '../place_search.dart';

/// Pan map under a fixed pin, or seed from device GPS.
class LocationMapPicker extends StatefulWidget {
  const LocationMapPicker({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.onChanged,
    this.onAddressFound,
    this.enabled = true,
  });

  final double latitude;
  final double longitude;
  final ValueChanged<LatLng> onChanged;

  /// Set only when the user picks a search hit — not on pan / GPS.
  final ValueChanged<String>? onAddressFound;
  final bool enabled;

  @override
  State<LocationMapPicker> createState() => _LocationMapPickerState();
}

class _LocationMapPickerState extends State<LocationMapPicker> {
  static const _gps = LocationService();
  final _map = MapController();
  final _searchController = TextEditingController();
  bool _locating = false;
  bool _searching = false;
  String _lastQuery = '';
  List<PlaceHit> _hits = const [];

  @override
  void dispose() {
    _searchController.dispose();
    _map.dispose();
    super.dispose();
  }

  void _onQueryChanged(String value) {
    if (value.endsWith(' ') && value.trim().length >= 3) {
      _search(quiet: true);
    }
  }

  Future<void> _search({bool quiet = false}) async {
    if (!widget.enabled || _searching) return;
    final q = _searchController.text.trim();
    if (q.length < 3) {
      if (!quiet) context.showErrorSnackBar('Type a place to search');
      return;
    }
    if (q == _lastQuery) return;
    setState(() {
      _searching = true;
      _hits = const [];
    });
    try {
      final hits = await searchPlaces(q);
      if (!mounted) return;
      _lastQuery = q;
      setState(() => _hits = hits);
    } catch (e) {
      if (!mounted) return;
      if (!quiet) context.showFriendlyError(e);
    } finally {
      if (mounted) setState(() => _searching = false);
    }
  }

  void _pick(PlaceHit hit) {
    if (!widget.enabled) return;
    final point = LatLng(hit.latitude, hit.longitude);
    _map.move(point, 17);
    widget.onChanged(point);
    widget.onAddressFound?.call(hit.displayName);
    FocusScope.of(context).unfocus();
    setState(() => _hits = const []);
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
        TextField(
          controller: _searchController,
          enabled: widget.enabled,
          textInputAction: TextInputAction.search,
          onChanged: _onQueryChanged,
          onSubmitted: (_) => _search(),
          decoration: InputDecoration(
            hintText: 'Search place',
            isDense: true,
            suffixIcon: IconButton(
              onPressed: widget.enabled && !_searching ? _search : null,
              icon: _searching
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.search, size: 20),
            ),
          ),
        ),
        if (_hits.isNotEmpty) ...[
          const SizedBox(height: 4),
          for (final hit in _hits)
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.place_outlined, size: 18),
              title: Text(
                hit.displayName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
              onTap: widget.enabled ? () => _pick(hit) : null,
            ),
        ],
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
