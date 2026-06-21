//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_auth_activate_put_request.g.dart';

/// ApiAuthActivatePutRequest
///
/// Properties:
/// * [userId] 
/// * [isActive] 
/// * [isVerified] 
@BuiltValue()
abstract class ApiAuthActivatePutRequest implements Built<ApiAuthActivatePutRequest, ApiAuthActivatePutRequestBuilder> {
  @BuiltValueField(wireName: r'user_id')
  String get userId;

  @BuiltValueField(wireName: r'is_active')
  bool get isActive;

  @BuiltValueField(wireName: r'is_verified')
  bool get isVerified;

  ApiAuthActivatePutRequest._();

  factory ApiAuthActivatePutRequest([void updates(ApiAuthActivatePutRequestBuilder b)]) = _$ApiAuthActivatePutRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiAuthActivatePutRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiAuthActivatePutRequest> get serializer => _$ApiAuthActivatePutRequestSerializer();
}

class _$ApiAuthActivatePutRequestSerializer implements PrimitiveSerializer<ApiAuthActivatePutRequest> {
  @override
  final Iterable<Type> types = const [ApiAuthActivatePutRequest, _$ApiAuthActivatePutRequest];

  @override
  final String wireName = r'ApiAuthActivatePutRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiAuthActivatePutRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    yield r'is_active';
    yield serializers.serialize(
      object.isActive,
      specifiedType: const FullType(bool),
    );
    yield r'is_verified';
    yield serializers.serialize(
      object.isVerified,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiAuthActivatePutRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiAuthActivatePutRequestBuilder result,
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
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        case r'is_verified':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isVerified = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiAuthActivatePutRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiAuthActivatePutRequestBuilder();
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

