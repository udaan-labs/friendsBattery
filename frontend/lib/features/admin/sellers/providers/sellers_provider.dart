import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';

class SellerData {
  final User seller;
  final int totalStock;
  final int todaySales;
  final int pendingShipments;
  final bool? hasLowStock;

  SellerData({
    required this.seller,
    required this.totalStock,
    required this.todaySales,
    required this.pendingShipments,
    this.hasLowStock = false,
  });
}

final sellersProvider = FutureProvider<List<SellerData>>((ref) async {
  final response = await ref.watch(apiClientProvider).getShopsApi().apiShopsSellersGet();
  final rows = response.data?.data?.toList() ?? [];

  return rows.map((item) {
    final user = User((b) {
      b.id = item.id?.toString();
      b.userName = item.userName;
      b.shopName = item.shopName;
      b.userNumber = item.userNumber;
      b.isVerified = item.isVerified;
      b.isActive = item.isActive;
    });

    return SellerData(
      seller: user,
      totalStock: item.totalStock ?? 0,
      todaySales: item.todaySales ?? 0,
      pendingShipments: item.pendingShipments ?? 0,
      hasLowStock: item.hasLowStock == true,
    );
  }).toList();
});

class EmployeeStaffData {
  final ShopStaffMember member;
  final LocationItem? location;

  EmployeeStaffData({
    required this.member,
    this.location,
  });
}

final allEmployeesProvider = FutureProvider<List<EmployeeStaffData>>((ref) async {
  final repo = ref.watch(apiClientProvider).getShopsApi();
  final locationsResponse = await repo.apiShopsLocationsGet();
  final locations = locationsResponse.data?.data?.toList() ?? <LocationItem>[];

  final results = await Future.wait(locations.map((loc) async {
    final locId = loc.id;
    if (locId == null) return <EmployeeStaffData>[];
    try {
      final res = await repo.apiShopsLocationsLocationIdStaffGet(locationId: locId);
      final employees = res.data?.data?.employees?.toList() ?? <ShopStaffMember>[];
      return employees.map((emp) => EmployeeStaffData(member: emp, location: loc)).toList();
    } catch (_) {
      return <EmployeeStaffData>[];
    }
  }));

  final seen = <int>{};
  return results.expand((e) => e).where((e) => e.member.id != null && seen.add(e.member.id!)).toList();
});
