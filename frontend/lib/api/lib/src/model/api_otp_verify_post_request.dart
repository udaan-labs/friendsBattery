//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_otp_verify_post_request.g.dart';

/// ApiOtpVerifyPostRequest
///
/// Properties:
/// * [challengeId] 
/// * [otp] 
/// * [purpose] 
@BuiltValue()
abstract class ApiOtpVerifyPostRequest implements Built<ApiOtpVerifyPostRequest, ApiOtpVerifyPostRequestBuilder> {
  @BuiltValueField(wireName: r'challenge_id')
  String get challengeId;

  @BuiltValueField(wireName: r'otp')
  String get otp;

  @BuiltValueField(wireName: r'purpose')
  String? get purpose;

  ApiOtpVerifyPostRequest._();

  factory ApiOtpVerifyPostRequest([void updates(ApiOtpVerifyPostRequestBuilder b)]) = _$ApiOtpVerifyPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiOtpVerifyPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiOtpVerifyPostRequest> get serializer => _$ApiOtpVerifyPostRequestSerializer();
}

class _$ApiOtpVerifyPostRequestSerializer implements PrimitiveSerializer<ApiOtpVerifyPostRequest> {
  @override
  final Iterable<Type> types = const [ApiOtpVerifyPostRequest, _$ApiOtpVerifyPostRequest];

  @override
  final String wireName = r'ApiOtpVerifyPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiOtpVerifyPostRequest object, {
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
    if (object.purpose != null) {
      yield r'purpose';
      yield serializers.serialize(
        object.purpose,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiOtpVerifyPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiOtpVerifyPostRequestBuilder result,
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
        case r'purpose':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.purpose = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiOtpVerifyPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiOtpVerifyPostRequestBuilder();
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

