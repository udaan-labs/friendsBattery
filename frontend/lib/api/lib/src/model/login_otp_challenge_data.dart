//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_otp_challenge_data.g.dart';

/// LoginOtpChallengeData
///
/// Properties:
/// * [requiresOtp] 
/// * [challengeId] 
/// * [expiresIn] - Seconds until OTP expires
/// * [phoneMasked] 
/// * [otp] - Dev only — present when OTP_ECHO / non-production
@BuiltValue()
abstract class LoginOtpChallengeData implements Built<LoginOtpChallengeData, LoginOtpChallengeDataBuilder> {
  @BuiltValueField(wireName: r'requires_otp')
  bool? get requiresOtp;

  @BuiltValueField(wireName: r'challenge_id')
  String? get challengeId;

  /// Seconds until OTP expires
  @BuiltValueField(wireName: r'expires_in')
  int? get expiresIn;

  @BuiltValueField(wireName: r'phone_masked')
  String? get phoneMasked;

  /// Dev only — present when OTP_ECHO / non-production
  @BuiltValueField(wireName: r'otp')
  String? get otp;

  LoginOtpChallengeData._();

  factory LoginOtpChallengeData([void updates(LoginOtpChallengeDataBuilder b)]) = _$LoginOtpChallengeData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginOtpChallengeDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginOtpChallengeData> get serializer => _$LoginOtpChallengeDataSerializer();
}

class _$LoginOtpChallengeDataSerializer implements PrimitiveSerializer<LoginOtpChallengeData> {
  @override
  final Iterable<Type> types = const [LoginOtpChallengeData, _$LoginOtpChallengeData];

  @override
  final String wireName = r'LoginOtpChallengeData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginOtpChallengeData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.requiresOtp != null) {
      yield r'requires_otp';
      yield serializers.serialize(
        object.requiresOtp,
        specifiedType: const FullType(bool),
      );
    }
    if (object.challengeId != null) {
      yield r'challenge_id';
      yield serializers.serialize(
        object.challengeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.expiresIn != null) {
      yield r'expires_in';
      yield serializers.serialize(
        object.expiresIn,
        specifiedType: const FullType(int),
      );
    }
    if (object.phoneMasked != null) {
      yield r'phone_masked';
      yield serializers.serialize(
        object.phoneMasked,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.otp != null) {
      yield r'otp';
      yield serializers.serialize(
        object.otp,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginOtpChallengeData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginOtpChallengeDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'requires_otp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.requiresOtp = valueDes;
          break;
        case r'challenge_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.challengeId = valueDes;
          break;
        case r'expires_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.expiresIn = valueDes;
          break;
        case r'phone_masked':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.phoneMasked = valueDes;
          break;
        case r'otp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.otp = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginOtpChallengeData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginOtpChallengeDataBuilder();
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

