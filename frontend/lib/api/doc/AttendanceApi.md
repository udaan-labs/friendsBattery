# friends_battery_api.api.AttendanceApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiEmployeeAttendanceCheckInPost**](AttendanceApi.md#apiemployeeattendancecheckinpost) | **POST** /api/employee/attendance/check-in | Check in at assigned shop location
[**apiEmployeeAttendanceCheckOutPost**](AttendanceApi.md#apiemployeeattendancecheckoutpost) | **POST** /api/employee/attendance/check-out | Check out (close open attendance)
[**apiEmployeeAttendanceCheckedInGet**](AttendanceApi.md#apiemployeeattendancecheckedinget) | **GET** /api/employee/attendance/checked-in | List currently checked-in employees (Admin / Super Admin / Seller)
[**apiEmployeeAttendanceLocationPost**](AttendanceApi.md#apiemployeeattendancelocationpost) | **POST** /api/employee/attendance/location | Update last GPS while checked in (foreground ping)
[**apiEmployeeAttendanceStatusGet**](AttendanceApi.md#apiemployeeattendancestatusget) | **GET** /api/employee/attendance/status | Current check-in status for employee


# **apiEmployeeAttendanceCheckInPost**
> ApiEmployeeAttendanceCheckInPost201Response apiEmployeeAttendanceCheckInPost(attendanceGeoBody)

Check in at assigned shop location

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getAttendanceApi();
final AttendanceGeoBody attendanceGeoBody = ; // AttendanceGeoBody | 

try {
    final response = api.apiEmployeeAttendanceCheckInPost(attendanceGeoBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->apiEmployeeAttendanceCheckInPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **attendanceGeoBody** | [**AttendanceGeoBody**](AttendanceGeoBody.md)|  | [optional] 

### Return type

[**ApiEmployeeAttendanceCheckInPost201Response**](ApiEmployeeAttendanceCheckInPost201Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiEmployeeAttendanceCheckOutPost**
> ApiEmployeeAttendanceCheckInPost201Response apiEmployeeAttendanceCheckOutPost(attendanceGeoBody)

Check out (close open attendance)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getAttendanceApi();
final AttendanceGeoBody attendanceGeoBody = ; // AttendanceGeoBody | 

try {
    final response = api.apiEmployeeAttendanceCheckOutPost(attendanceGeoBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->apiEmployeeAttendanceCheckOutPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **attendanceGeoBody** | [**AttendanceGeoBody**](AttendanceGeoBody.md)|  | [optional] 

### Return type

[**ApiEmployeeAttendanceCheckInPost201Response**](ApiEmployeeAttendanceCheckInPost201Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiEmployeeAttendanceCheckedInGet**
> ApiEmployeeAttendanceCheckedInGet200Response apiEmployeeAttendanceCheckedInGet()

List currently checked-in employees (Admin / Super Admin / Seller)

Returns open attendance rows with last GPS (or check-in GPS) and employee profile. Super Admin: all. Shop Admin: own shop staff. Seller: employees at own location. 

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getAttendanceApi();

try {
    final response = api.apiEmployeeAttendanceCheckedInGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->apiEmployeeAttendanceCheckedInGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiEmployeeAttendanceCheckedInGet200Response**](ApiEmployeeAttendanceCheckedInGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiEmployeeAttendanceLocationPost**
> ApiEmployeeAttendanceCheckInPost201Response apiEmployeeAttendanceLocationPost(attendanceGeoBody)

Update last GPS while checked in (foreground ping)

Employee app-open ping. Does not run in background. No geofence reject — stores last known point for admin/seller map. Server ignores pings closer than 15 seconds apart. 

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getAttendanceApi();
final AttendanceGeoBody attendanceGeoBody = ; // AttendanceGeoBody | 

try {
    final response = api.apiEmployeeAttendanceLocationPost(attendanceGeoBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->apiEmployeeAttendanceLocationPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **attendanceGeoBody** | [**AttendanceGeoBody**](AttendanceGeoBody.md)|  | 

### Return type

[**ApiEmployeeAttendanceCheckInPost201Response**](ApiEmployeeAttendanceCheckInPost201Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiEmployeeAttendanceStatusGet**
> ApiEmployeeAttendanceStatusGet200Response apiEmployeeAttendanceStatusGet()

Current check-in status for employee

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getAttendanceApi();

try {
    final response = api.apiEmployeeAttendanceStatusGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->apiEmployeeAttendanceStatusGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiEmployeeAttendanceStatusGet200Response**](ApiEmployeeAttendanceStatusGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

