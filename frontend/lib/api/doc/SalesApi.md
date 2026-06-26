# friends_battery_api.api.SalesApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSalesAdminHistoryGet**](SalesApi.md#apisalesadminhistoryget) | **GET** /api/sales/admin/history | Return all sales across all sellers with pagination, search, filters, and shipment tracing (Admin only)
[**apiSalesGet**](SalesApi.md#apisalesget) | **GET** /api/sales | Return all sales based on role (Admin sees all, Seller sees own)
[**apiSalesHistoryGet**](SalesApi.md#apisaleshistoryget) | **GET** /api/sales/history | Return seller&#39;s own sales history with pagination, search, and date filtering
[**apiSalesPost**](SalesApi.md#apisalespost) | **POST** /api/sales | Create a new sale transaction
[**apiSalesTransactionIdGet**](SalesApi.md#apisalestransactionidget) | **GET** /api/sales/{transactionId} | Return a single sale&#39;s details by ID


# **apiSalesAdminHistoryGet**
> apiSalesAdminHistoryGet(page, limit, search, sellerId, fromDate, toDate, shipmentStatus)

Return all sales across all sellers with pagination, search, filters, and shipment tracing (Admin only)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String search = search_example; // String | Search by customer name, seller name, shop name, product name, or serial number
final int sellerId = 56; // int | Filter by specific seller ID
final DateTime fromDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime toDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final String shipmentStatus = shipmentStatus_example; // String | 

try {
    api.apiSalesAdminHistoryGet(page, limit, search, sellerId, fromDate, toDate, shipmentStatus);
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesAdminHistoryGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 1]
 **limit** | **int**|  | [optional] [default to 10]
 **search** | **String**| Search by customer name, seller name, shop name, product name, or serial number | [optional] 
 **sellerId** | **int**| Filter by specific seller ID | [optional] 
 **fromDate** | **DateTime**|  | [optional] 
 **toDate** | **DateTime**|  | [optional] 
 **shipmentStatus** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSalesGet**
> apiSalesGet()

Return all sales based on role (Admin sees all, Seller sees own)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();

try {
    api.apiSalesGet();
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSalesHistoryGet**
> apiSalesHistoryGet(page, limit, searchCustomer, searchSerial, fromDate, toDate)

Return seller's own sales history with pagination, search, and date filtering

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String searchCustomer = searchCustomer_example; // String | 
final String searchSerial = searchSerial_example; // String | 
final DateTime fromDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime toDate = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    api.apiSalesHistoryGet(page, limit, searchCustomer, searchSerial, fromDate, toDate);
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesHistoryGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 1]
 **limit** | **int**|  | [optional] [default to 10]
 **searchCustomer** | **String**|  | [optional] 
 **searchSerial** | **String**|  | [optional] 
 **fromDate** | **DateTime**|  | [optional] 
 **toDate** | **DateTime**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSalesPost**
> apiSalesPost(apiSalesPostRequest)

Create a new sale transaction

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();
final ApiSalesPostRequest apiSalesPostRequest = ; // ApiSalesPostRequest | 

try {
    api.apiSalesPost(apiSalesPostRequest);
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiSalesPostRequest** | [**ApiSalesPostRequest**](ApiSalesPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSalesTransactionIdGet**
> apiSalesTransactionIdGet(transactionId)

Return a single sale's details by ID

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();
final String transactionId = transactionId_example; // String | 

try {
    api.apiSalesTransactionIdGet(transactionId);
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesTransactionIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **transactionId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

