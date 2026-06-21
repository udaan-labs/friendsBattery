//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/shipment_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'shipment.g.dart';

/// Shipment
///
/// Properties:
/// * [id] 
/// * [fromUserId] 
/// * [toUserId] 
/// * [totalProductsShipped] 
/// * [shipmentPrice] 
/// * [status] 
/// * [shippedOn] 
/// * [deliveredOn] 
/// * [createdAt] 
/// * [items] 
@BuiltValue()
abstract class Shipment implements Built<Shipment, ShipmentBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'fromUserId')
  String? get fromUserId;

  @BuiltValueField(wireName: r'toUserId')
  String? get toUserId;

  @BuiltValueField(wireName: r'totalProductsShipped')
  int? get totalProductsShipped;

  @BuiltValueField(wireName: r'shipmentPrice')
  double? get shipmentPrice;

  @BuiltValueField(wireName: r'status')
  ShipmentStatusEnum? get status;
  // enum statusEnum {  PENDING,  APPROVED,  REJECTED,  SHIPPED,  DELIVERED,  };

  @BuiltValueField(wireName: r'shippedOn')
  DateTime? get shippedOn;

  @BuiltValueField(wireName: r'deliveredOn')
  DateTime? get deliveredOn;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'items')
  BuiltList<ShipmentItem>? get items;

  Shipment._();

  factory Shipment([void updates(ShipmentBuilder b)]) = _$Shipment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ShipmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Shipment> get serializer => _$ShipmentSerializer();
}

class _$ShipmentSerializer implements PrimitiveSerializer<Shipment> {
  @override
  final Iterable<Type> types = const [Shipment, _$Shipment];

  @override
  final String wireName = r'Shipment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Shipment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.fromUserId != null) {
      yield r'fromUserId';
      yield serializers.serialize(
        object.fromUserId,
        specifiedType: const FullType(String),
      );
    }
    if (object.toUserId != null) {
      yield r'toUserId';
      yield serializers.serialize(
        object.toUserId,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalProductsShipped != null) {
      yield r'totalProductsShipped';
      yield serializers.serialize(
        object.totalProductsShipped,
        specifiedType: const FullType(int),
      );
    }
    if (object.shipmentPrice != null) {
      yield r'shipmentPrice';
      yield serializers.serialize(
        object.shipmentPrice,
        specifiedType: const FullType(double),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(ShipmentStatusEnum),
      );
    }
    if (object.shippedOn != null) {
      yield r'shippedOn';
      yield serializers.serialize(
        object.shippedOn,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.deliveredOn != null) {
      yield r'deliveredOn';
      yield serializers.serialize(
        object.deliveredOn,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(ShipmentItem)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Shipment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ShipmentBuilder result,
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
        case r'fromUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fromUserId = valueDes;
          break;
        case r'toUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.toUserId = valueDes;
          break;
        case r'totalProductsShipped':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalProductsShipped = valueDes;
          break;
        case r'shipmentPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.shipmentPrice = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ShipmentStatusEnum),
          ) as ShipmentStatusEnum;
          result.status = valueDes;
          break;
        case r'shippedOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.shippedOn = valueDes;
          break;
        case r'deliveredOn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.deliveredOn = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ShipmentItem)]),
          ) as BuiltList<ShipmentItem>;
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
  Shipment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ShipmentBuilder();
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

class ShipmentStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const ShipmentStatusEnum PENDING = _$shipmentStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'APPROVED')
  static const ShipmentStatusEnum APPROVED = _$shipmentStatusEnum_APPROVED;
  @BuiltValueEnumConst(wireName: r'REJECTED')
  static const ShipmentStatusEnum REJECTED = _$shipmentStatusEnum_REJECTED;
  @BuiltValueEnumConst(wireName: r'SHIPPED')
  static const ShipmentStatusEnum SHIPPED = _$shipmentStatusEnum_SHIPPED;
  @BuiltValueEnumConst(wireName: r'DELIVERED')
  static const ShipmentStatusEnum DELIVERED = _$shipmentStatusEnum_DELIVERED;

  static Serializer<ShipmentStatusEnum> get serializer => _$shipmentStatusEnumSerializer;

  const ShipmentStatusEnum._(String name): super(name);

  static BuiltSet<ShipmentStatusEnum> get values => _$shipmentStatusEnumValues;
  static ShipmentStatusEnum valueOf(String name) => _$shipmentStatusEnumValueOf(name);
}

