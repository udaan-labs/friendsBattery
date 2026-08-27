//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/login_otp_challenge_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_otp_challenge_response.g.dart';

/// LoginOtpChallengeResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class LoginOtpChallengeResponse implements Built<LoginOtpChallengeResponse, LoginOtpChallengeResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  LoginOtpChallengeData? get data;

  LoginOtpChallengeResponse._();

  factory LoginOtpChallengeResponse([void updates(LoginOtpChallengeResponseBuilder b)]) = _$LoginOtpChallengeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginOtpChallengeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginOtpChallengeResponse> get serializer => _$LoginOtpChallengeResponseSerializer();
}

class _$LoginOtpChallengeResponseSerializer implements PrimitiveSerializer<LoginOtpChallengeResponse> {
  @override
  final Iterable<Type> types = const [LoginOtpChallengeResponse, _$LoginOtpChallengeResponse];

  @override
  final String wireName = r'LoginOtpChallengeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginOtpChallengeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.success != null) {
      yield r'success';
      yield serializers.serialize(
        object.success,
        specifiedType: const FullType(bool),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(LoginOtpChallengeData),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginOtpChallengeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginOtpChallengeResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.success = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LoginOtpChallengeData),
          ) as LoginOtpChallengeData;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginOtpChallengeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginOtpChallengeResponseBuilder();
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

