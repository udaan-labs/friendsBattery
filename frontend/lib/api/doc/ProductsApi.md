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
> List<ShopsGet200ResponseInner> productsGet()

Retrieve a list of products

### Example
```dart
import 'package:friends_battery_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductsApi();

try {
    final result = api_instance.productsGet();
    print(result);
} catch (e) {
    print('Exception when calling ProductsApi->productsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<ShopsGet200ResponseInner>**](ShopsGet200ResponseInner.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

