# friends_battery_api.api.ShipmentsApi

## Load the API package
```dart
import 'package:friends_battery_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiEmployeeShipmentsGet**](ShipmentsApi.md#apiemployeeshipmentsget) | **GET** /api/employee/shipments | List shipments for sellers at the employee&#39;s shop location (read-only)
[**apiSellerDashboardPendingShipmentsGet**](ShipmentsApi.md#apisellerdashboardpendingshipmentsget) | **GET** /api/seller/dashboard/pending-shipments | Get pending shipments count (Seller only)
[**apiSellerShipmentsGet**](ShipmentsApi.md#apisellershipmentsget) | **GET** /api/seller/shipments | List shipments for seller (Seller only)
[**apiShipmentsGet**](ShipmentsApi.md#apishipmentsget) | **GET** /api/shipments | List all shipments (Admin only)
[**apiShipmentsIdGet**](ShipmentsApi.md#apishipmentsidget) | **GET** /api/shipments/{id} | Get shipment details by ID (Admin or Seller)
[**apiShipmentsPost**](ShipmentsApi.md#apishipmentspost) | **POST** /api/shipments | Transfer stock serials from admin to seller (Admin only)
[**apiShipmentsShipmentIdAcceptPost**](ShipmentsApi.md#apishipmentsshipmentidacceptpost) | **POST** /api/shipments/{shipmentId}/accept | Accept a pending shipment (Seller only)


# **apiEmployeeShipmentsGet**
> SellerShipmentsListResponse apiEmployeeShipmentsGet()

List shipments for sellers at the employee's shop location (read-only)

EMPLOYEE only. Returns NewShipment rows where the seller shares users.location_id with the employee. Does not allow accept/transfer. 

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShipmentsApi();

try {
    final response = api.apiEmployeeShipmentsGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShipmentsApi->apiEmployeeShipmentsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SellerShipmentsListResponse**](SellerShipmentsListResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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

# **apiShipmentsGet**
> ApiShipmentsGet200Response apiShipmentsGet()

List all shipments (Admin only)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShipmentsApi();

try {
    final response = api.apiShipmentsGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShipmentsApi->apiShipmentsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiShipmentsGet200Response**](ApiShipmentsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiShipmentsIdGet**
> ApiShipmentsIdGet200Response apiShipmentsIdGet(id)

Get shipment details by ID (Admin or Seller)

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShipmentsApi();
final int id = 56; // int | Shipment ID

try {
    final response = api.apiShipmentsIdGet(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShipmentsApi->apiShipmentsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| Shipment ID | 

### Return type

[**ApiShipmentsIdGet200Response**](ApiShipmentsIdGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiShipmentsPost**
> CreateShipmentResponse apiShipmentsPost(createShipmentRequest)

Transfer stock serials from admin to seller (Admin only)

Marks existing AVAILABLE admin-owned product units as IN_SHIPMENT. Creates shipment record (status PENDING) and inventory_transactions (SHIPPED). Ownership moves to seller when seller accepts the shipment. 

### Example
```dart
import 'package:friends_battery_api/api.dart';

final api = FriendsBatteryApi().getShipmentsApi();
final CreateShipmentRequest createShipmentRequest = ; // CreateShipmentRequest | 

try {
    final response = api.apiShipmentsPost(createShipmentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ShipmentsApi->apiShipmentsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createShipmentRequest** | [**CreateShipmentRequest**](CreateShipmentRequest.md)|  | 

### Return type

[**CreateShipmentResponse**](CreateShipmentResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

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

