//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_auth_login_post_request.g.dart';

/// ApiAuthLoginPostRequest
///
/// Properties:
/// * [userId] 
/// * [password] 
@BuiltValue()
abstract class ApiAuthLoginPostRequest implements Built<ApiAuthLoginPostRequest, ApiAuthLoginPostRequestBuilder> {
  @BuiltValueField(wireName: r'user_id')
  String get userId;

  @BuiltValueField(wireName: r'password')
  String get password;

  ApiAuthLoginPostRequest._();

  factory ApiAuthLoginPostRequest([void updates(ApiAuthLoginPostRequestBuilder b)]) = _$ApiAuthLoginPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiAuthLoginPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiAuthLoginPostRequest> get serializer => _$ApiAuthLoginPostRequestSerializer();
}

class _$ApiAuthLoginPostRequestSerializer implements PrimitiveSerializer<ApiAuthLoginPostRequest> {
  @override
  final Iterable<Type> types = const [ApiAuthLoginPostRequest, _$ApiAuthLoginPostRequest];

  @override
  final String wireName = r'ApiAuthLoginPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiAuthLoginPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiAuthLoginPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiAuthLoginPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiAuthLoginPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiAuthLoginPostRequestBuilder();
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

