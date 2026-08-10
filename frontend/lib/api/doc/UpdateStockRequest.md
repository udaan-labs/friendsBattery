# friends_battery_api.model.UpdateStockRequest

## Load the model package
```dart
import 'package:friends_battery_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**productNameId** | **int** |  | 
**productModelId** | **int** |  | 
**quantity** | **int** | Units to add; optional when only updating price/flags | [optional] 
**minSellPrice** | **num** |  | [optional] 
**minUnitCountAdmin** | **int** |  | [optional] 
**minUnitCountSeller** | **int** |  | [optional] 
**onSale** | **bool** |  | [optional] 
**locationId** | **int** | Target warehouse/location for new units. Omit for actor location or default WH. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


