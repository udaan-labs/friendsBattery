//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_otp_send_post_request.g.dart';

/// ApiOtpSendPostRequest
///
/// Properties:
/// * [purpose] 
@BuiltValue()
abstract class ApiOtpSendPostRequest implements Built<ApiOtpSendPostRequest, ApiOtpSendPostRequestBuilder> {
  @BuiltValueField(wireName: r'purpose')
  String get purpose;

  ApiOtpSendPostRequest._();

  factory ApiOtpSendPostRequest([void updates(ApiOtpSendPostRequestBuilder b)]) = _$ApiOtpSendPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiOtpSendPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiOtpSendPostRequest> get serializer => _$ApiOtpSendPostRequestSerializer();
}

class _$ApiOtpSendPostRequestSerializer implements PrimitiveSerializer<ApiOtpSendPostRequest> {
  @override
  final Iterable<Type> types = const [ApiOtpSendPostRequest, _$ApiOtpSendPostRequest];

  @override
  final String wireName = r'ApiOtpSendPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiOtpSendPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'purpose';
    yield serializers.serialize(
      object.purpose,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiOtpSendPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiOtpSendPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  ApiOtpSendPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiOtpSendPostRequestBuilder();
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

