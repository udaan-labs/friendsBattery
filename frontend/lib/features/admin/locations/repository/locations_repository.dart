import 'package:dio/dio.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

/// Admin shops / warehouses via OpenAPI ShopsApi.
class LocationsRepository {
  LocationsRepository(this._api);

  final FriendsBatteryApi _api;

  ShopsApi get _shops => _api.getShopsApi();

  /// Active locations. Pass [type] `SHOP` or `WAREHOUSE` to filter; omit for both.
  Future<List<LocationItem>> list({String? type}) async {
    final response = await _shops.apiShopsLocationsGet(type: type);
    final data = response.data?.data;
    if (data == null) {
      throw Exception(response.data?.message ?? 'Failed to load locations');
    }
    return data.toList();
  }

  Never _fromDio(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) {
      throw Exception(data['message'].toString());
    }
    throw e;
  }

  Future<LocationItem> create({
    required String code,
    required String name,
    required String type,
    int? warehouseId,
    String? address,
    String? phone,
    double? latitude,
    double? longitude,
    int? allowedRadius,
  }) async {
    try {
      final body = CreateLocationRequest((b) {
        b.code = code;
        b.name = name;
        b.type = CreateLocationRequestTypeEnum.valueOf(type);
        if (warehouseId != null) b.warehouseId = warehouseId;
        if (address != null && address.isNotEmpty) b.address = address;
        if (phone != null && phone.isNotEmpty) b.phone = phone;
        if (latitude != null && longitude != null) {
          b.latitude = latitude;
          b.longitude = longitude;
          if (allowedRadius != null) b.allowedRadius = allowedRadius;
        }
      });
      final response =
          await _shops.apiShopsLocationsPost(createLocationRequest: body);
      final data = response.data?.data;
      if (data == null) {
        throw Exception(response.data?.message ?? 'Failed to create location');
      }
      return data;
    } on DioException catch (e) {
      _fromDio(e);
    }
  }

  Future<LocationItem> update({
    required int locationId,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    required int allowedRadius,
  }) async {
    try {
      final body = UpdateLocationRequest((b) {
        b.name = name;
        b.address = address;
        b.latitude = latitude;
        b.longitude = longitude;
        b.allowedRadius = allowedRadius;
      });
      final response = await _shops.apiShopsLocationsLocationIdPatch(
        locationId: locationId,
        updateLocationRequest: body,
      );
      final data = response.data?.data;
      if (data == null) {
        throw Exception(response.data?.message ?? 'Failed to update location');
      }
      return data;
    } on DioException catch (e) {
      _fromDio(e);
    }
  }
}
