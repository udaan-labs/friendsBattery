# friends_battery_api.api.CustomersApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiCustomersGet**](CustomersApi.md#apicustomersget) | **GET** /api/customers | Retrieve a list of customers


# **apiCustomersGet**
> BuiltList<Customer> apiCustomersGet()

Retrieve a list of customers

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getCustomersApi();

try {
    final response = api.apiCustomersGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling CustomersApi->apiCustomersGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Customer&gt;**](Customer.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

