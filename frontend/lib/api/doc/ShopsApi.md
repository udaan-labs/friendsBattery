# friends_battery_api.api.ShopsApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**shopsGet**](ShopsApi.md#shopsget) | **GET** /shops | Retrieve a list of shops


# **shopsGet**
> List<ShopsGet200ResponseInner> shopsGet()

Retrieve a list of shops

### Example
```dart
import 'package:friends_battery_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ShopsApi();

try {
    final result = api_instance.shopsGet();
    print(result);
} catch (e) {
    print('Exception when calling ShopsApi->shopsGet: $e\n');
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

