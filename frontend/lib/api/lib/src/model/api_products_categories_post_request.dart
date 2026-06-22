//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_products_categories_post_request.g.dart';

/// ApiProductsCategoriesPostRequest
///
/// Properties:
/// * [name] 
@BuiltValue()
abstract class ApiProductsCategoriesPostRequest implements Built<ApiProductsCategoriesPostRequest, ApiProductsCategoriesPostRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  ApiProductsCategoriesPostRequest._();

  factory ApiProductsCategoriesPostRequest([void updates(ApiProductsCategoriesPostRequestBuilder b)]) = _$ApiProductsCategoriesPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiProductsCategoriesPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiProductsCategoriesPostRequest> get serializer => _$ApiProductsCategoriesPostRequestSerializer();
}

class _$ApiProductsCategoriesPostRequestSerializer implements PrimitiveSerializer<ApiProductsCategoriesPostRequest> {
  @override
  final Iterable<Type> types = const [ApiProductsCategoriesPostRequest, _$ApiProductsCategoriesPostRequest];

  @override
  final String wireName = r'ApiProductsCategoriesPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiProductsCategoriesPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiProductsCategoriesPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiProductsCategoriesPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiProductsCategoriesPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiProductsCategoriesPostRequestBuilder();
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

