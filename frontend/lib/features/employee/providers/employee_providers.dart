import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../core/network/api_client_provider.dart';
import '../../../core/storage/local_storage.dart';
import '../../shared/inventory/providers/inventory_provider.dart';
import '../repository/employee_attendance_repository.dart';
import '../repository/employee_shipments_repository.dart';

class EmployeeProfile {
  final String userName;
  final String shopName;
  final String role;

  EmployeeProfile({
    required this.userName,
    required this.shopName,
    required this.role,
  });
}

final employeeProfileProvider = Provider<EmployeeProfile>((ref) {
  final dynamic user = LocalStorage.get('user');
  if (user is Map) {
    return EmployeeProfile(
      userName: (user['username'] ?? user['userName'] ?? 'Employee').toString(),
      shopName: (user['shop_name'] ?? user['shopName'] ?? '').toString(),
      role: (user['role'] ?? 'employee').toString(),
    );
  }
  return EmployeeProfile(userName: 'Employee', shopName: '', role: 'employee');
});

final employeeAttendanceRepositoryProvider = Provider<EmployeeAttendanceRepository>((ref) {
  return EmployeeAttendanceRepository(api: ref.watch(apiClientProvider));
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
