import 'package:dio/dio.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

/// Admin shops / warehouses via OpenAPI ShopsApi.
class LocationsRepository {
  LocationsRepository(this._api);

  final FriendsBatteryApi _api;

  ShopsApi get _shops => _api.getShopsApi();

  /// [type] is `SHOP` or `WAREHOUSE`.
  Future<List<LocationItem>> list({required String type}) async {
    final response = await _shops.apiShopsLocationsGet(type: type);
    final data = response.data?.data;
    if (data == null) {
      throw Exception(response.data?.message ?? 'Failed to load locations');
    }
    return data.toList();
  }

  Future<LocationItem> create({
    required String code,
    required String name,
    required String type,
    String? address,
    String? phone,
  }) async {
    try {
      final body = CreateLocationRequest((b) {
        b.code = code;
        b.name = name;
        b.type = CreateLocationRequestTypeEnum.valueOf(type);
        if (address != null && address.isNotEmpty) b.address = address;
        if (phone != null && phone.isNotEmpty) b.phone = phone;
      });
      final response =
          await _shops.apiShopsLocationsPost(createLocationRequest: body);
      final data = response.data?.data;
      if (data == null) {
        throw Exception(response.data?.message ?? 'Failed to create location');
      }
      return data;
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        throw Exception(data['message'].toString());
      }
      rethrow;
    }
  }
}
