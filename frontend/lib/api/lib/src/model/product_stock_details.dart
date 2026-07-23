//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_stock_details.g.dart';

/// ProductStockDetails
///
/// Properties:
/// * [currentStock] 
/// * [minSellPrice] 
@BuiltValue()
abstract class ProductStockDetails implements Built<ProductStockDetails, ProductStockDetailsBuilder> {
  @BuiltValueField(wireName: r'currentStock')
  int? get currentStock;

  @BuiltValueField(wireName: r'minSellPrice')
  num? get minSellPrice;

  ProductStockDetails._();

  factory ProductStockDetails([void updates(ProductStockDetailsBuilder b)]) = _$ProductStockDetails;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductStockDetailsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProductStockDetails> get serializer => _$ProductStockDetailsSerializer();
}

class _$ProductStockDetailsSerializer implements PrimitiveSerializer<ProductStockDetails> {
  @override
  final Iterable<Type> types = const [ProductStockDetails, _$ProductStockDetails];

  @override
  final String wireName = r'ProductStockDetails';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProductStockDetails object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    ProductStockDetails object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProductStockDetailsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  ProductStockDetails deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductStockDetailsBuilder();
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

