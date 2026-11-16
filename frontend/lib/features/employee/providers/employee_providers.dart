import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../core/network/api_client_provider.dart';
import '../../../core/storage/swr_notifier.dart';
import '../../../shared/models/session_profile.dart';
import '../../shared/inventory/providers/inventory_provider.dart';
import '../attendance/attendance_repository.dart';
import '../repository/employee_shipments_repository.dart';

final employeeProfileProvider = Provider<SessionProfile>((ref) {
  return SessionProfile.fromSession(
    fallbackName: 'Employee',
    fallbackRole: 'employee',
  );
});

final employeeAttendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepository(api: ref.watch(apiClientProvider));
});

final employeeShipmentsRepositoryProvider = Provider<EmployeeShipmentsRepository>((ref) {
  return EmployeeShipmentsRepository(api: ref.watch(apiClientProvider));
});

final employeeAttendanceStatusProvider = StateNotifierProvider<
    SwrNotifier<AttendanceStatusData>, AsyncValue<AttendanceStatusData>>((ref) {
  final repo = ref.watch(employeeAttendanceRepositoryProvider);
  return SwrNotifier(
    key: 'employee.attendance',
    encode: (status) => standardSerializers.serializeWith(AttendanceStatusData.serializer, status),
    decode: (json) => standardSerializers.deserializeWith(AttendanceStatusData.serializer, json),
    fetch: repo.getStatus,
  );
});

final employeeShipmentsProvider = StateNotifierProvider<
    SwrNotifier<List<SellerShipmentListItem>>,
    AsyncValue<List<SellerShipmentListItem>>>((ref) {
  final repo = ref.watch(employeeShipmentsRepositoryProvider);
  return SwrNotifier(
    key: 'employee.shipments',
    encode: (items) => encodeBuiltList(
      items,
      (item) => standardSerializers.serializeWith(SellerShipmentListItem.serializer, item),
    ),
    decode: (json) => decodeBuiltList(
      json,
      (item) => standardSerializers.deserializeWith(SellerShipmentListItem.serializer, item),
    ),
    fetch: repo.listShipments,
  );
});

/// Stock units count from shared inventory (location-scoped API).
final employeeStockCountProvider =
    StateNotifierProvider<SwrNotifier<int>, AsyncValue<int>>((ref) {
  final notifier = SwrNotifier<int>(
    key: 'employee.stock',
    encode: (count) => count,
    decode: (json) => json is num ? json.toInt() : null,
    fetch: () async {
      final inv = await ref.read(sharedInventoryProvider.future);
      return inv.items.fold<int>(0, (sum, item) => sum + item.quantity);
    },
  );
  ref.listen(sharedInventoryProvider, (_, next) {
    final page = next.valueOrNull;
    if (page == null) return;
    notifier.adopt(page.items.fold<int>(0, (sum, item) => sum + item.quantity));
  });
  return notifier;
});

Future<void> refreshEmployeeDashboard(WidgetRef ref) async {
  ref.invalidate(sharedInventoryProvider);
  await Future.wait([
    ref.read(employeeAttendanceStatusProvider.notifier).reload(),
    ref.read(employeeShipmentsProvider.notifier).reload(),
    ref.read(employeeStockCountProvider.notifier).reload(),
    ref.read(sharedInventoryProvider.future).then((_) {}, onError: (_) {}),
  ]);
}
