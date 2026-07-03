# friends_battery_api.api.ProductsApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiProductsInventoryProductsGet**](ProductsApi.md#apiproductsinventoryproductsget) | **GET** /api/products/inventory-products | Get products in the authenticated user&#39;s inventory
[**apiProductsListPost**](ProductsApi.md#apiproductslistpost) | **POST** /api/products/list | Return all products matching filters
[**apiProductsPost**](ProductsApi.md#apiproductspost) | **POST** /api/products | Create a new product
[**apiProductsProductModelsListPost**](ProductsApi.md#apiproductsproductmodelslistpost) | **POST** /api/products/product-models/list | Return all models belonging to a product name
[**apiProductsProductModelsPost**](ProductsApi.md#apiproductsproductmodelspost) | **POST** /api/products/product-models | Create a product model
[**apiProductsProductNamesGet**](ProductsApi.md#apiproductsproductnamesget) | **GET** /api/products/product-names | Return all product names
[**apiProductsProductNamesPost**](ProductsApi.md#apiproductsproductnamespost) | **POST** /api/products/product-names | Create a product name


# **apiProductsInventoryProductsGet**
> apiProductsInventoryProductsGet()

Get products in the authenticated user's inventory

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();

try {
    api.apiProductsInventoryProductsGet();
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsInventoryProductsGet: $e\n');
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

# **apiProductsListPost**
> apiProductsListPost(apiProductsListPostRequest)

Return all products matching filters

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();
final ApiProductsListPostRequest apiProductsListPostRequest = ; // ApiProductsListPostRequest | 

try {
    api.apiProductsListPost(apiProductsListPostRequest);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsListPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiProductsListPostRequest** | [**ApiProductsListPostRequest**](ApiProductsListPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiProductsPost**
> apiProductsPost(apiProductsPostRequest)

Create a new product

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();
final ApiProductsPostRequest apiProductsPostRequest = ; // ApiProductsPostRequest | 

try {
    api.apiProductsPost(apiProductsPostRequest);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiProductsPostRequest** | [**ApiProductsPostRequest**](ApiProductsPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiProductsProductModelsListPost**
> apiProductsProductModelsListPost(apiProductsProductModelsListPostRequest)

Return all models belonging to a product name

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();
final ApiProductsProductModelsListPostRequest apiProductsProductModelsListPostRequest = ; // ApiProductsProductModelsListPostRequest | 

try {
    api.apiProductsProductModelsListPost(apiProductsProductModelsListPostRequest);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsProductModelsListPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiProductsProductModelsListPostRequest** | [**ApiProductsProductModelsListPostRequest**](ApiProductsProductModelsListPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiProductsProductModelsPost**
> apiProductsProductModelsPost(apiProductsProductModelsPostRequest)

Create a product model

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();
final ApiProductsProductModelsPostRequest apiProductsProductModelsPostRequest = ; // ApiProductsProductModelsPostRequest | 

try {
    api.apiProductsProductModelsPost(apiProductsProductModelsPostRequest);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsProductModelsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiProductsProductModelsPostRequest** | [**ApiProductsProductModelsPostRequest**](ApiProductsProductModelsPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiProductsProductNamesGet**
> apiProductsProductNamesGet()

Return all product names

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();

try {
    api.apiProductsProductNamesGet();
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsProductNamesGet: $e\n');
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

# **apiProductsProductNamesPost**
> apiProductsProductNamesPost(apiProductsProductNamesPostRequest)

Create a product name

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();
final ApiProductsProductNamesPostRequest apiProductsProductNamesPostRequest = ; // ApiProductsProductNamesPostRequest | 

try {
    api.apiProductsProductNamesPost(apiProductsProductNamesPostRequest);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsProductNamesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiProductsProductNamesPostRequest** | [**ApiProductsProductNamesPostRequest**](ApiProductsProductNamesPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

