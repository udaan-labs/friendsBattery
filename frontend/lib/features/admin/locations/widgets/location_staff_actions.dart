import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

import '../../../../shared/widgets/snackbar_helper.dart';
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
    context.showFriendlyError(e);
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
  final repo = ref.read(staffRepositoryProvider);
  final shops = await repo.listLocations(type: 'SHOP');
  final warehouses = member.role == ShopStaffMemberRoleEnum.SELLER
      ? const <LocationItem>[]
      : await repo.listLocations(type: 'WAREHOUSE');
  if (!context.mounted) return;
  final dests = [
    for (final l in [...shops, ...warehouses])
      if (l.id != null && l.id != locationId) l,
  ];
  if (dests.isEmpty) {
    context.showInfoSnackBar('No other location to move to');
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
    ref.invalidate(locationStaffProvider(destId));
    final _ = ref.refresh(locationStaffProvider(locationId));
    if (!context.mounted) return;
    context.showSuccessSnackBar('Moved');
  } catch (e) {
    if (!context.mounted) return;
    context.showFriendlyError(e);
  }
}
