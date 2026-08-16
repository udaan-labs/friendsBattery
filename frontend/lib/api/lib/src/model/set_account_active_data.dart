//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_account_active_data.g.dart';

/// SetAccountActiveData
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [role] 
/// * [isActive] 
@BuiltValue()
abstract class SetAccountActiveData implements Built<SetAccountActiveData, SetAccountActiveDataBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'user_id')
  String? get userId;

  @BuiltValueField(wireName: r'role')
  SetAccountActiveDataRoleEnum? get role;
  // enum roleEnum {  ADMIN,  SELLER,  EMPLOYEE,  };

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  SetAccountActiveData._();

  factory SetAccountActiveData([void updates(SetAccountActiveDataBuilder b)]) = _$SetAccountActiveData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetAccountActiveDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetAccountActiveData> get serializer => _$SetAccountActiveDataSerializer();
}

class _$SetAccountActiveDataSerializer implements PrimitiveSerializer<SetAccountActiveData> {
  @override
  final Iterable<Type> types = const [SetAccountActiveData, _$SetAccountActiveData];

  @override
  final String wireName = r'SetAccountActiveData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetAccountActiveData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userId != null) {
      yield r'user_id';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType(SetAccountActiveDataRoleEnum),
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
    SetAccountActiveData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SetAccountActiveDataBuilder result,
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
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SetAccountActiveDataRoleEnum),
          ) as SetAccountActiveDataRoleEnum;
          result.role = valueDes;
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
  SetAccountActiveData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetAccountActiveDataBuilder();
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

class SetAccountActiveDataRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ADMIN')
  static const SetAccountActiveDataRoleEnum ADMIN = _$setAccountActiveDataRoleEnum_ADMIN;
  @BuiltValueEnumConst(wireName: r'SELLER')
  static const SetAccountActiveDataRoleEnum SELLER = _$setAccountActiveDataRoleEnum_SELLER;
  @BuiltValueEnumConst(wireName: r'EMPLOYEE')
  static const SetAccountActiveDataRoleEnum EMPLOYEE = _$setAccountActiveDataRoleEnum_EMPLOYEE;

  static Serializer<SetAccountActiveDataRoleEnum> get serializer => _$setAccountActiveDataRoleEnumSerializer;

  const SetAccountActiveDataRoleEnum._(String name): super(name);

  static BuiltSet<SetAccountActiveDataRoleEnum> get values => _$setAccountActiveDataRoleEnumValues;
  static SetAccountActiveDataRoleEnum valueOf(String name) => _$setAccountActiveDataRoleEnumValueOf(name);
}

