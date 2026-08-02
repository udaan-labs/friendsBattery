//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_user_employee_role.g.dart';

/// LoginUserEmployeeRole
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [description] 
@BuiltValue()
abstract class LoginUserEmployeeRole implements Built<LoginUserEmployeeRole, LoginUserEmployeeRoleBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  LoginUserEmployeeRole._();

  factory LoginUserEmployeeRole([void updates(LoginUserEmployeeRoleBuilder b)]) = _$LoginUserEmployeeRole;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginUserEmployeeRoleBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginUserEmployeeRole> get serializer => _$LoginUserEmployeeRoleSerializer();
}

class _$LoginUserEmployeeRoleSerializer implements PrimitiveSerializer<LoginUserEmployeeRole> {
  @override
  final Iterable<Type> types = const [LoginUserEmployeeRole, _$LoginUserEmployeeRole];

  @override
  final String wireName = r'LoginUserEmployeeRole';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginUserEmployeeRole object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginUserEmployeeRole object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginUserEmployeeRoleBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginUserEmployeeRole deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginUserEmployeeRoleBuilder();
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

