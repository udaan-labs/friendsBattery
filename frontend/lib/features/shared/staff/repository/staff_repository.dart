import 'package:dio/dio.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

/// Employee create + staff list via OpenAPI ShopsApi.
class StaffRepository {
  StaffRepository(this._api);

  final FriendsBatteryApi _api;

  ShopsApi get _shops => _api.getShopsApi();

  Future<ShopStaffData> getMyStaff() async {
    final response = await _shops.apiShopsMyStaffGet();
    final data = response.data?.data;
    if (data == null) {
      throw Exception(response.data?.message ?? 'Failed to load staff');
    }
    return data;
  }

  Future<ShopStaffData> getStaffBySellerId(int sellerId) async {
    final response =
        await _shops.apiShopsSellersSellerIdStaffGet(sellerId: sellerId);
    final data = response.data?.data;
    if (data == null) {
      throw Exception(response.data?.message ?? 'Failed to load staff');
    }
    return data;
  }

  Future<ShopStaffData> getStaffByLocationId(int locationId) async {
    final response = await _shops.apiShopsLocationsLocationIdStaffGet(
      locationId: locationId,
    );
    final data = response.data?.data;
    if (data == null) {
      throw Exception(response.data?.message ?? 'Failed to load staff');
    }
    return data;
  }

  Future<List<EmployeeRoleItem>> listEmployeeRoles() async {
    final response = await _shops.apiShopsEmployeeRolesGet();
    final data = response.data?.data;
    if (data == null) {
      throw Exception(response.data?.message ?? 'Failed to load roles');
    }
    return [for (final r in data) if (r.id != null) r];
  }

  Future<List<LocationItem>> listLocations({String? type}) async {
    final response = await _shops.apiShopsLocationsGet(type: type);
    final data = response.data?.data;
    if (data == null) {
      throw Exception(response.data?.message ?? 'Failed to load locations');
    }
    return [for (final l in data) if (l.id != null) l];
  }

  Future<String> nextEmployeeUserId() async {
    final response = await _shops.apiShopsEmployeesNextUserIdGet();
    final id = response.data?.data?.userId;
    if (id == null || id.isEmpty) {
      throw Exception(response.data?.message ?? 'Failed to load next user id');
    }
    return id;
  }

  Future<void> transferEmployee({
    required int id,
    required int locationId,
  }) async {
    try {
      await _shops.apiShopsEmployeesEmployeeIdLocationPatch(
        employeeId: id,
        transferEmployeeRequest:
            TransferEmployeeRequest((b) => b.locationId = locationId),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) return;
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        throw Exception(data['message'].toString());
      }
      rethrow;
    }
  }

  Future<void> createEmployee({
    String? userId,
    required String username,
    required String userNumber,
    required String password,
    int? employeeRoleId,
    int? locationId,
  }) async {
    try {
      final body = CreateEmployeeRequest((b) {
        if (userId != null && userId.isNotEmpty) b.userId = userId;
        b.username = username;
        b.userNumber = userNumber;
        b.password = password;
        if (employeeRoleId != null) b.employeeRoleId = employeeRoleId;
        if (locationId != null) b.locationId = locationId;
      });
      final response =
          await _shops.apiShopsEmployeesPost(createEmployeeRequest: body);
      if (response.data?.data == null) {
        throw Exception(response.data?.message ?? 'Failed to create employee');
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        throw Exception(data['message'].toString());
      }
      rethrow;
    }
  }
}
