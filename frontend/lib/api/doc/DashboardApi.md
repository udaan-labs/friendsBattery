# friends_battery_api.api.DashboardApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiDashboardActivityHistoryGet**](DashboardApi.md#apidashboardactivityhistoryget) | **GET** /api/dashboard/activity-history | Get paginated activity history (Admin only)
[**apiDashboardRecentActivityGet**](DashboardApi.md#apidashboardrecentactivityget) | **GET** /api/dashboard/recent-activity | Get recent activity feed (Admin only)
[**apiDashboardStatsGet**](DashboardApi.md#apidashboardstatsget) | **GET** /api/dashboard/stats | Get dashboard statistics
[**apiSellerDashboardStatsGet**](DashboardApi.md#apisellerdashboardstatsget) | **GET** /api/seller/dashboard/stats | Get seller dashboard statistics


# **apiDashboardActivityHistoryGet**
> ActivityHistoryResponse apiDashboardActivityHistoryGet(page, limit)

Get paginated activity history (Admin only)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getDashboardApi();
final int page = 56; // int | 
final int limit = 56; // int | 

try {
    final response = api.apiDashboardActivityHistoryGet(page, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling DashboardApi->apiDashboardActivityHistoryGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] 
 **limit** | **int**|  | [optional] 

### Return type

[**ActivityHistoryResponse**](ActivityHistoryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiDashboardRecentActivityGet**
> RecentActivityResponse apiDashboardRecentActivityGet()

Get recent activity feed (Admin only)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getDashboardApi();

try {
    final response = api.apiDashboardRecentActivityGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling DashboardApi->apiDashboardRecentActivityGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**RecentActivityResponse**](RecentActivityResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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

# **apiSellerDashboardStatsGet**
> ApiSellerDashboardStatsGet200Response apiSellerDashboardStatsGet()

Get seller dashboard statistics

Retrieves total available stock and today's sales for the authenticated seller. Only accessible by Seller users.

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getDashboardApi();

try {
    final response = api.apiSellerDashboardStatsGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling DashboardApi->apiSellerDashboardStatsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiSellerDashboardStatsGet200Response**](ApiSellerDashboardStatsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

