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

