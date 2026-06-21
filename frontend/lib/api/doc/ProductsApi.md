# friends_battery_api.api.ProductsApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**productsGet**](ProductsApi.md#productsget) | **GET** /products | Retrieve a list of products


# **productsGet**
> BuiltList<ShopsGet200ResponseInner> productsGet()

Retrieve a list of products

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getProductsApi();

try {
    final response = api.productsGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->productsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ShopsGet200ResponseInner&gt;**](ShopsGet200ResponseInner.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

