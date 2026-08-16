import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

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
