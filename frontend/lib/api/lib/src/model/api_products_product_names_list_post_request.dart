//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_products_product_names_list_post_request.g.dart';

/// ApiProductsProductNamesListPostRequest
///
/// Properties:
/// * [categoryId] 
@BuiltValue()
abstract class ApiProductsProductNamesListPostRequest implements Built<ApiProductsProductNamesListPostRequest, ApiProductsProductNamesListPostRequestBuilder> {
  @BuiltValueField(wireName: r'category_id')
  int? get categoryId;

  ApiProductsProductNamesListPostRequest._();

  factory ApiProductsProductNamesListPostRequest([void updates(ApiProductsProductNamesListPostRequestBuilder b)]) = _$ApiProductsProductNamesListPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiProductsProductNamesListPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiProductsProductNamesListPostRequest> get serializer => _$ApiProductsProductNamesListPostRequestSerializer();
}

class _$ApiProductsProductNamesListPostRequestSerializer implements PrimitiveSerializer<ApiProductsProductNamesListPostRequest> {
  @override
  final Iterable<Type> types = const [ApiProductsProductNamesListPostRequest, _$ApiProductsProductNamesListPostRequest];

  @override
  final String wireName = r'ApiProductsProductNamesListPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiProductsProductNamesListPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.categoryId != null) {
      yield r'category_id';
      yield serializers.serialize(
        object.categoryId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiProductsProductNamesListPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiProductsProductNamesListPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'category_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.categoryId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiProductsProductNamesListPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiProductsProductNamesListPostRequestBuilder();
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

