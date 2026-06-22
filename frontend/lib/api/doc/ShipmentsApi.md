# friends_battery_api.api.ShipmentsApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSellerDashboardPendingShipmentsGet**](ShipmentsApi.md#apisellerdashboardpendingshipmentsget) | **GET** /api/seller/dashboard/pending-shipments | Get pending shipments count (Seller only)
[**apiSellerShipmentsGet**](ShipmentsApi.md#apisellershipmentsget) | **GET** /api/seller/shipments | List shipments for seller (Seller only)
[**apiShipmentsPost**](ShipmentsApi.md#apishipmentspost) | **POST** /api/shipments | Create a new shipment (Admin only)
[**apiShipmentsShipmentIdAcceptPost**](ShipmentsApi.md#apishipmentsshipmentidacceptpost) | **POST** /api/shipments/{shipmentId}/accept | Accept a pending shipment (Seller only)


# **apiSellerDashboardPendingShipmentsGet**
> ApiSellerDashboardPendingShipmentsGet200Response apiSellerDashboardPendingShipmentsGet()

Get pending shipments count (Seller only)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShipmentsApi();

try {
    final response = api.apiSellerDashboardPendingShipmentsGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShipmentsApi->apiSellerDashboardPendingShipmentsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiSellerDashboardPendingShipmentsGet200Response**](ApiSellerDashboardPendingShipmentsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSellerShipmentsGet**
> ApiSellerShipmentsGet200Response apiSellerShipmentsGet()

List shipments for seller (Seller only)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShipmentsApi();

try {
    final response = api.apiSellerShipmentsGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShipmentsApi->apiSellerShipmentsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiSellerShipmentsGet200Response**](ApiSellerShipmentsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiShipmentsPost**
> apiShipmentsPost(apiShipmentsPostRequest)

Create a new shipment (Admin only)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShipmentsApi();
final ApiShipmentsPostRequest apiShipmentsPostRequest = ; // ApiShipmentsPostRequest | 

try {
    api.apiShipmentsPost(apiShipmentsPostRequest);
} on DioException catch (e) {
    print('Exception when calling ShipmentsApi->apiShipmentsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiShipmentsPostRequest** | [**ApiShipmentsPostRequest**](ApiShipmentsPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiShipmentsShipmentIdAcceptPost**
> apiShipmentsShipmentIdAcceptPost(shipmentId, body)

Accept a pending shipment (Seller only)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShipmentsApi();
final int shipmentId = 56; // int | 
final JsonObject body = Object; // JsonObject | 

try {
    api.apiShipmentsShipmentIdAcceptPost(shipmentId, body);
} on DioException catch (e) {
    print('Exception when calling ShipmentsApi->apiShipmentsShipmentIdAcceptPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **shipmentId** | **int**|  | 
 **body** | **JsonObject**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

