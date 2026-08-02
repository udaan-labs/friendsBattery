import 'package:dio/dio.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

/// Thin wrapper over generated [AttendanceApi].
class EmployeeAttendanceRepository {
  final FriendsBatteryApi _api;

  EmployeeAttendanceRepository({required FriendsBatteryApi api}) : _api = api;

  AttendanceApi get _attendance => _api.getAttendanceApi();

  Future<AttendanceStatusData> getStatus() async {
    try {
      final response = await _attendance.apiEmployeeAttendanceStatusGet();
      final data = response.data?.data;
      if (data == null) {
        throw Exception(response.data?.message ?? 'No attendance status');
      }
      return data;
    } catch (e) {
      throw Exception(_err(e, 'Failed to load attendance status'));
    }
  }

  Future<AttendanceRecord?> checkIn({num? lat, num? lng, String? address}) async {
    try {
      final body = AttendanceGeoBody((b) {
        if (lat != null) b.lat = lat;
        if (lng != null) b.lng = lng;
        if (address != null) b.address = address;
      });
      final response = await _attendance.apiEmployeeAttendanceCheckInPost(
        attendanceGeoBody: body,
      );
      return response.data?.data;
    } catch (e) {
      throw Exception(_err(e, 'Check-in failed'));
    }
  }

  Future<AttendanceRecord?> checkOut({num? lat, num? lng, String? address}) async {
    try {
      final body = AttendanceGeoBody((b) {
        if (lat != null) b.lat = lat;
        if (lng != null) b.lng = lng;
        if (address != null) b.address = address;
      });
      final response = await _attendance.apiEmployeeAttendanceCheckOutPost(
        attendanceGeoBody: body,
      );
      return response.data?.data;
    } catch (e) {
      throw Exception(_err(e, 'Check-out failed'));
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
