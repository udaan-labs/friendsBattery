//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_auth_register_post_request.g.dart';

/// ApiAuthRegisterPostRequest
///
/// Properties:
/// * [userId] 
/// * [username] 
/// * [userNumber] - Exactly 10 digits
/// * [shopName] 
/// * [password] 
/// * [locationId] - Optional SHOP location id (assign seller to a shop)
@BuiltValue()
abstract class ApiAuthRegisterPostRequest implements Built<ApiAuthRegisterPostRequest, ApiAuthRegisterPostRequestBuilder> {
  @BuiltValueField(wireName: r'user_id')
  String get userId;

  @BuiltValueField(wireName: r'username')
  String get username;

  /// Exactly 10 digits
  @BuiltValueField(wireName: r'user_number')
  String get userNumber;

  @BuiltValueField(wireName: r'shop_name')
  String get shopName;

  @BuiltValueField(wireName: r'password')
  String get password;

  /// Optional SHOP location id (assign seller to a shop)
  @BuiltValueField(wireName: r'location_id')
  int? get locationId;

  ApiAuthRegisterPostRequest._();

  factory ApiAuthRegisterPostRequest([void updates(ApiAuthRegisterPostRequestBuilder b)]) = _$ApiAuthRegisterPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiAuthRegisterPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiAuthRegisterPostRequest> get serializer => _$ApiAuthRegisterPostRequestSerializer();
}

class _$ApiAuthRegisterPostRequestSerializer implements PrimitiveSerializer<ApiAuthRegisterPostRequest> {
  @override
  final Iterable<Type> types = const [ApiAuthRegisterPostRequest, _$ApiAuthRegisterPostRequest];

  @override
  final String wireName = r'ApiAuthRegisterPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiAuthRegisterPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    yield r'username';
    yield serializers.serialize(
      object.username,
      specifiedType: const FullType(String),
    );
    yield r'user_number';
    yield serializers.serialize(
      object.userNumber,
      specifiedType: const FullType(String),
    );
    yield r'shop_name';
    yield serializers.serialize(
      object.shopName,
      specifiedType: const FullType(String),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
    if (object.locationId != null) {
      yield r'location_id';
      yield serializers.serialize(
        object.locationId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiAuthRegisterPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiAuthRegisterPostRequestBuilder result,
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
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.username = valueDes;
          break;
        case r'user_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userNumber = valueDes;
          break;
        case r'shop_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.shopName = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'location_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.locationId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiAuthRegisterPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiAuthRegisterPostRequestBuilder();
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

