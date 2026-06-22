//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_products_product_models_post_request.g.dart';

/// ApiProductsProductModelsPostRequest
///
/// Properties:
/// * [productNameId] 
/// * [name] 
@BuiltValue()
abstract class ApiProductsProductModelsPostRequest implements Built<ApiProductsProductModelsPostRequest, ApiProductsProductModelsPostRequestBuilder> {
  @BuiltValueField(wireName: r'product_name_id')
  int? get productNameId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  ApiProductsProductModelsPostRequest._();

  factory ApiProductsProductModelsPostRequest([void updates(ApiProductsProductModelsPostRequestBuilder b)]) = _$ApiProductsProductModelsPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiProductsProductModelsPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiProductsProductModelsPostRequest> get serializer => _$ApiProductsProductModelsPostRequestSerializer();
}

class _$ApiProductsProductModelsPostRequestSerializer implements PrimitiveSerializer<ApiProductsProductModelsPostRequest> {
  @override
  final Iterable<Type> types = const [ApiProductsProductModelsPostRequest, _$ApiProductsProductModelsPostRequest];

  @override
  final String wireName = r'ApiProductsProductModelsPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiProductsProductModelsPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productNameId != null) {
      yield r'product_name_id';
      yield serializers.serialize(
        object.productNameId,
        specifiedType: const FullType(int),
      );
    }
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
    ApiProductsProductModelsPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiProductsProductModelsPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_name_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productNameId = valueDes;
          break;
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
  ApiProductsProductModelsPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiProductsProductModelsPostRequestBuilder();
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

