import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/staff/providers/staff_providers.dart';
import '../providers/locations_providers.dart';
import '../widgets/shop_detail_body.dart';
import '../widgets/warehouse_detail_body.dart';

/// Shop / warehouse detail. Same shell; body differs by type.
class LocationDetailScreen extends ConsumerWidget {
  const LocationDetailScreen({
    super.key,
    required this.locationId,
    this.title,
  });

  final int locationId;

  /// Optional name for the app bar while staff loads (from list navigation).
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(locationStaffProvider(locationId));
    final cached = ref
        .watch(allLocationsProvider)
        .valueOrNull
        ?.where((e) => e.id == locationId)
        .firstOrNull;
    final isWarehouse = cached?.type == LocationItemTypeEnum.WAREHOUSE ||
        staffAsync.valueOrNull?.location?.type == 'WAREHOUSE';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          cached?.name ?? title ?? 'Location Details',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF006B2C)),
            tooltip: 'Edit location',
            onPressed: () async {
              final changed = await context.push<bool>(
                '/admin/locations/$locationId/edit',
              );
              if (changed == true) {
                ref.invalidate(allLocationsProvider);
                ref.invalidate(locationsByTypeProvider);
              }
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push(
            '/admin/add-employee?locationId=$locationId',
          );
          ref.invalidate(locationStaffProvider(locationId));
        },
        backgroundColor: const Color(0xFF006B2C),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Add employee'),
      ),
      body: isWarehouse
          ? WarehouseDetailBody(locationId: locationId, cached: cached)
          : ShopDetailBody(locationId: locationId, cached: cached),
    );
  }
}
