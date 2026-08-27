//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'seller_recent_sale.g.dart';

/// SellerRecentSale
///
/// Properties:
/// * [id] 
/// * [customerName] 
/// * [productName] 
/// * [productModel] 
/// * [serialNumber] 
/// * [sellPrice] 
/// * [soldAt] 
@BuiltValue()
abstract class SellerRecentSale implements Built<SellerRecentSale, SellerRecentSaleBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'customerName')
  String? get customerName;

  @BuiltValueField(wireName: r'productName')
  String? get productName;

  @BuiltValueField(wireName: r'productModel')
  String? get productModel;

  @BuiltValueField(wireName: r'serialNumber')
  String? get serialNumber;

  @BuiltValueField(wireName: r'sellPrice')
  num? get sellPrice;

  @BuiltValueField(wireName: r'soldAt')
  DateTime? get soldAt;

  SellerRecentSale._();

  factory SellerRecentSale([void updates(SellerRecentSaleBuilder b)]) = _$SellerRecentSale;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SellerRecentSaleBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SellerRecentSale> get serializer => _$SellerRecentSaleSerializer();
}

class _$SellerRecentSaleSerializer implements PrimitiveSerializer<SellerRecentSale> {
  @override
  final Iterable<Type> types = const [SellerRecentSale, _$SellerRecentSale];

  @override
  final String wireName = r'SellerRecentSale';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SellerRecentSale object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.customerName != null) {
      yield r'customerName';
      yield serializers.serialize(
        object.customerName,
        specifiedType: const FullType(String),
      );
    }
    if (object.productName != null) {
      yield r'productName';
      yield serializers.serialize(
        object.productName,
        specifiedType: const FullType(String),
      );
    }
    if (object.productModel != null) {
      yield r'productModel';
      yield serializers.serialize(
        object.productModel,
        specifiedType: const FullType(String),
      );
    }
    if (object.serialNumber != null) {
      yield r'serialNumber';
      yield serializers.serialize(
        object.serialNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.sellPrice != null) {
      yield r'sellPrice';
      yield serializers.serialize(
        object.sellPrice,
        specifiedType: const FullType(num),
      );
    }
    if (object.soldAt != null) {
      yield r'soldAt';
      yield serializers.serialize(
        object.soldAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SellerRecentSale object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SellerRecentSaleBuilder result,
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
        case r'customerName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerName = valueDes;
          break;
        case r'productName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productName = valueDes;
          break;
        case r'productModel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productModel = valueDes;
          break;
        case r'serialNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.serialNumber = valueDes;
          break;
        case r'sellPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.sellPrice = valueDes;
          break;
        case r'soldAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.soldAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SellerRecentSale deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SellerRecentSaleBuilder();
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

