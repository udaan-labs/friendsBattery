//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_products_request.g.dart';

/// ListProductsRequest
///
/// Properties:
/// * [productNameId] 
/// * [productModelId] 
@BuiltValue()
abstract class ListProductsRequest implements Built<ListProductsRequest, ListProductsRequestBuilder> {
  @BuiltValueField(wireName: r'product_name_id')
  int get productNameId;

  @BuiltValueField(wireName: r'product_model_id')
  int get productModelId;

  ListProductsRequest._();

  factory ListProductsRequest([void updates(ListProductsRequestBuilder b)]) = _$ListProductsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListProductsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListProductsRequest> get serializer => _$ListProductsRequestSerializer();
}

class _$ListProductsRequestSerializer implements PrimitiveSerializer<ListProductsRequest> {
  @override
  final Iterable<Type> types = const [ListProductsRequest, _$ListProductsRequest];

  @override
  final String wireName = r'ListProductsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListProductsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'product_name_id';
    yield serializers.serialize(
      object.productNameId,
      specifiedType: const FullType(int),
    );
    yield r'product_model_id';
    yield serializers.serialize(
      object.productModelId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ListProductsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListProductsRequestBuilder result,
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
  ListProductsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListProductsRequestBuilder();
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

