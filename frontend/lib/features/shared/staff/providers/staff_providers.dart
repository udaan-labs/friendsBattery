import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';
import '../repository/staff_repository.dart';

final staffRepositoryProvider = Provider<StaffRepository>((ref) {
  return StaffRepository(ref.watch(apiClientProvider));
});

final employeeRolesProvider =
    FutureProvider<List<EmployeeRoleItem>>((ref) async {
  return ref.watch(staffRepositoryProvider).listEmployeeRoles();
});

final locationsListProvider = FutureProvider<List<LocationItem>>((ref) async {
  return ref.watch(staffRepositoryProvider).listLocations();
});

final sellerMyStaffProvider = FutureProvider<ShopStaffData>((ref) async {
  return ref.watch(staffRepositoryProvider).getMyStaff();
});

/// Admin: staff at the same location as this seller.
final shopStaffProvider =
    FutureProvider.family<ShopStaffData, int>((ref, sellerId) async {
  return ref.watch(staffRepositoryProvider).getStaffBySellerId(sellerId);
});

/// Admin: staff assigned to a shop/warehouse location.
final locationStaffProvider =
    FutureProvider.family<ShopStaffData, int>((ref, locationId) async {
  return ref.watch(staffRepositoryProvider).getStaffByLocationId(locationId);
});
