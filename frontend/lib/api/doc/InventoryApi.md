# friends_battery_api.api.InventoryApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiInventoryAdjustPatch**](InventoryApi.md#apiinventoryadjustpatch) | **PATCH** /api/inventory/adjust | Adjust inventory stock levels
[**apiInventoryGet**](InventoryApi.md#apiinventoryget) | **GET** /api/inventory | Return logged-in user&#39;s inventory
[**apiInventoryHistoryGet**](InventoryApi.md#apiinventoryhistoryget) | **GET** /api/inventory/history | Return inventory movement history
[**apiInventoryProductIdGet**](InventoryApi.md#apiinventoryproductidget) | **GET** /api/inventory/{productId} | Return one inventory item
[**apiInventoryTransferPost**](InventoryApi.md#apiinventorytransferpost) | **POST** /api/inventory/transfer | Transfer inventory from admin to seller


# **apiInventoryAdjustPatch**
> apiInventoryAdjustPatch(apiInventoryAdjustPatchRequest)

Adjust inventory stock levels

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getInventoryApi();
final ApiInventoryAdjustPatchRequest apiInventoryAdjustPatchRequest = ; // ApiInventoryAdjustPatchRequest | 

try {
    api.apiInventoryAdjustPatch(apiInventoryAdjustPatchRequest);
} on DioException catch (e) {
    print('Exception when calling InventoryApi->apiInventoryAdjustPatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiInventoryAdjustPatchRequest** | [**ApiInventoryAdjustPatchRequest**](ApiInventoryAdjustPatchRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiInventoryGet**
> apiInventoryGet(search, page, limit)

Return logged-in user's inventory

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getInventoryApi();
final String search = search_example; // String | 
final int page = 56; // int | 
final int limit = 56; // int | 

try {
    api.apiInventoryGet(search, page, limit);
} on DioException catch (e) {
    print('Exception when calling InventoryApi->apiInventoryGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **search** | **String**|  | [optional] 
 **page** | **int**|  | [optional] 
 **limit** | **int**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiInventoryHistoryGet**
> apiInventoryHistoryGet(fromDate, toDate, productId, sellerId, page, limit)

Return inventory movement history

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getInventoryApi();
final Date fromDate = 2013-10-20; // Date | 
final Date toDate = 2013-10-20; // Date | 
final int productId = 56; // int | 
final int sellerId = 56; // int | 
final int page = 56; // int | 
final int limit = 56; // int | 

try {
    api.apiInventoryHistoryGet(fromDate, toDate, productId, sellerId, page, limit);
} on DioException catch (e) {
    print('Exception when calling InventoryApi->apiInventoryHistoryGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **fromDate** | **Date**|  | [optional] 
 **toDate** | **Date**|  | [optional] 
 **productId** | **int**|  | [optional] 
 **sellerId** | **int**|  | [optional] 
 **page** | **int**|  | [optional] 
 **limit** | **int**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiInventoryProductIdGet**
> apiInventoryProductIdGet(productId)

Return one inventory item

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getInventoryApi();
final int productId = 56; // int | 

try {
    api.apiInventoryProductIdGet(productId);
} on DioException catch (e) {
    print('Exception when calling InventoryApi->apiInventoryProductIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **productId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiInventoryTransferPost**
> apiInventoryTransferPost(apiInventoryTransferPostRequest)

Transfer inventory from admin to seller

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getInventoryApi();
final ApiInventoryTransferPostRequest apiInventoryTransferPostRequest = ; // ApiInventoryTransferPostRequest | 

try {
    api.apiInventoryTransferPost(apiInventoryTransferPostRequest);
} on DioException catch (e) {
    print('Exception when calling InventoryApi->apiInventoryTransferPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiInventoryTransferPostRequest** | [**ApiInventoryTransferPostRequest**](ApiInventoryTransferPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

