//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_inventory_update_stock_post200_response_data.g.dart';

/// ApiInventoryUpdateStockPost200ResponseData
///
/// Properties:
/// * [productCategoryId] 
/// * [productNameId] 
/// * [productModelId] 
/// * [quantity] 
/// * [minSellPrice] 
@BuiltValue()
abstract class ApiInventoryUpdateStockPost200ResponseData implements Built<ApiInventoryUpdateStockPost200ResponseData, ApiInventoryUpdateStockPost200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'productCategoryId')
  int? get productCategoryId;

  @BuiltValueField(wireName: r'productNameId')
  int? get productNameId;

  @BuiltValueField(wireName: r'productModelId')
  int? get productModelId;

  @BuiltValueField(wireName: r'quantity')
  int? get quantity;

  @BuiltValueField(wireName: r'minSellPrice')
  num? get minSellPrice;

  ApiInventoryUpdateStockPost200ResponseData._();

  factory ApiInventoryUpdateStockPost200ResponseData([void updates(ApiInventoryUpdateStockPost200ResponseDataBuilder b)]) = _$ApiInventoryUpdateStockPost200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiInventoryUpdateStockPost200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiInventoryUpdateStockPost200ResponseData> get serializer => _$ApiInventoryUpdateStockPost200ResponseDataSerializer();
}

class _$ApiInventoryUpdateStockPost200ResponseDataSerializer implements PrimitiveSerializer<ApiInventoryUpdateStockPost200ResponseData> {
  @override
  final Iterable<Type> types = const [ApiInventoryUpdateStockPost200ResponseData, _$ApiInventoryUpdateStockPost200ResponseData];

  @override
  final String wireName = r'ApiInventoryUpdateStockPost200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiInventoryUpdateStockPost200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productCategoryId != null) {
      yield r'productCategoryId';
      yield serializers.serialize(
        object.productCategoryId,
        specifiedType: const FullType(int),
      );
    }
    if (object.productNameId != null) {
      yield r'productNameId';
      yield serializers.serialize(
        object.productNameId,
        specifiedType: const FullType(int),
      );
    }
    if (object.productModelId != null) {
      yield r'productModelId';
      yield serializers.serialize(
        object.productModelId,
        specifiedType: const FullType(int),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(int),
      );
    }
    if (object.minSellPrice != null) {
      yield r'minSellPrice';
      yield serializers.serialize(
        object.minSellPrice,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiInventoryUpdateStockPost200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiInventoryUpdateStockPost200ResponseDataBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiInventoryUpdateStockPost200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiInventoryUpdateStockPost200ResponseDataBuilder();
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

