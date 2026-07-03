//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_products_product_names_post_request.g.dart';

/// ApiProductsProductNamesPostRequest
///
/// Properties:
/// * [name] 
@BuiltValue()
abstract class ApiProductsProductNamesPostRequest implements Built<ApiProductsProductNamesPostRequest, ApiProductsProductNamesPostRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  ApiProductsProductNamesPostRequest._();

  factory ApiProductsProductNamesPostRequest([void updates(ApiProductsProductNamesPostRequestBuilder b)]) = _$ApiProductsProductNamesPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiProductsProductNamesPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiProductsProductNamesPostRequest> get serializer => _$ApiProductsProductNamesPostRequestSerializer();
}

class _$ApiProductsProductNamesPostRequestSerializer implements PrimitiveSerializer<ApiProductsProductNamesPostRequest> {
  @override
  final Iterable<Type> types = const [ApiProductsProductNamesPostRequest, _$ApiProductsProductNamesPostRequest];

  @override
  final String wireName = r'ApiProductsProductNamesPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiProductsProductNamesPostRequest object, {
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
    ApiProductsProductNamesPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiProductsProductNamesPostRequestBuilder result,
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
  ApiProductsProductNamesPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiProductsProductNamesPostRequestBuilder();
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

