//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'change_password_data.g.dart';

/// ChangePasswordData
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [role] 
@BuiltValue()
abstract class ChangePasswordData implements Built<ChangePasswordData, ChangePasswordDataBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'user_id')
  String? get userId;

  @BuiltValueField(wireName: r'role')
  ChangePasswordDataRoleEnum? get role;
  // enum roleEnum {  ADMIN,  SELLER,  EMPLOYEE,  };

  ChangePasswordData._();

  factory ChangePasswordData([void updates(ChangePasswordDataBuilder b)]) = _$ChangePasswordData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChangePasswordDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChangePasswordData> get serializer => _$ChangePasswordDataSerializer();
}

class _$ChangePasswordDataSerializer implements PrimitiveSerializer<ChangePasswordData> {
  @override
  final Iterable<Type> types = const [ChangePasswordData, _$ChangePasswordData];

  @override
  final String wireName = r'ChangePasswordData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChangePasswordData object, {
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
        specifiedType: const FullType(ChangePasswordDataRoleEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChangePasswordData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChangePasswordDataBuilder result,
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
            specifiedType: const FullType(ChangePasswordDataRoleEnum),
          ) as ChangePasswordDataRoleEnum;
          result.role = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChangePasswordData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChangePasswordDataBuilder();
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

class ChangePasswordDataRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ADMIN')
  static const ChangePasswordDataRoleEnum ADMIN = _$changePasswordDataRoleEnum_ADMIN;
  @BuiltValueEnumConst(wireName: r'SELLER')
  static const ChangePasswordDataRoleEnum SELLER = _$changePasswordDataRoleEnum_SELLER;
  @BuiltValueEnumConst(wireName: r'EMPLOYEE')
  static const ChangePasswordDataRoleEnum EMPLOYEE = _$changePasswordDataRoleEnum_EMPLOYEE;

  static Serializer<ChangePasswordDataRoleEnum> get serializer => _$changePasswordDataRoleEnumSerializer;

  const ChangePasswordDataRoleEnum._(String name): super(name);

  static BuiltSet<ChangePasswordDataRoleEnum> get values => _$changePasswordDataRoleEnumValues;
  static ChangePasswordDataRoleEnum valueOf(String name) => _$changePasswordDataRoleEnumValueOf(name);
}

