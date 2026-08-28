import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/network/api_client_provider.dart';

/// Presentation row mapped from OpenAPI checked-in payload.
class CheckedInStaffItem {
  final int? id;
  final int? employeeId;
  final DateTime? checkInTime;
  final num? checkInLat;
  final num? checkInLng;
  final CheckedInEmployee? employee;
  final CheckedInLocation? location;

  CheckedInStaffItem({
    this.id,
    this.employeeId,
    this.checkInTime,
    this.checkInLat,
    this.checkInLng,
    this.employee,
    this.location,
  });

  bool get hasGps => checkInLat != null && checkInLng != null;
}

class CheckedInEmployee {
  final String? userName;
  CheckedInEmployee({this.userName});
}

class CheckedInLocation {
  final String? name;
  final String? code;
  CheckedInLocation({this.name, this.code});
}

Map<String, dynamic>? _jsonObjectMap(Object? value) {
  if (value == null) return null;
  if (value is Map<String, dynamic>) return value;
  if (value is Map) {
    return value.map((k, v) => MapEntry(k.toString(), v));
  }
  try {
    final v = (value as dynamic).value;
    if (v is Map) {
      return v.map((k, val) => MapEntry(k.toString(), val));
    }
  } catch (_) {}
  return null;
}

final checkedInStaffProvider =
    FutureProvider.autoDispose<List<CheckedInStaffItem>>((ref) async {
  final api = ref.watch(apiClientProvider).getAttendanceApi();
  final response = await api.apiEmployeeAttendanceCheckedInGet();
  final rows = response.data?.data?.toList() ?? [];

  return rows.map((raw) {
    final emp = _jsonObjectMap(raw.employee);
    final loc = _jsonObjectMap(raw.location);
    return CheckedInStaffItem(
      id: raw.id,
      employeeId: raw.employeeId,
      checkInTime: raw.checkInTime,
      checkInLat: raw.checkInLat,
      checkInLng: raw.checkInLng,
      employee: emp != null
          ? CheckedInEmployee(
              userName:
                  emp['user_name']?.toString() ?? emp['userName']?.toString(),
            )
          : null,
      location: loc != null
          ? CheckedInLocation(
              name: loc['name']?.toString(),
              code: loc['code']?.toString(),
            )
          : null,
    );
  }).toList();
});

class CheckedInMap extends StatelessWidget {
  const CheckedInMap({super.key, required this.rows, this.focusedItem});

  final List<CheckedInStaffItem> rows;
  final CheckedInStaffItem? focusedItem;

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[];
    LatLng? center;

    if (focusedItem != null && focusedItem!.hasGps) {
      center = LatLng(
        focusedItem!.checkInLat!.toDouble(),
        focusedItem!.checkInLng!.toDouble(),
      );
    }

    for (final r in rows) {
      if (!r.hasGps) continue;
      final point = LatLng(r.checkInLat!.toDouble(), r.checkInLng!.toDouble());
      center ??= point;
      final name = r.employee?.userName ?? 'Staff #${r.employeeId}';
      final isFocused = focusedItem != null && r.id == focusedItem!.id;

      markers.add(
        Marker(
          point: point,
          width: isFocused ? 140 : 120,
          height: isFocused ? 70 : 60,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isFocused
                      ? const Color(0xFF006B2C)
                      : const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(8),
                  border: isFocused
                      ? Border.all(color: Colors.amber, width: 2)
                      : null,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isFocused ? 12 : 11,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Icon(
                Icons.location_on,
                color: isFocused ? Colors.amber : const Color(0xFF006B2C),
                size: isFocused ? 34 : 28,
              ),
            ],
          ),
        ),
      );
    }

    if (markers.isEmpty) {
      return const Center(
        child: Text(
          'No GPS coordinates on check-in yet',
          style: TextStyle(color: Color(0xFF586377)),
        ),
      );
    }

    return FlutterMap(
      options: MapOptions(
        initialCenter: center!,
        initialZoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.friendsbattery.app',
        ),
        MarkerLayer(markers: markers),
      ],
    );
  }
}
