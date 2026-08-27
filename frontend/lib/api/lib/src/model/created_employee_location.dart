//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'created_employee_location.g.dart';

/// CreatedEmployeeLocation
///
/// Properties:
/// * [id] 
/// * [code] 
/// * [name] 
/// * [type] 
/// * [isActive] 
@BuiltValue()
abstract class CreatedEmployeeLocation implements Built<CreatedEmployeeLocation, CreatedEmployeeLocationBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'code')
  String? get code;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'type')
  CreatedEmployeeLocationTypeEnum? get type;
  // enum typeEnum {  WAREHOUSE,  SHOP,  };

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  CreatedEmployeeLocation._();

  factory CreatedEmployeeLocation([void updates(CreatedEmployeeLocationBuilder b)]) = _$CreatedEmployeeLocation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatedEmployeeLocationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatedEmployeeLocation> get serializer => _$CreatedEmployeeLocationSerializer();
}

class _$CreatedEmployeeLocationSerializer implements PrimitiveSerializer<CreatedEmployeeLocation> {
  @override
  final Iterable<Type> types = const [CreatedEmployeeLocation, _$CreatedEmployeeLocation];

  @override
  final String wireName = r'CreatedEmployeeLocation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatedEmployeeLocation object, {
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
        specifiedType: const FullType(CreatedEmployeeLocationTypeEnum),
      );
    }
    if (object.isActive != null) {
      yield r'is_active';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreatedEmployeeLocation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreatedEmployeeLocationBuilder result,
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
            specifiedType: const FullType(CreatedEmployeeLocationTypeEnum),
          ) as CreatedEmployeeLocationTypeEnum;
          result.type = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreatedEmployeeLocation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatedEmployeeLocationBuilder();
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

class CreatedEmployeeLocationTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'WAREHOUSE')
  static const CreatedEmployeeLocationTypeEnum WAREHOUSE = _$createdEmployeeLocationTypeEnum_WAREHOUSE;
  @BuiltValueEnumConst(wireName: r'SHOP')
  static const CreatedEmployeeLocationTypeEnum SHOP = _$createdEmployeeLocationTypeEnum_SHOP;

  static Serializer<CreatedEmployeeLocationTypeEnum> get serializer => _$createdEmployeeLocationTypeEnumSerializer;

  const CreatedEmployeeLocationTypeEnum._(String name): super(name);

  static BuiltSet<CreatedEmployeeLocationTypeEnum> get values => _$createdEmployeeLocationTypeEnumValues;
  static CreatedEmployeeLocationTypeEnum valueOf(String name) => _$createdEmployeeLocationTypeEnumValueOf(name);
}

