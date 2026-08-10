//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_auth_verify_otp_post_request.g.dart';

/// ApiAuthVerifyOtpPostRequest
///
/// Properties:
/// * [challengeId] 
/// * [otp] 
@BuiltValue()
abstract class ApiAuthVerifyOtpPostRequest implements Built<ApiAuthVerifyOtpPostRequest, ApiAuthVerifyOtpPostRequestBuilder> {
  @BuiltValueField(wireName: r'challenge_id')
  String get challengeId;

  @BuiltValueField(wireName: r'otp')
  String get otp;

  ApiAuthVerifyOtpPostRequest._();

  factory ApiAuthVerifyOtpPostRequest([void updates(ApiAuthVerifyOtpPostRequestBuilder b)]) = _$ApiAuthVerifyOtpPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiAuthVerifyOtpPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiAuthVerifyOtpPostRequest> get serializer => _$ApiAuthVerifyOtpPostRequestSerializer();
}

class _$ApiAuthVerifyOtpPostRequestSerializer implements PrimitiveSerializer<ApiAuthVerifyOtpPostRequest> {
  @override
  final Iterable<Type> types = const [ApiAuthVerifyOtpPostRequest, _$ApiAuthVerifyOtpPostRequest];

  @override
  final String wireName = r'ApiAuthVerifyOtpPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiAuthVerifyOtpPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'challenge_id';
    yield serializers.serialize(
      object.challengeId,
      specifiedType: const FullType(String),
    );
    yield r'otp';
    yield serializers.serialize(
      object.otp,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiAuthVerifyOtpPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiAuthVerifyOtpPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'challenge_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.challengeId = valueDes;
          break;
        case r'otp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  ApiAuthVerifyOtpPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiAuthVerifyOtpPostRequestBuilder();
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

