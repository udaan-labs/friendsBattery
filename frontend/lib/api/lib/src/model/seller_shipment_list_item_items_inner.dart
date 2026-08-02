//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'seller_shipment_list_item_items_inner.g.dart';

/// SellerShipmentListItemItemsInner
///
/// Properties:
/// * [productName] 
/// * [productModel] 
/// * [quantity] 
@BuiltValue()
abstract class SellerShipmentListItemItemsInner implements Built<SellerShipmentListItemItemsInner, SellerShipmentListItemItemsInnerBuilder> {
  @BuiltValueField(wireName: r'productName')
  String? get productName;

  @BuiltValueField(wireName: r'productModel')
  String? get productModel;

  @BuiltValueField(wireName: r'quantity')
  int? get quantity;

  SellerShipmentListItemItemsInner._();

  factory SellerShipmentListItemItemsInner([void updates(SellerShipmentListItemItemsInnerBuilder b)]) = _$SellerShipmentListItemItemsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SellerShipmentListItemItemsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SellerShipmentListItemItemsInner> get serializer => _$SellerShipmentListItemItemsInnerSerializer();
}

class _$SellerShipmentListItemItemsInnerSerializer implements PrimitiveSerializer<SellerShipmentListItemItemsInner> {
  @override
  final Iterable<Type> types = const [SellerShipmentListItemItemsInner, _$SellerShipmentListItemItemsInner];

  @override
  final String wireName = r'SellerShipmentListItemItemsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SellerShipmentListItemItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SellerShipmentListItemItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SellerShipmentListItemItemsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  SellerShipmentListItemItemsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SellerShipmentListItemItemsInnerBuilder();
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

