import 'package:dio/dio.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

/// Shop shipments for employee (sellers at same location) via OpenAPI client.
class EmployeeShipmentsRepository {
  final FriendsBatteryApi _api;

  EmployeeShipmentsRepository({required FriendsBatteryApi api}) : _api = api;

  ShipmentsApi get _shipments => _api.getShipmentsApi();

  Future<List<SellerShipmentListItem>> listShipments() async {
    try {
      final response = await _shipments.apiEmployeeShipmentsGet();
      final list = response.data?.data;
      if (list == null) return [];
      return list.toList();
    } catch (e) {
      throw Exception(_err(e, 'Failed to load shipments'));
    }
  }

  static String _err(Object e, String fallback) {
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) return data['message'].toString();
      return e.message ?? fallback;
    }
    final s = e.toString();
    return s.startsWith('Exception: ') ? s.substring(11) : s;
  }
}
