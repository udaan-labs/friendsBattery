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
> ActivityHistoryResponse apiDashboardActivityHistoryGet(cursor, fromDate, toDate, limit)

Get paginated activity history (Admin only)

Same scope as recent-activity. SUPER_ADMIN org-wide; ADMIN own warehouse/shop tree only.

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getDashboardApi();
final String cursor = cursor_example; // String | Opaque cursor from previous page (pagination.nextCursor)
final DateTime fromDate = 2013-10-20T19:20:30+01:00; // DateTime | Inclusive start of range (ISO)
final DateTime toDate = 2013-10-20T19:20:30+01:00; // DateTime | Inclusive end of range (ISO)
final int limit = 56; // int | 

try {
    final response = api.apiDashboardActivityHistoryGet(cursor, fromDate, toDate, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling DashboardApi->apiDashboardActivityHistoryGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**| Opaque cursor from previous page (pagination.nextCursor) | [optional] 
 **fromDate** | **DateTime**| Inclusive start of range (ISO) | [optional] 
 **toDate** | **DateTime**| Inclusive end of range (ISO) | [optional] 
 **limit** | **int**|  | [optional] [default to 20]

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

SUPER_ADMIN sees org-wide activity. Shop/warehouse ADMIN sees only own warehouse/shop plus sellers and employees under them.

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

