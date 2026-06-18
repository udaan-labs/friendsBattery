# friends_battery_api.api.InventoryApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiInventoryGet**](InventoryApi.md#apiinventoryget) | **GET** /api/inventory | Retrieve inventory transactions


# **apiInventoryGet**
> List<InventoryTransaction> apiInventoryGet()

Retrieve inventory transactions

### Example
```dart
import 'package:friends_battery_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = InventoryApi();

try {
    final result = api_instance.apiInventoryGet();
    print(result);
} catch (e) {
    print('Exception when calling InventoryApi->apiInventoryGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<InventoryTransaction>**](InventoryTransaction.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

