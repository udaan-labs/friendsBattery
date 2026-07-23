//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/admin_sale_shipment.dart';
import 'package:friends_battery_api/src/model/sale_customer.dart';
import 'package:friends_battery_api/src/model/sale_product.dart';
import 'package:friends_battery_api/src/model/sale_seller.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_sale_record.g.dart';

/// AdminSaleRecord
///
/// Properties:
/// * [id] 
/// * [soldAt] 
/// * [quantity] 
/// * [sellPrice] 
/// * [serialNumber] 
/// * [vehicleNumber] 
/// * [seller] 
/// * [customer] 
/// * [product] 
/// * [shipment] 
@BuiltValue()
abstract class AdminSaleRecord implements Built<AdminSaleRecord, AdminSaleRecordBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'sold_at')
  DateTime? get soldAt;

  @BuiltValueField(wireName: r'quantity')
  int? get quantity;

  @BuiltValueField(wireName: r'sell_price')
  num? get sellPrice;

  @BuiltValueField(wireName: r'serial_number')
  String? get serialNumber;

  @BuiltValueField(wireName: r'vehicle_number')
  String? get vehicleNumber;

  @BuiltValueField(wireName: r'seller')
  SaleSeller? get seller;

  @BuiltValueField(wireName: r'customer')
  SaleCustomer? get customer;

  @BuiltValueField(wireName: r'product')
  SaleProduct? get product;

  @BuiltValueField(wireName: r'shipment')
  AdminSaleShipment? get shipment;

  AdminSaleRecord._();

  factory AdminSaleRecord([void updates(AdminSaleRecordBuilder b)]) = _$AdminSaleRecord;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminSaleRecordBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminSaleRecord> get serializer => _$AdminSaleRecordSerializer();
}

class _$AdminSaleRecordSerializer implements PrimitiveSerializer<AdminSaleRecord> {
  @override
  final Iterable<Type> types = const [AdminSaleRecord, _$AdminSaleRecord];

  @override
  final String wireName = r'AdminSaleRecord';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminSaleRecord object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.soldAt != null) {
      yield r'sold_at';
      yield serializers.serialize(
        object.soldAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(int),
      );
    }
    if (object.sellPrice != null) {
      yield r'sell_price';
      yield serializers.serialize(
        object.sellPrice,
        specifiedType: const FullType(num),
      );
    }
    if (object.serialNumber != null) {
      yield r'serial_number';
      yield serializers.serialize(
        object.serialNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.vehicleNumber != null) {
      yield r'vehicle_number';
      yield serializers.serialize(
        object.vehicleNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.seller != null) {
      yield r'seller';
      yield serializers.serialize(
        object.seller,
        specifiedType: const FullType(SaleSeller),
      );
    }
    if (object.customer != null) {
      yield r'customer';
      yield serializers.serialize(
        object.customer,
        specifiedType: const FullType(SaleCustomer),
      );
    }
    if (object.product != null) {
      yield r'product';
      yield serializers.serialize(
        object.product,
        specifiedType: const FullType(SaleProduct),
      );
    }
    if (object.shipment != null) {
      yield r'shipment';
      yield serializers.serialize(
        object.shipment,
        specifiedType: const FullType(AdminSaleShipment),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminSaleRecord object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminSaleRecordBuilder result,
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
        case r'sold_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.soldAt = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.quantity = valueDes;
          break;
        case r'sell_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.sellPrice = valueDes;
          break;
        case r'serial_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.serialNumber = valueDes;
          break;
        case r'vehicle_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.vehicleNumber = valueDes;
          break;
        case r'seller':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SaleSeller),
          ) as SaleSeller;
          result.seller.replace(valueDes);
          break;
        case r'customer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SaleCustomer),
          ) as SaleCustomer;
          result.customer.replace(valueDes);
          break;
        case r'product':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SaleProduct),
          ) as SaleProduct;
          result.product.replace(valueDes);
          break;
        case r'shipment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminSaleShipment),
          ) as AdminSaleShipment;
          result.shipment.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminSaleRecord deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminSaleRecordBuilder();
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

