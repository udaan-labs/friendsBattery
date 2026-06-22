# friends_battery_api.api.DashboardApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiDashboardStatsGet**](DashboardApi.md#apidashboardstatsget) | **GET** /api/dashboard/stats | Get dashboard statistics


# **apiDashboardStatsGet**
> ApiDashboardStatsGet200Response apiDashboardStatsGet()

Get dashboard statistics

Retrieves total available stock, today's sales, pending seller requests, and total sellers. Only accessible by Admin users.

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getDashboardApi();

try {
    final response = api.apiDashboardStatsGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling DashboardApi->apiDashboardStatsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiDashboardStatsGet200Response**](ApiDashboardStatsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

