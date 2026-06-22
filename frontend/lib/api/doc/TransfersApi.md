# friends_battery_api.api.TransfersApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiTransfersGet**](TransfersApi.md#apitransfersget) | **GET** /api/transfers | Return all shipments (Admin gets all, Seller gets own)
[**apiTransfersPost**](TransfersApi.md#apitransferspost) | **POST** /api/transfers | Create a new shipment from Admin to Seller
[**apiTransfersShipmentIdCancelPatch**](TransfersApi.md#apitransfersshipmentidcancelpatch) | **PATCH** /api/transfers/{shipmentId}/cancel | Admin cancels a pending shipment
[**apiTransfersShipmentIdGet**](TransfersApi.md#apitransfersshipmentidget) | **GET** /api/transfers/{shipmentId} | Return complete shipment details by ID
[**apiTransfersShipmentIdReceivePatch**](TransfersApi.md#apitransfersshipmentidreceivepatch) | **PATCH** /api/transfers/{shipmentId}/receive | Seller receives and confirms a shipment delivery


# **apiTransfersGet**
> apiTransfersGet()

Return all shipments (Admin gets all, Seller gets own)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getTransfersApi();

try {
    api.apiTransfersGet();
} on DioException catch (e) {
    print('Exception when calling TransfersApi->apiTransfersGet: $e\n');
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

# **apiTransfersPost**
> apiTransfersPost(apiTransfersPostRequest)

Create a new shipment from Admin to Seller

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getTransfersApi();
final ApiTransfersPostRequest apiTransfersPostRequest = ; // ApiTransfersPostRequest | 

try {
    api.apiTransfersPost(apiTransfersPostRequest);
} on DioException catch (e) {
    print('Exception when calling TransfersApi->apiTransfersPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiTransfersPostRequest** | [**ApiTransfersPostRequest**](ApiTransfersPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTransfersShipmentIdCancelPatch**
> apiTransfersShipmentIdCancelPatch(shipmentId)

Admin cancels a pending shipment

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getTransfersApi();
final int shipmentId = 56; // int | 

try {
    api.apiTransfersShipmentIdCancelPatch(shipmentId);
} on DioException catch (e) {
    print('Exception when calling TransfersApi->apiTransfersShipmentIdCancelPatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **shipmentId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTransfersShipmentIdGet**
> apiTransfersShipmentIdGet(shipmentId)

Return complete shipment details by ID

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getTransfersApi();
final int shipmentId = 56; // int | 

try {
    api.apiTransfersShipmentIdGet(shipmentId);
} on DioException catch (e) {
    print('Exception when calling TransfersApi->apiTransfersShipmentIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **shipmentId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTransfersShipmentIdReceivePatch**
> apiTransfersShipmentIdReceivePatch(shipmentId)

Seller receives and confirms a shipment delivery

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getTransfersApi();
final int shipmentId = 56; // int | 

try {
    api.apiTransfersShipmentIdReceivePatch(shipmentId);
} on DioException catch (e) {
    print('Exception when calling TransfersApi->apiTransfersShipmentIdReceivePatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **shipmentId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

