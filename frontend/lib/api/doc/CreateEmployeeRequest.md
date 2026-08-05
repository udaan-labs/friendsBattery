# friends_battery_api.model.CreateEmployeeRequest

## Load the model package
```dart
import 'package:friends_battery_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**userId** | **String** |  | 
**username** | **String** |  | 
**userNumber** | **String** | 10-digit mobile | 
**password** | **String** |  | 
**employeeRoleId** | **int** | Optional job title id from GET /api/shops/employee-roles | [optional] 
**locationId** | **int** | Required for admin (warehouse or shop). Ignored for seller. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


