# friends_battery_api.api.SalesApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSalesCustomerMobileGet**](SalesApi.md#apisalescustomermobileget) | **GET** /api/sales/customer/{mobile} | Return complete purchase history for a customer mobile
[**apiSalesGet**](SalesApi.md#apisalesget) | **GET** /api/sales | Return all sales based on role (Admin sees all, Seller sees own)
[**apiSalesPost**](SalesApi.md#apisalespost) | **POST** /api/sales | Create a new sale transaction
[**apiSalesTransactionIdGet**](SalesApi.md#apisalestransactionidget) | **GET** /api/sales/{transactionId} | Return a single sale&#39;s details by ID


# **apiSalesCustomerMobileGet**
> apiSalesCustomerMobileGet(mobile)

Return complete purchase history for a customer mobile

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getSalesApi();
final String mobile = mobile_example; // String | 

try {
    api.apiSalesCustomerMobileGet(mobile);
} on DioException catch (e) {
    print('Exception when calling SalesApi->apiSalesCustomerMobileGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **mobile** | **String**|  | 

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

