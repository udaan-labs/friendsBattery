# friends_battery_api.model.CreateLocationRequest

## Load the model package
```dart
import 'package:friends_battery_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**code** | **String** | Unique location code (stored uppercase) | 
**name** | **String** |  | 
**type** | **String** |  | 
**address** | **String** |  | [optional] 
**phone** | **String** |  | [optional] 
**latitude** | **num** | Geofence center; required together with longitude | [optional] 
**longitude** | **num** | Geofence center; required together with latitude | [optional] 
**allowedRadius** | **int** | Attendance radius in meters (default 100 when lat/lng set) | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


