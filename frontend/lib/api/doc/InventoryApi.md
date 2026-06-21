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
> BuiltList<InventoryTransaction> apiInventoryGet()

Retrieve inventory transactions

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getInventoryApi();

try {
    final response = api.apiInventoryGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling InventoryApi->apiInventoryGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;InventoryTransaction&gt;**](InventoryTransaction.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

