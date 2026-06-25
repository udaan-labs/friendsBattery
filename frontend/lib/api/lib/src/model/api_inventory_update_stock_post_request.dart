//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_inventory_update_stock_post_request.g.dart';

/// ApiInventoryUpdateStockPostRequest
///
/// Properties:
/// * [productCategoryId] 
/// * [productNameId] 
/// * [productModelId] 
/// * [quantity] 
/// * [minSellPrice] 
/// * [minUnitCountAdmin] 
/// * [minUnitCountSeller] 
@BuiltValue()
abstract class ApiInventoryUpdateStockPostRequest implements Built<ApiInventoryUpdateStockPostRequest, ApiInventoryUpdateStockPostRequestBuilder> {
  @BuiltValueField(wireName: r'productCategoryId')
  int get productCategoryId;

  @BuiltValueField(wireName: r'productNameId')
  int get productNameId;

  @BuiltValueField(wireName: r'productModelId')
  int get productModelId;

  @BuiltValueField(wireName: r'quantity')
  int get quantity;

  @BuiltValueField(wireName: r'minSellPrice')
  num? get minSellPrice;

  @BuiltValueField(wireName: r'minUnitCountAdmin')
  int? get minUnitCountAdmin;

  @BuiltValueField(wireName: r'minUnitCountSeller')
  int? get minUnitCountSeller;

  ApiInventoryUpdateStockPostRequest._();

  factory ApiInventoryUpdateStockPostRequest([void updates(ApiInventoryUpdateStockPostRequestBuilder b)]) = _$ApiInventoryUpdateStockPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiInventoryUpdateStockPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiInventoryUpdateStockPostRequest> get serializer => _$ApiInventoryUpdateStockPostRequestSerializer();
}

class _$ApiInventoryUpdateStockPostRequestSerializer implements PrimitiveSerializer<ApiInventoryUpdateStockPostRequest> {
  @override
  final Iterable<Type> types = const [ApiInventoryUpdateStockPostRequest, _$ApiInventoryUpdateStockPostRequest];

  @override
  final String wireName = r'ApiInventoryUpdateStockPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiInventoryUpdateStockPostRequest object, {
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
    if (object.minSellPrice != null) {
      yield r'minSellPrice';
      yield serializers.serialize(
        object.minSellPrice,
        specifiedType: const FullType(num),
      );
    }
    if (object.minUnitCountAdmin != null) {
      yield r'minUnitCountAdmin';
      yield serializers.serialize(
        object.minUnitCountAdmin,
        specifiedType: const FullType(int),
      );
    }
    if (object.minUnitCountSeller != null) {
      yield r'minUnitCountSeller';
      yield serializers.serialize(
        object.minUnitCountSeller,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiInventoryUpdateStockPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiInventoryUpdateStockPostRequestBuilder result,
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
        case r'minSellPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minSellPrice = valueDes;
          break;
        case r'minUnitCountAdmin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.minUnitCountAdmin = valueDes;
          break;
        case r'minUnitCountSeller':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.minUnitCountSeller = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiInventoryUpdateStockPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiInventoryUpdateStockPostRequestBuilder();
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

