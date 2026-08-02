//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/login_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_data.g.dart';

/// LoginData
///
/// Properties:
/// * [authId] 
/// * [authKey] 
/// * [sessionId] - Present for EMPLOYEE logins (employee_sessions)
/// * [user] 
@BuiltValue()
abstract class LoginData implements Built<LoginData, LoginDataBuilder> {
  @BuiltValueField(wireName: r'auth_id')
  String? get authId;

  @BuiltValueField(wireName: r'auth_key')
  String? get authKey;

  /// Present for EMPLOYEE logins (employee_sessions)
  @BuiltValueField(wireName: r'session_id')
  int? get sessionId;

  @BuiltValueField(wireName: r'user')
  LoginUser? get user;

  LoginData._();

  factory LoginData([void updates(LoginDataBuilder b)]) = _$LoginData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginData> get serializer => _$LoginDataSerializer();
}

class _$LoginDataSerializer implements PrimitiveSerializer<LoginData> {
  @override
  final Iterable<Type> types = const [LoginData, _$LoginData];

  @override
  final String wireName = r'LoginData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.authId != null) {
      yield r'auth_id';
      yield serializers.serialize(
        object.authId,
        specifiedType: const FullType(String),
      );
    }
    if (object.authKey != null) {
      yield r'auth_key';
      yield serializers.serialize(
        object.authKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.sessionId != null) {
      yield r'session_id';
      yield serializers.serialize(
        object.sessionId,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType(LoginUser),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'auth_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.authId = valueDes;
          break;
        case r'auth_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.authKey = valueDes;
          break;
        case r'session_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.sessionId = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LoginUser),
          ) as LoginUser;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginDataBuilder();
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

