import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for AttendanceApi
void main() {
  final instance = FriendsBatteryApi().getAttendanceApi();

  group(AttendanceApi, () {
    // Check in at assigned shop location
    //
    //Future<ApiEmployeeAttendanceCheckInPost201Response> apiEmployeeAttendanceCheckInPost({ AttendanceGeoBody attendanceGeoBody }) async
    test('test apiEmployeeAttendanceCheckInPost', () async {
      // TODO
    });

    // Check out (close open attendance)
    //
    //Future<ApiEmployeeAttendanceCheckInPost201Response> apiEmployeeAttendanceCheckOutPost({ AttendanceGeoBody attendanceGeoBody }) async
    test('test apiEmployeeAttendanceCheckOutPost', () async {
      // TODO
    });

    // Current check-in status for employee
    //
    //Future<ApiEmployeeAttendanceStatusGet200Response> apiEmployeeAttendanceStatusGet() async
    test('test apiEmployeeAttendanceStatusGet', () async {
      // TODO
    });

  });
}
