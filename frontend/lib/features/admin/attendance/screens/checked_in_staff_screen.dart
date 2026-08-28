import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../../../shared/attendance/checked_in_staff.dart';

/// Super Admin / Admin: employees currently checked in + check-in GPS.
class CheckedInStaffScreen extends ConsumerStatefulWidget {
  const CheckedInStaffScreen({super.key});

  @override
  ConsumerState<CheckedInStaffScreen> createState() =>
      _CheckedInStaffScreenState();
}

class _CheckedInStaffScreenState extends ConsumerState<CheckedInStaffScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;
  String _query = '';
  bool _showMap = false;
  CheckedInStaffItem? _focusedStaff;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncList = ref.watch(checkedInStaffProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: (val) => setState(() => _query = val),
                style: const TextStyle(fontSize: 16, color: Color(0xFF191C1E)),
                decoration: const InputDecoration(
                  hintText: 'Search employee name or shop…',
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
                  border: InputBorder.none,
                ),
              )
            : Text(_focusedStaff != null
                ? 'Location: ${_focusedStaff?.employee?.userName ?? "Staff"}'
                : 'Checked-in staff'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF191C1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            if (_focusedStaff != null) {
              setState(() => _focusedStaff = null);
              return;
            }
            if (_isSearching) {
              setState(() {
                _isSearching = false;
                _searchController.clear();
                _query = '';
              });
              return;
            }
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/admin/dashboard');
            }
          },
        ),
        actions: [
          IconButton(
            tooltip: _isSearching ? 'Close search' : 'Search staff',
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear();
                  _query = '';
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
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
          final q = _query.trim().toLowerCase();
          final filtered = q.isEmpty
              ? rows
              : rows.where((r) {
                  final name = r.employee?.userName ?? '';
                  final id = r.employeeId?.toString() ?? '';
                  final locName = r.location?.name ?? '';
                  final locCode = r.location?.code ?? '';
                  final text = '$name $id $locName $locCode'.toLowerCase();
                  return text.contains(q);
                }).toList();

          if (filtered.isEmpty) {
            return Center(
              child: Text(
                q.isEmpty
                    ? 'No employees checked in right now'
                    : 'No checked-in staff matching "$_query"',
                style: const TextStyle(color: Color(0xFF586377)),
              ),
            );
          }
          if (_showMap) {
            return Stack(
              children: [
                CheckedInMap(rows: filtered, focusedItem: _focusedStaff),
                if (_focusedStaff != null)
                  Positioned(
                    top: 16,
                    left: 16,
                    child: FloatingActionButton.extended(
                      heroTag: 'show_all_staff',
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1E293B),
                      onPressed: () => setState(() => _focusedStaff = null),
                      icon: const Icon(Icons.layers_rounded, color: Color(0xFF006B2C)),
                      label: const Text('Show All Staff on Map'),
                    ),
                  ),
              ],
            );
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(checkedInStaffProvider),
            color: AppTheme.primary,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final r = filtered[i];
                final name = r.employee?.userName ?? 'Employee #${r.employeeId}';
                final loc = r.location?.name ?? r.location?.code ?? '—';
                final when = r.checkInTime?.toLocal().toString().substring(0, 16) ??
                    '—';
                final hasGps = r.hasGps;
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFFECEEF0)),
                  ),
                  child: ListTile(
                    onTap: hasGps
                        ? () {
                            setState(() {
                              _focusedStaff = r;
                              _showMap = true;
                            });
                          }
                        : null,
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
                    trailing: hasGps
                        ? TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _focusedStaff = r;
                                _showMap = true;
                              });
                            },
                            icon: const Icon(Icons.my_location_rounded, size: 18, color: Color(0xFF006B2C)),
                            label: const Text(
                              'Map',
                              style: TextStyle(color: Color(0xFF006B2C), fontWeight: FontWeight.bold),
                            ),
                          )
                        : null,
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
