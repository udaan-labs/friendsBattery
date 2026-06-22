//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_products_product_models_list_post_request.g.dart';

/// ApiProductsProductModelsListPostRequest
///
/// Properties:
/// * [categoryId] 
/// * [productNameId] 
@BuiltValue()
abstract class ApiProductsProductModelsListPostRequest implements Built<ApiProductsProductModelsListPostRequest, ApiProductsProductModelsListPostRequestBuilder> {
  @BuiltValueField(wireName: r'category_id')
  int? get categoryId;

  @BuiltValueField(wireName: r'product_name_id')
  int? get productNameId;

  ApiProductsProductModelsListPostRequest._();

  factory ApiProductsProductModelsListPostRequest([void updates(ApiProductsProductModelsListPostRequestBuilder b)]) = _$ApiProductsProductModelsListPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiProductsProductModelsListPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiProductsProductModelsListPostRequest> get serializer => _$ApiProductsProductModelsListPostRequestSerializer();
}

class _$ApiProductsProductModelsListPostRequestSerializer implements PrimitiveSerializer<ApiProductsProductModelsListPostRequest> {
  @override
  final Iterable<Type> types = const [ApiProductsProductModelsListPostRequest, _$ApiProductsProductModelsListPostRequest];

  @override
  final String wireName = r'ApiProductsProductModelsListPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiProductsProductModelsListPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.categoryId != null) {
      yield r'category_id';
      yield serializers.serialize(
        object.categoryId,
        specifiedType: const FullType(int),
      );
    }
    if (object.productNameId != null) {
      yield r'product_name_id';
      yield serializers.serialize(
        object.productNameId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiProductsProductModelsListPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiProductsProductModelsListPostRequestBuilder result,
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
        case r'product_name_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productNameId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiProductsProductModelsListPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiProductsProductModelsListPostRequestBuilder();
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

