//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_location_request.g.dart';

/// UpdateLocationRequest
///
/// Properties:
/// * [name] 
/// * [address] 
/// * [latitude] - Geofence center; required together with longitude
/// * [longitude] - Geofence center; required together with latitude
/// * [allowedRadius] - Attendance radius in meters
@BuiltValue()
abstract class UpdateLocationRequest implements Built<UpdateLocationRequest, UpdateLocationRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'address')
  String? get address;

  /// Geofence center; required together with longitude
  @BuiltValueField(wireName: r'latitude')
  num? get latitude;

  /// Geofence center; required together with latitude
  @BuiltValueField(wireName: r'longitude')
  num? get longitude;

  /// Attendance radius in meters
  @BuiltValueField(wireName: r'allowed_radius')
  int? get allowedRadius;

  UpdateLocationRequest._();

  factory UpdateLocationRequest([void updates(UpdateLocationRequestBuilder b)]) = _$UpdateLocationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateLocationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateLocationRequest> get serializer => _$UpdateLocationRequestSerializer();
}

class _$UpdateLocationRequestSerializer implements PrimitiveSerializer<UpdateLocationRequest> {
  @override
  final Iterable<Type> types = const [UpdateLocationRequest, _$UpdateLocationRequest];

  @override
  final String wireName = r'UpdateLocationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateLocationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.latitude != null) {
      yield r'latitude';
      yield serializers.serialize(
        object.latitude,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.longitude != null) {
      yield r'longitude';
      yield serializers.serialize(
        object.longitude,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.allowedRadius != null) {
      yield r'allowed_radius';
      yield serializers.serialize(
        object.allowedRadius,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateLocationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateLocationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.address = valueDes;
          break;
        case r'latitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.latitude = valueDes;
          break;
        case r'longitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.longitude = valueDes;
          break;
        case r'allowed_radius':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.allowedRadius = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateLocationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateLocationRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

