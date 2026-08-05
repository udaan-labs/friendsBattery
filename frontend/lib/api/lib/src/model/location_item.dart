//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'location_item.g.dart';

/// LocationItem
///
/// Properties:
/// * [id] 
/// * [code] 
/// * [name] 
/// * [type] 
/// * [isActive] 
/// * [address] 
/// * [phone] 
@BuiltValue()
abstract class LocationItem implements Built<LocationItem, LocationItemBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'code')
  String? get code;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'type')
  LocationItemTypeEnum? get type;
  // enum typeEnum {  WAREHOUSE,  SHOP,  };

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  LocationItem._();

  factory LocationItem([void updates(LocationItemBuilder b)]) = _$LocationItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LocationItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LocationItem> get serializer => _$LocationItemSerializer();
}

class _$LocationItemSerializer implements PrimitiveSerializer<LocationItem> {
  @override
  final Iterable<Type> types = const [LocationItem, _$LocationItem];

  @override
  final String wireName = r'LocationItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LocationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(LocationItemTypeEnum),
      );
    }
    if (object.isActive != null) {
      yield r'is_active';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
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
  }

  @override
  Object serialize(
    Serializers serializers,
    LocationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LocationItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
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
            specifiedType: const FullType(LocationItemTypeEnum),
          ) as LocationItemTypeEnum;
          result.type = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LocationItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LocationItemBuilder();
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

class LocationItemTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'WAREHOUSE')
  static const LocationItemTypeEnum WAREHOUSE = _$locationItemTypeEnum_WAREHOUSE;
  @BuiltValueEnumConst(wireName: r'SHOP')
  static const LocationItemTypeEnum SHOP = _$locationItemTypeEnum_SHOP;

  static Serializer<LocationItemTypeEnum> get serializer => _$locationItemTypeEnumSerializer;

  const LocationItemTypeEnum._(String name): super(name);

  static BuiltSet<LocationItemTypeEnum> get values => _$locationItemTypeEnumValues;
  static LocationItemTypeEnum valueOf(String name) => _$locationItemTypeEnumValueOf(name);
}

