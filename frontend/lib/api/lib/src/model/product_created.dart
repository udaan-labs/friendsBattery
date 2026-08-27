//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_created.g.dart';

/// ProductCreated
///
/// Properties:
/// * [id] 
/// * [productNameId] 
/// * [productModelId] 
/// * [minPrice] 
/// * [onSale] 
/// * [offerPrice] 
/// * [minUnitCountAdmin] 
/// * [minUnitCountSeller] 
/// * [createdAt] 
@BuiltValue()
abstract class ProductCreated implements Built<ProductCreated, ProductCreatedBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'product_name_id')
  int? get productNameId;

  @BuiltValueField(wireName: r'product_model_id')
  int? get productModelId;

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

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  ProductCreated._();

  factory ProductCreated([void updates(ProductCreatedBuilder b)]) = _$ProductCreated;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductCreatedBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProductCreated> get serializer => _$ProductCreatedSerializer();
}

class _$ProductCreatedSerializer implements PrimitiveSerializer<ProductCreated> {
  @override
  final Iterable<Type> types = const [ProductCreated, _$ProductCreated];

  @override
  final String wireName = r'ProductCreated';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProductCreated object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
    if (object.createdAt != null) {
      yield r'created_at';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProductCreated object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProductCreatedBuilder result,
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
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProductCreated deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductCreatedBuilder();
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

