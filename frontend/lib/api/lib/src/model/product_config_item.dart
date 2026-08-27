//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_config_item.g.dart';

/// ProductConfigItem
///
/// Properties:
/// * [id] 
/// * [productName] 
/// * [productModel] 
/// * [minPrice] 
/// * [onSale] 
/// * [offerPrice] 
/// * [minUnitCountAdmin] 
/// * [minUnitCountSeller] 
@BuiltValue()
abstract class ProductConfigItem implements Built<ProductConfigItem, ProductConfigItemBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'product_name')
  String? get productName;

  @BuiltValueField(wireName: r'product_model')
  String? get productModel;

  @BuiltValueField(wireName: r'min_price')
  num? get minPrice;

  @BuiltValueField(wireName: r'on_sale')
  bool? get onSale;

  @BuiltValueField(wireName: r'offer_price')
  num? get offerPrice;

  @BuiltValueField(wireName: r'min_unit_count_admin')
  int? get minUnitCountAdmin;

  @BuiltValueField(wireName: r'min_unit_count_seller')
  int? get minUnitCountSeller;

  ProductConfigItem._();

  factory ProductConfigItem([void updates(ProductConfigItemBuilder b)]) = _$ProductConfigItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductConfigItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProductConfigItem> get serializer => _$ProductConfigItemSerializer();
}

class _$ProductConfigItemSerializer implements PrimitiveSerializer<ProductConfigItem> {
  @override
  final Iterable<Type> types = const [ProductConfigItem, _$ProductConfigItem];

  @override
  final String wireName = r'ProductConfigItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProductConfigItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.productName != null) {
      yield r'product_name';
      yield serializers.serialize(
        object.productName,
        specifiedType: const FullType(String),
      );
    }
    if (object.productModel != null) {
      yield r'product_model';
      yield serializers.serialize(
        object.productModel,
        specifiedType: const FullType(String),
      );
    }
    if (object.minPrice != null) {
      yield r'min_price';
      yield serializers.serialize(
        object.minPrice,
        specifiedType: const FullType(num),
      );
    }
    if (object.onSale != null) {
      yield r'on_sale';
      yield serializers.serialize(
        object.onSale,
        specifiedType: const FullType(bool),
      );
    }
    if (object.offerPrice != null) {
      yield r'offer_price';
      yield serializers.serialize(
        object.offerPrice,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.minUnitCountAdmin != null) {
      yield r'min_unit_count_admin';
      yield serializers.serialize(
        object.minUnitCountAdmin,
        specifiedType: const FullType(int),
      );
    }
    if (object.minUnitCountSeller != null) {
      yield r'min_unit_count_seller';
      yield serializers.serialize(
        object.minUnitCountSeller,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProductConfigItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProductConfigItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'product_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productName = valueDes;
          break;
        case r'product_model':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productModel = valueDes;
          break;
        case r'min_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minPrice = valueDes;
          break;
        case r'on_sale':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.onSale = valueDes;
          break;
        case r'offer_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.offerPrice = valueDes;
          break;
        case r'min_unit_count_admin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.minUnitCountAdmin = valueDes;
          break;
        case r'min_unit_count_seller':
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
  ProductConfigItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductConfigItemBuilder();
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

