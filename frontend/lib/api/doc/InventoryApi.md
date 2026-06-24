# friends_battery_api.api.InventoryApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiInventoryAdjustPatch**](InventoryApi.md#apiinventoryadjustpatch) | **PATCH** /api/inventory/adjust | Adjust inventory stock levels
[**apiInventoryAvailableSerialsGet**](InventoryApi.md#apiinventoryavailableserialsget) | **GET** /api/inventory/available-serials | Fetch available serial numbers for a product owned by the logged-in seller
[**apiInventoryDetailsGet**](InventoryApi.md#apiinventorydetailsget) | **GET** /api/inventory/details | Return a complete inventory summary grouped by Category, Subcategory, and Product Name
[**apiInventoryGet**](InventoryApi.md#apiinventoryget) | **GET** /api/inventory | Return logged-in user&#39;s inventory
[**apiInventoryHistoryGet**](InventoryApi.md#apiinventoryhistoryget) | **GET** /api/inventory/history | Return inventory movement history
[**apiInventoryProductDetailsGet**](InventoryApi.md#apiinventoryproductdetailsget) | **GET** /api/inventory/product-details | Fetch details of a product (stock count &amp; min sell price) by category, product name, and model IDs
[**apiInventoryProductIdGet**](InventoryApi.md#apiinventoryproductidget) | **GET** /api/inventory/{productId} | Return one inventory item
[**apiInventoryTransferPost**](InventoryApi.md#apiinventorytransferpost) | **POST** /api/inventory/transfer | Transfer inventory from admin to seller
[**apiInventoryUpdateStockPost**](InventoryApi.md#apiinventoryupdatestockpost) | **POST** /api/inventory/update-stock | Update admin&#39;s own inventory stock (Admin only)


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

# **apiInventoryAvailableSerialsGet**
> ApiInventoryAvailableSerialsGet200Response apiInventoryAvailableSerialsGet(categoryId, productNameId, productModelId)

Fetch available serial numbers for a product owned by the logged-in seller

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getInventoryApi();
final String categoryId = categoryId_example; // String | 
final String productNameId = productNameId_example; // String | 
final String productModelId = productModelId_example; // String | 

try {
    final response = api.apiInventoryAvailableSerialsGet(categoryId, productNameId, productModelId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling InventoryApi->apiInventoryAvailableSerialsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryId** | **String**|  | 
 **productNameId** | **String**|  | 
 **productModelId** | **String**|  | 

### Return type

[**ApiInventoryAvailableSerialsGet200Response**](ApiInventoryAvailableSerialsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiInventoryDetailsGet**
> ApiInventoryDetailsGet200Response apiInventoryDetailsGet(categoryId, subcategoryId, search, page, limit)

Return a complete inventory summary grouped by Category, Subcategory, and Product Name

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getInventoryApi();
final int categoryId = 56; // int | Filter by Category ID
final int subcategoryId = 56; // int | Filter by Subcategory (Product Name) ID
final String search = search_example; // String | Search by Product Model Name or Product Name
final int page = 56; // int | Page number for pagination
final int limit = 56; // int | Number of items per page

try {
    final response = api.apiInventoryDetailsGet(categoryId, subcategoryId, search, page, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling InventoryApi->apiInventoryDetailsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryId** | **int**| Filter by Category ID | [optional] 
 **subcategoryId** | **int**| Filter by Subcategory (Product Name) ID | [optional] 
 **search** | **String**| Search by Product Model Name or Product Name | [optional] 
 **page** | **int**| Page number for pagination | [optional] [default to 1]
 **limit** | **int**| Number of items per page | [optional] [default to 10]

### Return type

[**ApiInventoryDetailsGet200Response**](ApiInventoryDetailsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

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

# **apiInventoryProductDetailsGet**
> ApiInventoryProductDetailsGet200Response apiInventoryProductDetailsGet(categoryId, productNameId, productModelId)

Fetch details of a product (stock count & min sell price) by category, product name, and model IDs

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getInventoryApi();
final String categoryId = categoryId_example; // String | 
final String productNameId = productNameId_example; // String | 
final String productModelId = productModelId_example; // String | 

try {
    final response = api.apiInventoryProductDetailsGet(categoryId, productNameId, productModelId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling InventoryApi->apiInventoryProductDetailsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryId** | **String**|  | 
 **productNameId** | **String**|  | 
 **productModelId** | **String**|  | 

### Return type

[**ApiInventoryProductDetailsGet200Response**](ApiInventoryProductDetailsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiInventoryProductIdGet**
> ApiInventoryProductIdGet200Response apiInventoryProductIdGet(productId)

Return one inventory item

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getInventoryApi();
final int productId = 56; // int | 

try {
    final response = api.apiInventoryProductIdGet(productId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling InventoryApi->apiInventoryProductIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **productId** | **int**|  | 

### Return type

[**ApiInventoryProductIdGet200Response**](ApiInventoryProductIdGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

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

# **apiInventoryUpdateStockPost**
> ApiInventoryUpdateStockPost200Response apiInventoryUpdateStockPost(apiInventoryUpdateStockPostRequest)

Update admin's own inventory stock (Admin only)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getInventoryApi();
final ApiInventoryUpdateStockPostRequest apiInventoryUpdateStockPostRequest = ; // ApiInventoryUpdateStockPostRequest | 

try {
    final response = api.apiInventoryUpdateStockPost(apiInventoryUpdateStockPostRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling InventoryApi->apiInventoryUpdateStockPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiInventoryUpdateStockPostRequest** | [**ApiInventoryUpdateStockPostRequest**](ApiInventoryUpdateStockPostRequest.md)|  | 

### Return type

[**ApiInventoryUpdateStockPost200Response**](ApiInventoryUpdateStockPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

