//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'shipment_item.g.dart';

/// ShipmentItem
///
/// Properties:
/// * [id] 
/// * [shipmentId] 
/// * [productId] 
/// * [quantity] 
/// * [pricePerPiece] 
/// * [isShipmentRequested] 
@BuiltValue()
abstract class ShipmentItem implements Built<ShipmentItem, ShipmentItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'shipmentId')
  String? get shipmentId;

  @BuiltValueField(wireName: r'productId')
  String? get productId;

  @BuiltValueField(wireName: r'quantity')
  int? get quantity;

  @BuiltValueField(wireName: r'pricePerPiece')
  double? get pricePerPiece;

  @BuiltValueField(wireName: r'isShipmentRequested')
  bool? get isShipmentRequested;

  ShipmentItem._();

  factory ShipmentItem([void updates(ShipmentItemBuilder b)]) = _$ShipmentItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ShipmentItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ShipmentItem> get serializer => _$ShipmentItemSerializer();
}

class _$ShipmentItemSerializer implements PrimitiveSerializer<ShipmentItem> {
  @override
  final Iterable<Type> types = const [ShipmentItem, _$ShipmentItem];

  @override
  final String wireName = r'ShipmentItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ShipmentItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.shipmentId != null) {
      yield r'shipmentId';
      yield serializers.serialize(
        object.shipmentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.productId != null) {
      yield r'productId';
      yield serializers.serialize(
        object.productId,
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
    if (object.pricePerPiece != null) {
      yield r'pricePerPiece';
      yield serializers.serialize(
        object.pricePerPiece,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.isShipmentRequested != null) {
      yield r'isShipmentRequested';
      yield serializers.serialize(
        object.isShipmentRequested,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ShipmentItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ShipmentItemBuilder result,
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
        case r'shipmentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.shipmentId = valueDes;
          break;
        case r'productId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.quantity = valueDes;
          break;
        case r'pricePerPiece':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.pricePerPiece = valueDes;
          break;
        case r'isShipmentRequested':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isShipmentRequested = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ShipmentItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ShipmentItemBuilder();
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

