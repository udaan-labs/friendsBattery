//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/seller_shipment_list_item_items_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'seller_shipment_list_item.g.dart';

/// SellerShipmentListItem
///
/// Properties:
/// * [shipmentId] 
/// * [shipmentNumber] 
/// * [status] 
/// * [createdAt] 
/// * [acceptedAt] 
/// * [items] 
@BuiltValue()
abstract class SellerShipmentListItem implements Built<SellerShipmentListItem, SellerShipmentListItemBuilder> {
  @BuiltValueField(wireName: r'shipmentId')
  int? get shipmentId;

  @BuiltValueField(wireName: r'shipmentNumber')
  String? get shipmentNumber;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'createdAt')
  String? get createdAt;

  @BuiltValueField(wireName: r'acceptedAt')
  String? get acceptedAt;

  @BuiltValueField(wireName: r'items')
  BuiltList<SellerShipmentListItemItemsInner>? get items;

  SellerShipmentListItem._();

  factory SellerShipmentListItem([void updates(SellerShipmentListItemBuilder b)]) = _$SellerShipmentListItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SellerShipmentListItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SellerShipmentListItem> get serializer => _$SellerShipmentListItemSerializer();
}

class _$SellerShipmentListItemSerializer implements PrimitiveSerializer<SellerShipmentListItem> {
  @override
  final Iterable<Type> types = const [SellerShipmentListItem, _$SellerShipmentListItem];

  @override
  final String wireName = r'SellerShipmentListItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SellerShipmentListItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.shipmentId != null) {
      yield r'shipmentId';
      yield serializers.serialize(
        object.shipmentId,
        specifiedType: const FullType(int),
      );
    }
    if (object.shipmentNumber != null) {
      yield r'shipmentNumber';
      yield serializers.serialize(
        object.shipmentNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(String),
      );
    }
    if (object.acceptedAt != null) {
      yield r'acceptedAt';
      yield serializers.serialize(
        object.acceptedAt,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(SellerShipmentListItemItemsInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SellerShipmentListItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SellerShipmentListItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'shipmentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.shipmentId = valueDes;
          break;
        case r'shipmentNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.shipmentNumber = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createdAt = valueDes;
          break;
        case r'acceptedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.acceptedAt = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(SellerShipmentListItemItemsInner)]),
          ) as BuiltList<SellerShipmentListItemItemsInner>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SellerShipmentListItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SellerShipmentListItemBuilder();
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

