import 'package:dio/dio.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:frontend/shared/utils/app_formatters.dart';

import 'device_location.dart';
import 'location_exceptions.dart';
import 'location_service.dart';

class AttendanceRepository {
  AttendanceRepository({
    required FriendsBatteryApi api,
    LocationService locationService = const LocationService(),
  })  : _api = api,
        _location = locationService;

  final FriendsBatteryApi _api;
  final LocationService _location;

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

  Future<AttendanceRecord?> checkIn(AssignedLocation? assigned) =>
      _submit(assigned, checkIn: true);

  Future<AttendanceRecord?> checkOut(AssignedLocation? assigned) =>
      _submit(assigned, checkIn: false);

  Future<bool> openAppSettings() => _location.openAppSettings();

  Future<AttendanceRecord?> _submit(
    AssignedLocation? assigned, {
    required bool checkIn,
  }) async {
    final device = await _requireInside(assigned);
    final body = _geoBody(device);
    try {
      final response = checkIn
          ? await _attendance.apiEmployeeAttendanceCheckInPost(
              attendanceGeoBody: body,
            )
          : await _attendance.apiEmployeeAttendanceCheckOutPost(
              attendanceGeoBody: body,
            );
      return response.data?.data;
    } catch (e) {
      throw Exception(_err(e, checkIn ? 'Check-in failed' : 'Check-out failed'));
    }
  }

  Future<DeviceLocation> _requireInside(AssignedLocation? assigned) async {
    if (assigned == null || assigned.id == null) {
      throw const LocationException(
        'No assigned shop location found. Contact your admin.',
      );
    }

    final lat = assigned.latitude?.toDouble();
    final lng = assigned.longitude?.toDouble();
    if (lat == null ||
        lng == null ||
        lat.isNaN ||
        lng.isNaN ||
        lat.abs() > 90 ||
        lng.abs() > 180) {
      throw const LocationException(
        'Assigned location has no GPS coordinates configured. Contact admin.',
      );
    }

    final device = await _location.getCurrentLocation();
    final inside = _location.isWithinRadius(
      device: device,
      targetLatitude: lat,
      targetLongitude: lng,
      allowedRadiusMeters: assigned.allowedRadius ?? 100,
    );
    if (!inside) {
      throw const LocationException('You are not at your assigned location.');
    }
    return device;
  }

  AttendanceGeoBody _geoBody(DeviceLocation device) {
    return AttendanceGeoBody((b) {
      b.latitude = device.latitude;
      b.longitude = device.longitude;
      b.accuracy = device.accuracy;
      b.timestamp = device.timestamp.toUtc().toIso8601String();
    });
  }

  static String _err(Object e, String fallback) {
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
      return e.message ?? fallback;
    }
    return friendlyError(e);
  }
}
