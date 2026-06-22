//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_inventory_product_id_get200_response_data.g.dart';

/// ApiInventoryProductIdGet200ResponseData
///
/// Properties:
/// * [productId] 
/// * [category] 
/// * [brand] 
/// * [model] 
/// * [quantity] 
/// * [minPrice] 
/// * [offerPrice] 
@BuiltValue()
abstract class ApiInventoryProductIdGet200ResponseData implements Built<ApiInventoryProductIdGet200ResponseData, ApiInventoryProductIdGet200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'product_id')
  int? get productId;

  @BuiltValueField(wireName: r'category')
  String? get category;

  @BuiltValueField(wireName: r'brand')
  String? get brand;

  @BuiltValueField(wireName: r'model')
  String? get model;

  @BuiltValueField(wireName: r'quantity')
  int? get quantity;

  @BuiltValueField(wireName: r'min_price')
  num? get minPrice;

  @BuiltValueField(wireName: r'offer_price')
  num? get offerPrice;

  ApiInventoryProductIdGet200ResponseData._();

  factory ApiInventoryProductIdGet200ResponseData([void updates(ApiInventoryProductIdGet200ResponseDataBuilder b)]) = _$ApiInventoryProductIdGet200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiInventoryProductIdGet200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiInventoryProductIdGet200ResponseData> get serializer => _$ApiInventoryProductIdGet200ResponseDataSerializer();
}

class _$ApiInventoryProductIdGet200ResponseDataSerializer implements PrimitiveSerializer<ApiInventoryProductIdGet200ResponseData> {
  @override
  final Iterable<Type> types = const [ApiInventoryProductIdGet200ResponseData, _$ApiInventoryProductIdGet200ResponseData];

  @override
  final String wireName = r'ApiInventoryProductIdGet200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiInventoryProductIdGet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productId != null) {
      yield r'product_id';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType(int),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(String),
      );
    }
    if (object.brand != null) {
      yield r'brand';
      yield serializers.serialize(
        object.brand,
        specifiedType: const FullType(String),
      );
    }
    if (object.model != null) {
      yield r'model';
      yield serializers.serialize(
        object.model,
        specifiedType: const FullType(String),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
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
    if (object.offerPrice != null) {
      yield r'offer_price';
      yield serializers.serialize(
        object.offerPrice,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiInventoryProductIdGet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiInventoryProductIdGet200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productId = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'brand':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.brand = valueDes;
          break;
        case r'model':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.model = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.quantity = valueDes;
          break;
        case r'min_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minPrice = valueDes;
          break;
        case r'offer_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.offerPrice = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiInventoryProductIdGet200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiInventoryProductIdGet200ResponseDataBuilder();
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

