//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_auth_register_superadmin_post_request.g.dart';

/// ApiAuthRegisterSuperadminPostRequest
///
/// Properties:
/// * [userId] 
/// * [username] 
/// * [userNumber] - Exactly 10 digits
/// * [shopName] 
/// * [password] - Min 8 characters, one uppercase, one special character
@BuiltValue()
abstract class ApiAuthRegisterSuperadminPostRequest implements Built<ApiAuthRegisterSuperadminPostRequest, ApiAuthRegisterSuperadminPostRequestBuilder> {
  @BuiltValueField(wireName: r'user_id')
  String get userId;

  @BuiltValueField(wireName: r'username')
  String get username;

  /// Exactly 10 digits
  @BuiltValueField(wireName: r'user_number')
  String get userNumber;

  @BuiltValueField(wireName: r'shop_name')
  String? get shopName;

  /// Min 8 characters, one uppercase, one special character
  @BuiltValueField(wireName: r'password')
  String get password;

  ApiAuthRegisterSuperadminPostRequest._();

  factory ApiAuthRegisterSuperadminPostRequest([void updates(ApiAuthRegisterSuperadminPostRequestBuilder b)]) = _$ApiAuthRegisterSuperadminPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiAuthRegisterSuperadminPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiAuthRegisterSuperadminPostRequest> get serializer => _$ApiAuthRegisterSuperadminPostRequestSerializer();
}

class _$ApiAuthRegisterSuperadminPostRequestSerializer implements PrimitiveSerializer<ApiAuthRegisterSuperadminPostRequest> {
  @override
  final Iterable<Type> types = const [ApiAuthRegisterSuperadminPostRequest, _$ApiAuthRegisterSuperadminPostRequest];

  @override
  final String wireName = r'ApiAuthRegisterSuperadminPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiAuthRegisterSuperadminPostRequest object, {
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
    if (object.shopName != null) {
      yield r'shop_name';
      yield serializers.serialize(
        object.shopName,
        specifiedType: const FullType(String),
      );
    }
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiAuthRegisterSuperadminPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiAuthRegisterSuperadminPostRequestBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiAuthRegisterSuperadminPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiAuthRegisterSuperadminPostRequestBuilder();
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

