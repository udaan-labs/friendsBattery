//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_sale_shipment.g.dart';

/// AdminSaleShipment
///
/// Properties:
/// * [id] 
/// * [shipmentNumber] 
/// * [shipmentDate] 
/// * [arrivalDate] 
/// * [status] 
@BuiltValue()
abstract class AdminSaleShipment implements Built<AdminSaleShipment, AdminSaleShipmentBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'shipment_number')
  String? get shipmentNumber;

  @BuiltValueField(wireName: r'shipment_date')
  DateTime? get shipmentDate;

  @BuiltValueField(wireName: r'arrival_date')
  DateTime? get arrivalDate;

  @BuiltValueField(wireName: r'status')
  String? get status;

  AdminSaleShipment._();

  factory AdminSaleShipment([void updates(AdminSaleShipmentBuilder b)]) = _$AdminSaleShipment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminSaleShipmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminSaleShipment> get serializer => _$AdminSaleShipmentSerializer();
}

class _$AdminSaleShipmentSerializer implements PrimitiveSerializer<AdminSaleShipment> {
  @override
  final Iterable<Type> types = const [AdminSaleShipment, _$AdminSaleShipment];

  @override
  final String wireName = r'AdminSaleShipment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminSaleShipment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.shipmentNumber != null) {
      yield r'shipment_number';
      yield serializers.serialize(
        object.shipmentNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.shipmentDate != null) {
      yield r'shipment_date';
      yield serializers.serialize(
        object.shipmentDate,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.arrivalDate != null) {
      yield r'arrival_date';
      yield serializers.serialize(
        object.arrivalDate,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminSaleShipment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminSaleShipmentBuilder result,
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
        case r'shipment_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.shipmentNumber = valueDes;
          break;
        case r'shipment_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.shipmentDate = valueDes;
          break;
        case r'arrival_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.arrivalDate = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminSaleShipment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminSaleShipmentBuilder();
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

