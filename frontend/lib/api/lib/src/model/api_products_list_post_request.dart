//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_products_list_post_request.g.dart';

/// ApiProductsListPostRequest
///
/// Properties:
/// * [categoryId] 
/// * [productNameId] 
/// * [productModelId] 
@BuiltValue()
abstract class ApiProductsListPostRequest implements Built<ApiProductsListPostRequest, ApiProductsListPostRequestBuilder> {
  @BuiltValueField(wireName: r'category_id')
  int? get categoryId;

  @BuiltValueField(wireName: r'product_name_id')
  int? get productNameId;

  @BuiltValueField(wireName: r'product_model_id')
  int? get productModelId;

  ApiProductsListPostRequest._();

  factory ApiProductsListPostRequest([void updates(ApiProductsListPostRequestBuilder b)]) = _$ApiProductsListPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiProductsListPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiProductsListPostRequest> get serializer => _$ApiProductsListPostRequestSerializer();
}

class _$ApiProductsListPostRequestSerializer implements PrimitiveSerializer<ApiProductsListPostRequest> {
  @override
  final Iterable<Type> types = const [ApiProductsListPostRequest, _$ApiProductsListPostRequest];

  @override
  final String wireName = r'ApiProductsListPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiProductsListPostRequest object, {
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
    if (object.productModelId != null) {
      yield r'product_model_id';
      yield serializers.serialize(
        object.productModelId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiProductsListPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiProductsListPostRequestBuilder result,
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
        case r'product_model_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productModelId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiProductsListPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiProductsListPostRequestBuilder();
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

