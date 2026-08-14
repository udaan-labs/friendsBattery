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
> InventoryProductsResponse apiProductsInventoryProductsGet()

Get products in the authenticated user's inventory

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();

try {
    final response = api.apiProductsInventoryProductsGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsInventoryProductsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**InventoryProductsResponse**](InventoryProductsResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiProductsListPost**
> ListProductsResponse apiProductsListPost(listProductsRequest)

Return all products matching filters

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();
final ListProductsRequest listProductsRequest = ; // ListProductsRequest | 

try {
    final response = api.apiProductsListPost(listProductsRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsListPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listProductsRequest** | [**ListProductsRequest**](ListProductsRequest.md)|  | 

### Return type

[**ListProductsResponse**](ListProductsResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiProductsPost**
> CreateProductResponse apiProductsPost(createProductRequest)

Create a new product

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();
final CreateProductRequest createProductRequest = ; // CreateProductRequest | 

try {
    final response = api.apiProductsPost(createProductRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createProductRequest** | [**CreateProductRequest**](CreateProductRequest.md)|  | 

### Return type

[**CreateProductResponse**](CreateProductResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiProductsProductModelsListPost**
> ProductModelsResponse apiProductsProductModelsListPost(listProductModelsRequest)

Return all models belonging to a product name

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();
final ListProductModelsRequest listProductModelsRequest = ; // ListProductModelsRequest | 

try {
    final response = api.apiProductsProductModelsListPost(listProductModelsRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsProductModelsListPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listProductModelsRequest** | [**ListProductModelsRequest**](ListProductModelsRequest.md)|  | 

### Return type

[**ProductModelsResponse**](ProductModelsResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiProductsProductModelsPost**
> ProductModelResponse apiProductsProductModelsPost(createProductModelRequest)

Create a product model

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();
final CreateProductModelRequest createProductModelRequest = ; // CreateProductModelRequest | 

try {
    final response = api.apiProductsProductModelsPost(createProductModelRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsProductModelsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createProductModelRequest** | [**CreateProductModelRequest**](CreateProductModelRequest.md)|  | 

### Return type

[**ProductModelResponse**](ProductModelResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiProductsProductNamesGet**
> ProductNamesResponse apiProductsProductNamesGet()

Return all product names

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();

try {
    final response = api.apiProductsProductNamesGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsProductNamesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ProductNamesResponse**](ProductNamesResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiProductsProductNamesPost**
> ProductNameResponse apiProductsProductNamesPost(createProductNameRequest)

Create a product name

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();
final CreateProductNameRequest createProductNameRequest = ; // CreateProductNameRequest | 

try {
    final response = api.apiProductsProductNamesPost(createProductNameRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiProductsProductNamesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createProductNameRequest** | [**CreateProductNameRequest**](CreateProductNameRequest.md)|  | 

### Return type

[**ProductNameResponse**](ProductNameResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

