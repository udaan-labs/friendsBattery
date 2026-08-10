import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/network/api_client_provider.dart';
import '../../../../theme/app_theme.dart';

/// Super Admin / Admin: employees currently checked in + check-in GPS.
class CheckedInStaffScreen extends ConsumerStatefulWidget {
  const CheckedInStaffScreen({super.key});

  @override
  ConsumerState<CheckedInStaffScreen> createState() =>
      _CheckedInStaffScreenState();
}

class _CheckedInStaffScreenState extends ConsumerState<CheckedInStaffScreen> {
  bool _showMap = false;

  @override
  Widget build(BuildContext context) {
    final asyncList = ref.watch(checkedInStaffProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text('Checked-in staff'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF191C1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/admin/dashboard');
            }
          },
        ),
        actions: [
          IconButton(
            tooltip: _showMap ? 'List view' : 'Map view',
            icon: Icon(_showMap ? Icons.list_rounded : Icons.map_outlined),
            onPressed: () => setState(() => _showMap = !_showMap),
          ),
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(checkedInStaffProvider),
          ),
        ],
      ),
      body: asyncList.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Failed to load: $e', textAlign: TextAlign.center),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => ref.invalidate(checkedInStaffProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (rows) {
          if (rows.isEmpty) {
            return const Center(
              child: Text(
                'No employees checked in right now',
                style: TextStyle(color: Color(0xFF586377)),
              ),
            );
          }
          if (_showMap) {
            return _CheckedInMap(rows: rows);
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(checkedInStaffProvider),
            color: AppTheme.primary,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: rows.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final r = rows[i];
                final name = r.employee?.userName ?? 'Employee #${r.employeeId}';
                final loc = r.location?.name ?? r.location?.code ?? '—';
                final when = r.checkInTime?.toLocal().toString().substring(0, 16) ??
                    '—';
                final hasGps = r.checkInLat != null && r.checkInLng != null;
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFFECEEF0)),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFE8F5E9),
                      child: Icon(
                        hasGps ? Icons.location_on : Icons.person_outline,
                        color: AppTheme.primary,
                      ),
                    ),
                    title: Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      '$loc\nIn since $when'
                      '${hasGps ? '\nGPS: ${r.checkInLat!.toStringAsFixed(5)}, ${r.checkInLng!.toStringAsFixed(5)}' : ''}',
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _CheckedInMap extends StatelessWidget {
  const _CheckedInMap({required this.rows});

  final List<CheckedInStaffItem> rows;

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[];
    LatLng? center;
    for (final r in rows) {
      final lat = r.checkInLat;
      final lng = r.checkInLng;
      if (lat == null || lng == null) continue;
      final point = LatLng(lat.toDouble(), lng.toDouble());
      center ??= point;
      markers.add(
        Marker(
          point: point,
          width: 40,
          height: 40,
          child: Tooltip(
            message: r.employee?.userName ?? 'Staff',
            child: const Icon(Icons.location_on, color: Color(0xFF006B2C), size: 36),
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
        initialZoom: 13,
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
  // built_value JsonObject
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
              userName: emp['user_name']?.toString() ?? emp['userName']?.toString(),
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
