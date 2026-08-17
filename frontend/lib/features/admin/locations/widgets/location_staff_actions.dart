import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

import '../../../auth/widgets/admin_location_picker.dart';
import '../../../shared/staff/providers/staff_providers.dart';
import '../../accounts/providers/accounts_providers.dart';

Future<void> setLocationStaffActive(
  BuildContext context,
  WidgetRef ref, {
  required int locationId,
  required ShopStaffMember member,
  required bool isActive,
}) async {
  final id = member.id;
  if (id == null) return;
  try {
    await ref.read(accountsRepositoryProvider).setActive(
          id: id,
          isActive: isActive,
        );
    ref.invalidate(locationStaffProvider(locationId));
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
  }
}

Future<void> moveLocationEmployee(
  BuildContext context,
  WidgetRef ref, {
  required int locationId,
  required ShopStaffMember member,
}) async {
  final id = member.id;
  if (id == null) return;
  final locations = await ref.read(locationsListProvider.future);
  if (!context.mounted) return;
  final dests = [
    for (final l in locations)
      if (l.id != null && l.id != locationId) l,
  ];
  if (dests.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No other location to move to')),
    );
    return;
  }
  LocationItem? dest;
  await showAdminLocationPicker(
    context: context,
    locations: dests,
    selectedId: null,
    onSelected: (l) => dest = l,
  );
  final destId = dest?.id;
  if (destId == null || !context.mounted) return;
  try {
    await ref.read(staffRepositoryProvider).transferEmployee(
          id: id,
          locationId: destId,
        );
    ref.invalidate(locationStaffProvider(locationId));
    ref.invalidate(locationStaffProvider(destId));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Employee moved')),
    );
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
  }
}
