//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_location_request.g.dart';

/// CreateLocationRequest
///
/// Properties:
/// * [code] - Unique location code (stored uppercase)
/// * [name] 
/// * [type] 
/// * [address] 
/// * [phone] 
/// * [latitude] - Geofence center; required together with longitude
/// * [longitude] - Geofence center; required together with latitude
/// * [allowedRadius] - Attendance radius in meters (default 100 when lat/lng set)
@BuiltValue()
abstract class CreateLocationRequest implements Built<CreateLocationRequest, CreateLocationRequestBuilder> {
  /// Unique location code (stored uppercase)
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'type')
  CreateLocationRequestTypeEnum get type;
  // enum typeEnum {  SHOP,  WAREHOUSE,  };

  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  /// Geofence center; required together with longitude
  @BuiltValueField(wireName: r'latitude')
  num? get latitude;

  /// Geofence center; required together with latitude
  @BuiltValueField(wireName: r'longitude')
  num? get longitude;

  /// Attendance radius in meters (default 100 when lat/lng set)
  @BuiltValueField(wireName: r'allowed_radius')
  int? get allowedRadius;

  CreateLocationRequest._();

  factory CreateLocationRequest([void updates(CreateLocationRequestBuilder b)]) = _$CreateLocationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateLocationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateLocationRequest> get serializer => _$CreateLocationRequestSerializer();
}

class _$CreateLocationRequestSerializer implements PrimitiveSerializer<CreateLocationRequest> {
  @override
  final Iterable<Type> types = const [CreateLocationRequest, _$CreateLocationRequest];

  @override
  final String wireName = r'CreateLocationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateLocationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(CreateLocationRequestTypeEnum),
    );
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.phone != null) {
      yield r'phone';
      yield serializers.serialize(
        object.phone,
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
    CreateLocationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateLocationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateLocationRequestTypeEnum),
          ) as CreateLocationRequestTypeEnum;
          result.type = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.address = valueDes;
          break;
        case r'phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.phone = valueDes;
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
  CreateLocationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateLocationRequestBuilder();
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

class CreateLocationRequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'SHOP')
  static const CreateLocationRequestTypeEnum SHOP = _$createLocationRequestTypeEnum_SHOP;
  @BuiltValueEnumConst(wireName: r'WAREHOUSE')
  static const CreateLocationRequestTypeEnum WAREHOUSE = _$createLocationRequestTypeEnum_WAREHOUSE;

  static Serializer<CreateLocationRequestTypeEnum> get serializer => _$createLocationRequestTypeEnumSerializer;

  const CreateLocationRequestTypeEnum._(String name): super(name);

  static BuiltSet<CreateLocationRequestTypeEnum> get values => _$createLocationRequestTypeEnumValues;
  static CreateLocationRequestTypeEnum valueOf(String name) => _$createLocationRequestTypeEnumValueOf(name);
}

