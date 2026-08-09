//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/product_model.dart';
import 'package:friends_battery_api/src/model/product_name.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product.g.dart';

/// Product
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
/// * [productName] 
/// * [productModel] 
@BuiltValue()
abstract class Product implements Built<Product, ProductBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'productNameId')
  String? get productNameId;

  @BuiltValueField(wireName: r'productModelId')
  String? get productModelId;

  @BuiltValueField(wireName: r'minPrice')
  double? get minPrice;

  @BuiltValueField(wireName: r'onSale')
  bool? get onSale;

  @BuiltValueField(wireName: r'offerPrice')
  double? get offerPrice;

  @BuiltValueField(wireName: r'minUnitCountAdmin')
  int? get minUnitCountAdmin;

  @BuiltValueField(wireName: r'minUnitCountSeller')
  int? get minUnitCountSeller;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'productName')
  ProductName? get productName;

  @BuiltValueField(wireName: r'productModel')
  ProductModel? get productModel;

  Product._();

  factory Product([void updates(ProductBuilder b)]) = _$Product;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Product> get serializer => _$ProductSerializer();
}

class _$ProductSerializer implements PrimitiveSerializer<Product> {
  @override
  final Iterable<Type> types = const [Product, _$Product];

  @override
  final String wireName = r'Product';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Product object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.productNameId != null) {
      yield r'productNameId';
      yield serializers.serialize(
        object.productNameId,
        specifiedType: const FullType(String),
      );
    }
    if (object.productModelId != null) {
      yield r'productModelId';
      yield serializers.serialize(
        object.productModelId,
        specifiedType: const FullType(String),
      );
    }
    if (object.minPrice != null) {
      yield r'minPrice';
      yield serializers.serialize(
        object.minPrice,
        specifiedType: const FullType(double),
      );
    }
    if (object.onSale != null) {
      yield r'onSale';
      yield serializers.serialize(
        object.onSale,
        specifiedType: const FullType(bool),
      );
    }
    if (object.offerPrice != null) {
      yield r'offerPrice';
      yield serializers.serialize(
        object.offerPrice,
        specifiedType: const FullType.nullable(double),
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
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.productName != null) {
      yield r'productName';
      yield serializers.serialize(
        object.productName,
        specifiedType: const FullType(ProductName),
      );
    }
    if (object.productModel != null) {
      yield r'productModel';
      yield serializers.serialize(
        object.productModel,
        specifiedType: const FullType(ProductModel),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Product object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProductBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'productNameId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productNameId = valueDes;
          break;
        case r'productModelId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productModelId = valueDes;
          break;
        case r'minPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.minPrice = valueDes;
          break;
        case r'onSale':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.onSale = valueDes;
          break;
        case r'offerPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.offerPrice = valueDes;
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
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'productName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductName),
          ) as ProductName;
          result.productName.replace(valueDes);
          break;
        case r'productModel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductModel),
          ) as ProductModel;
          result.productModel.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Product deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductBuilder();
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

