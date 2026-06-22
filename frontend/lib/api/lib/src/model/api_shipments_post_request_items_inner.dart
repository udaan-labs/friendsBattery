//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_shipments_post_request_items_inner.g.dart';

/// ApiShipmentsPostRequestItemsInner
///
/// Properties:
/// * [productCategoryId] 
/// * [productNameId] 
/// * [productModelId] 
/// * [quantity] 
@BuiltValue()
abstract class ApiShipmentsPostRequestItemsInner implements Built<ApiShipmentsPostRequestItemsInner, ApiShipmentsPostRequestItemsInnerBuilder> {
  @BuiltValueField(wireName: r'productCategoryId')
  int get productCategoryId;

  @BuiltValueField(wireName: r'productNameId')
  int get productNameId;

  @BuiltValueField(wireName: r'productModelId')
  int get productModelId;

  @BuiltValueField(wireName: r'quantity')
  int get quantity;

  ApiShipmentsPostRequestItemsInner._();

  factory ApiShipmentsPostRequestItemsInner([void updates(ApiShipmentsPostRequestItemsInnerBuilder b)]) = _$ApiShipmentsPostRequestItemsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiShipmentsPostRequestItemsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiShipmentsPostRequestItemsInner> get serializer => _$ApiShipmentsPostRequestItemsInnerSerializer();
}

class _$ApiShipmentsPostRequestItemsInnerSerializer implements PrimitiveSerializer<ApiShipmentsPostRequestItemsInner> {
  @override
  final Iterable<Type> types = const [ApiShipmentsPostRequestItemsInner, _$ApiShipmentsPostRequestItemsInner];

  @override
  final String wireName = r'ApiShipmentsPostRequestItemsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiShipmentsPostRequestItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'productCategoryId';
    yield serializers.serialize(
      object.productCategoryId,
      specifiedType: const FullType(int),
    );
    yield r'productNameId';
    yield serializers.serialize(
      object.productNameId,
      specifiedType: const FullType(int),
    );
    yield r'productModelId';
    yield serializers.serialize(
      object.productModelId,
      specifiedType: const FullType(int),
    );
    yield r'quantity';
    yield serializers.serialize(
      object.quantity,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiShipmentsPostRequestItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiShipmentsPostRequestItemsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'productCategoryId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productCategoryId = valueDes;
          break;
        case r'productNameId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productNameId = valueDes;
          break;
        case r'productModelId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productModelId = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.quantity = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiShipmentsPostRequestItemsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiShipmentsPostRequestItemsInnerBuilder();
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

