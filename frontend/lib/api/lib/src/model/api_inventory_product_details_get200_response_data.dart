//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_inventory_product_details_get200_response_data.g.dart';

/// ApiInventoryProductDetailsGet200ResponseData
///
/// Properties:
/// * [productId] 
/// * [currentStock] 
/// * [minSellPrice] 
@BuiltValue()
abstract class ApiInventoryProductDetailsGet200ResponseData implements Built<ApiInventoryProductDetailsGet200ResponseData, ApiInventoryProductDetailsGet200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'productId')
  int? get productId;

  @BuiltValueField(wireName: r'currentStock')
  int? get currentStock;

  @BuiltValueField(wireName: r'minSellPrice')
  num? get minSellPrice;

  ApiInventoryProductDetailsGet200ResponseData._();

  factory ApiInventoryProductDetailsGet200ResponseData([void updates(ApiInventoryProductDetailsGet200ResponseDataBuilder b)]) = _$ApiInventoryProductDetailsGet200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiInventoryProductDetailsGet200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiInventoryProductDetailsGet200ResponseData> get serializer => _$ApiInventoryProductDetailsGet200ResponseDataSerializer();
}

class _$ApiInventoryProductDetailsGet200ResponseDataSerializer implements PrimitiveSerializer<ApiInventoryProductDetailsGet200ResponseData> {
  @override
  final Iterable<Type> types = const [ApiInventoryProductDetailsGet200ResponseData, _$ApiInventoryProductDetailsGet200ResponseData];

  @override
  final String wireName = r'ApiInventoryProductDetailsGet200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiInventoryProductDetailsGet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productId != null) {
      yield r'productId';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType(int),
      );
    }
    if (object.currentStock != null) {
      yield r'currentStock';
      yield serializers.serialize(
        object.currentStock,
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
    ApiInventoryProductDetailsGet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiInventoryProductDetailsGet200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'productId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productId = valueDes;
          break;
        case r'currentStock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.currentStock = valueDes;
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
  ApiInventoryProductDetailsGet200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiInventoryProductDetailsGet200ResponseDataBuilder();
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

