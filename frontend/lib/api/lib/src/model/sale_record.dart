//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/sale_customer.dart';
import 'package:friends_battery_api/src/model/sale_product.dart';
import 'package:friends_battery_api/src/model/sale_seller.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sale_record.g.dart';

/// SaleRecord
///
/// Properties:
/// * [id] 
/// * [productId] 
/// * [productUnitId] 
/// * [sellPrice] 
/// * [serialNumber] 
/// * [vehicleNumber] 
/// * [saleType] 
/// * [paymentMode] 
/// * [amountPaid] 
/// * [amountDue] 
/// * [scrapSerial] 
/// * [serviceType] 
/// * [rentStatus] 
/// * [deposit] 
/// * [place] 
/// * [soldAt] 
/// * [quantity] 
/// * [customer] 
/// * [seller] 
/// * [product] 
@BuiltValue()
abstract class SaleRecord implements Built<SaleRecord, SaleRecordBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'product_id')
  int? get productId;

  @BuiltValueField(wireName: r'product_unit_id')
  int? get productUnitId;

  @BuiltValueField(wireName: r'sell_price')
  num? get sellPrice;

  @BuiltValueField(wireName: r'serial_number')
  String? get serialNumber;

  @BuiltValueField(wireName: r'vehicle_number')
  String? get vehicleNumber;

  @BuiltValueField(wireName: r'sale_type')
  SaleRecordSaleTypeEnum? get saleType;
  // enum saleTypeEnum {  NORMAL,  SCRAP,  MECHANIC,  SERVICE,  RENT,  };

  @BuiltValueField(wireName: r'payment_mode')
  SaleRecordPaymentModeEnum? get paymentMode;
  // enum paymentModeEnum {  CASH,  ONLINE,  CREDIT,  };

  @BuiltValueField(wireName: r'amount_paid')
  num? get amountPaid;

  @BuiltValueField(wireName: r'amount_due')
  num? get amountDue;

  @BuiltValueField(wireName: r'scrap_serial')
  String? get scrapSerial;

  @BuiltValueField(wireName: r'service_type')
  String? get serviceType;

  @BuiltValueField(wireName: r'rent_status')
  String? get rentStatus;

  @BuiltValueField(wireName: r'deposit')
  num? get deposit;

  @BuiltValueField(wireName: r'place')
  String? get place;

  @BuiltValueField(wireName: r'sold_at')
  DateTime? get soldAt;

  @BuiltValueField(wireName: r'quantity')
  int? get quantity;

  @BuiltValueField(wireName: r'customer')
  SaleCustomer? get customer;

  @BuiltValueField(wireName: r'seller')
  SaleSeller? get seller;

  @BuiltValueField(wireName: r'product')
  SaleProduct? get product;

  SaleRecord._();

  factory SaleRecord([void updates(SaleRecordBuilder b)]) = _$SaleRecord;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SaleRecordBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SaleRecord> get serializer => _$SaleRecordSerializer();
}

class _$SaleRecordSerializer implements PrimitiveSerializer<SaleRecord> {
  @override
  final Iterable<Type> types = const [SaleRecord, _$SaleRecord];

