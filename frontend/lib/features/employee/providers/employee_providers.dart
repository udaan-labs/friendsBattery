import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../core/network/api_client_provider.dart';
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

final employeeAttendanceStatusProvider = FutureProvider<AttendanceStatusData>((ref) async {
  return ref.watch(employeeAttendanceRepositoryProvider).getStatus();
});

final employeeShipmentsProvider = FutureProvider<List<SellerShipmentListItem>>((ref) async {
  return ref.watch(employeeShipmentsRepositoryProvider).listShipments();
});

/// Stock units count from shared inventory (location-scoped API).
final employeeStockCountProvider = FutureProvider<int>((ref) async {
  final inv = await ref.watch(sharedInventoryProvider.future);
  return inv.items.fold<int>(0, (sum, item) => sum + item.quantity);
});

Future<void> refreshEmployeeDashboard(WidgetRef ref) async {
  ref.invalidate(employeeAttendanceStatusProvider);
  ref.invalidate(employeeShipmentsProvider);
  ref.invalidate(sharedInventoryProvider);
  ref.invalidate(employeeStockCountProvider);
  try {
    await ref.read(employeeAttendanceStatusProvider.future);
  } catch (_) {}
  try {
    await ref.read(employeeShipmentsProvider.future);
  } catch (_) {}
  try {
    await ref.read(sharedInventoryProvider.future);
  } catch (_) {}
}