  @override
  final String wireName = r'SaleRecord';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SaleRecord object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.productId != null) {
      yield r'product_id';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType(int),
      );
    }
    if (object.productUnitId != null) {
      yield r'product_unit_id';
      yield serializers.serialize(
        object.productUnitId,
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
    if (object.saleType != null) {
      yield r'sale_type';
      yield serializers.serialize(
        object.saleType,
        specifiedType: const FullType(SaleRecordSaleTypeEnum),
      );
    }
    if (object.paymentMode != null) {
      yield r'payment_mode';
      yield serializers.serialize(
        object.paymentMode,
        specifiedType: const FullType(SaleRecordPaymentModeEnum),
      );
    }
    if (object.amountPaid != null) {
      yield r'amount_paid';
      yield serializers.serialize(
        object.amountPaid,
        specifiedType: const FullType(num),
      );
    }
    if (object.amountDue != null) {
      yield r'amount_due';
      yield serializers.serialize(
        object.amountDue,
        specifiedType: const FullType(num),
      );
    }
    if (object.scrapSerial != null) {
      yield r'scrap_serial';
      yield serializers.serialize(
        object.scrapSerial,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.serviceType != null) {
      yield r'service_type';
      yield serializers.serialize(
        object.serviceType,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.rentStatus != null) {
      yield r'rent_status';
      yield serializers.serialize(
        object.rentStatus,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.deposit != null) {
      yield r'deposit';
      yield serializers.serialize(
        object.deposit,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.place != null) {
      yield r'place';
      yield serializers.serialize(
        object.place,
        specifiedType: const FullType.nullable(String),
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
    if (object.customer != null) {
      yield r'customer';
      yield serializers.serialize(
        object.customer,
        specifiedType: const FullType(SaleCustomer),
      );
    }
    if (object.seller != null) {
      yield r'seller';
      yield serializers.serialize(
        object.seller,
        specifiedType: const FullType(SaleSeller),
      );
    }
    if (object.product != null) {
      yield r'product';
      yield serializers.serialize(
        object.product,
        specifiedType: const FullType(SaleProduct),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SaleRecord object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SaleRecordBuilder result,
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
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productId = valueDes;
          break;
        case r'product_unit_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productUnitId = valueDes;
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
        case r'sale_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SaleRecordSaleTypeEnum),
          ) as SaleRecordSaleTypeEnum;
          result.saleType = valueDes;
          break;
        case r'payment_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SaleRecordPaymentModeEnum),
          ) as SaleRecordPaymentModeEnum;
          result.paymentMode = valueDes;
          break;
        case r'amount_paid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amountPaid = valueDes;
          break;
        case r'amount_due':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amountDue = valueDes;
          break;
        case r'scrap_serial':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.scrapSerial = valueDes;
          break;
        case r'service_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.serviceType = valueDes;
          break;
        case r'rent_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.rentStatus = valueDes;
          break;
        case r'deposit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.deposit = valueDes;
          break;
        case r'place':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.place = valueDes;
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
        case r'customer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SaleCustomer),
          ) as SaleCustomer;
          result.customer.replace(valueDes);
          break;
        case r'seller':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SaleSeller),
          ) as SaleSeller;
          result.seller.replace(valueDes);
          break;
        case r'product':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SaleProduct),
          ) as SaleProduct;
          result.product.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SaleRecord deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SaleRecordBuilder();
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

class SaleRecordSaleTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'NORMAL')
  static const SaleRecordSaleTypeEnum NORMAL = _$saleRecordSaleTypeEnum_NORMAL;
  @BuiltValueEnumConst(wireName: r'SCRAP')
  static const SaleRecordSaleTypeEnum SCRAP = _$saleRecordSaleTypeEnum_SCRAP;
  @BuiltValueEnumConst(wireName: r'MECHANIC')
  static const SaleRecordSaleTypeEnum MECHANIC = _$saleRecordSaleTypeEnum_MECHANIC;
  @BuiltValueEnumConst(wireName: r'SERVICE')
  static const SaleRecordSaleTypeEnum SERVICE = _$saleRecordSaleTypeEnum_SERVICE;
  @BuiltValueEnumConst(wireName: r'RENT')
  static const SaleRecordSaleTypeEnum RENT = _$saleRecordSaleTypeEnum_RENT;

  static Serializer<SaleRecordSaleTypeEnum> get serializer => _$saleRecordSaleTypeEnumSerializer;

  const SaleRecordSaleTypeEnum._(String name): super(name);

  static BuiltSet<SaleRecordSaleTypeEnum> get values => _$saleRecordSaleTypeEnumValues;
  static SaleRecordSaleTypeEnum valueOf(String name) => _$saleRecordSaleTypeEnumValueOf(name);
}

class SaleRecordPaymentModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CASH')
  static const SaleRecordPaymentModeEnum CASH = _$saleRecordPaymentModeEnum_CASH;
  @BuiltValueEnumConst(wireName: r'ONLINE')
  static const SaleRecordPaymentModeEnum ONLINE = _$saleRecordPaymentModeEnum_ONLINE;
  @BuiltValueEnumConst(wireName: r'CREDIT')
  static const SaleRecordPaymentModeEnum CREDIT = _$saleRecordPaymentModeEnum_CREDIT;

  static Serializer<SaleRecordPaymentModeEnum> get serializer => _$saleRecordPaymentModeEnumSerializer;

  const SaleRecordPaymentModeEnum._(String name): super(name);

  static BuiltSet<SaleRecordPaymentModeEnum> get values => _$saleRecordPaymentModeEnumValues;
  static SaleRecordPaymentModeEnum valueOf(String name) => _$saleRecordPaymentModeEnumValueOf(name);
}

