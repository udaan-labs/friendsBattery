// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_sale_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminSaleRecordSaleTypeEnum _$adminSaleRecordSaleTypeEnum_NORMAL =
    const AdminSaleRecordSaleTypeEnum._('NORMAL');
const AdminSaleRecordSaleTypeEnum _$adminSaleRecordSaleTypeEnum_SCRAP =
    const AdminSaleRecordSaleTypeEnum._('SCRAP');
const AdminSaleRecordSaleTypeEnum _$adminSaleRecordSaleTypeEnum_MECHANIC =
    const AdminSaleRecordSaleTypeEnum._('MECHANIC');
const AdminSaleRecordSaleTypeEnum _$adminSaleRecordSaleTypeEnum_SERVICE =
    const AdminSaleRecordSaleTypeEnum._('SERVICE');
const AdminSaleRecordSaleTypeEnum _$adminSaleRecordSaleTypeEnum_RENT =
    const AdminSaleRecordSaleTypeEnum._('RENT');

AdminSaleRecordSaleTypeEnum _$adminSaleRecordSaleTypeEnumValueOf(String name) {
  switch (name) {
    case 'NORMAL':
      return _$adminSaleRecordSaleTypeEnum_NORMAL;
    case 'SCRAP':
      return _$adminSaleRecordSaleTypeEnum_SCRAP;
    case 'MECHANIC':
      return _$adminSaleRecordSaleTypeEnum_MECHANIC;
    case 'SERVICE':
      return _$adminSaleRecordSaleTypeEnum_SERVICE;
    case 'RENT':
      return _$adminSaleRecordSaleTypeEnum_RENT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AdminSaleRecordSaleTypeEnum>
_$adminSaleRecordSaleTypeEnumValues =
    BuiltSet<AdminSaleRecordSaleTypeEnum>(const <AdminSaleRecordSaleTypeEnum>[
      _$adminSaleRecordSaleTypeEnum_NORMAL,
      _$adminSaleRecordSaleTypeEnum_SCRAP,
      _$adminSaleRecordSaleTypeEnum_MECHANIC,
      _$adminSaleRecordSaleTypeEnum_SERVICE,
      _$adminSaleRecordSaleTypeEnum_RENT,
    ]);

const AdminSaleRecordPaymentModeEnum _$adminSaleRecordPaymentModeEnum_CASH =
    const AdminSaleRecordPaymentModeEnum._('CASH');
const AdminSaleRecordPaymentModeEnum _$adminSaleRecordPaymentModeEnum_ONLINE =
    const AdminSaleRecordPaymentModeEnum._('ONLINE');
const AdminSaleRecordPaymentModeEnum _$adminSaleRecordPaymentModeEnum_CREDIT =
    const AdminSaleRecordPaymentModeEnum._('CREDIT');

AdminSaleRecordPaymentModeEnum _$adminSaleRecordPaymentModeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'CASH':
      return _$adminSaleRecordPaymentModeEnum_CASH;
    case 'ONLINE':
      return _$adminSaleRecordPaymentModeEnum_ONLINE;
    case 'CREDIT':
      return _$adminSaleRecordPaymentModeEnum_CREDIT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AdminSaleRecordPaymentModeEnum>
_$adminSaleRecordPaymentModeEnumValues =
    BuiltSet<AdminSaleRecordPaymentModeEnum>(
      const <AdminSaleRecordPaymentModeEnum>[
        _$adminSaleRecordPaymentModeEnum_CASH,
        _$adminSaleRecordPaymentModeEnum_ONLINE,
        _$adminSaleRecordPaymentModeEnum_CREDIT,
      ],
    );

Serializer<AdminSaleRecordSaleTypeEnum>
_$adminSaleRecordSaleTypeEnumSerializer =
    _$AdminSaleRecordSaleTypeEnumSerializer();
Serializer<AdminSaleRecordPaymentModeEnum>
_$adminSaleRecordPaymentModeEnumSerializer =
    _$AdminSaleRecordPaymentModeEnumSerializer();

class _$AdminSaleRecordSaleTypeEnumSerializer
    implements PrimitiveSerializer<AdminSaleRecordSaleTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'NORMAL': 'NORMAL',
    'SCRAP': 'SCRAP',
    'MECHANIC': 'MECHANIC',
    'SERVICE': 'SERVICE',
    'RENT': 'RENT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'NORMAL': 'NORMAL',
    'SCRAP': 'SCRAP',
    'MECHANIC': 'MECHANIC',
    'SERVICE': 'SERVICE',
    'RENT': 'RENT',
  };

  @override
  final Iterable<Type> types = const <Type>[AdminSaleRecordSaleTypeEnum];
  @override
  final String wireName = 'AdminSaleRecordSaleTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminSaleRecordSaleTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminSaleRecordSaleTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminSaleRecordSaleTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminSaleRecordPaymentModeEnumSerializer
    implements PrimitiveSerializer<AdminSaleRecordPaymentModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CASH': 'CASH',
    'ONLINE': 'ONLINE',
    'CREDIT': 'CREDIT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CASH': 'CASH',
    'ONLINE': 'ONLINE',
    'CREDIT': 'CREDIT',
  };

  @override
  final Iterable<Type> types = const <Type>[AdminSaleRecordPaymentModeEnum];
  @override
  final String wireName = 'AdminSaleRecordPaymentModeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminSaleRecordPaymentModeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminSaleRecordPaymentModeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminSaleRecordPaymentModeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminSaleRecord extends AdminSaleRecord {
  @override
  final int? id;
  @override
  final DateTime? soldAt;
  @override
  final int? quantity;
  @override
  final num? sellPrice;
  @override
  final String? serialNumber;
  @override
  final String? vehicleNumber;
  @override
  final AdminSaleRecordSaleTypeEnum? saleType;
  @override
  final AdminSaleRecordPaymentModeEnum? paymentMode;
  @override
  final num? amountPaid;
  @override
  final num? amountDue;
  @override
  final String? scrapSerial;
  @override
  final String? serviceType;
  @override
  final String? rentStatus;
  @override
  final num? deposit;
  @override
  final String? place;
  @override
  final SaleSeller? seller;
  @override
  final SaleCustomer? customer;
  @override
  final SaleProduct? product;
  @override
  final AdminSaleShipment? shipment;

  factory _$AdminSaleRecord([void Function(AdminSaleRecordBuilder)? updates]) =>
      (AdminSaleRecordBuilder()..update(updates))._build();

  _$AdminSaleRecord._({
    this.id,
    this.soldAt,
    this.quantity,
    this.sellPrice,
    this.serialNumber,
    this.vehicleNumber,
    this.saleType,
    this.paymentMode,
    this.amountPaid,
    this.amountDue,
    this.scrapSerial,
    this.serviceType,
    this.rentStatus,
    this.deposit,
    this.place,
    this.seller,
    this.customer,
    this.product,
    this.shipment,
  }) : super._();
  @override
  AdminSaleRecord rebuild(void Function(AdminSaleRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdminSaleRecordBuilder toBuilder() => AdminSaleRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminSaleRecord &&
        id == other.id &&
        soldAt == other.soldAt &&
        quantity == other.quantity &&
        sellPrice == other.sellPrice &&
        serialNumber == other.serialNumber &&
        vehicleNumber == other.vehicleNumber &&
        saleType == other.saleType &&
        paymentMode == other.paymentMode &&
        amountPaid == other.amountPaid &&
        amountDue == other.amountDue &&
        scrapSerial == other.scrapSerial &&
        serviceType == other.serviceType &&
        rentStatus == other.rentStatus &&
        deposit == other.deposit &&
        place == other.place &&
        seller == other.seller &&
        customer == other.customer &&
        product == other.product &&
        shipment == other.shipment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, soldAt.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, sellPrice.hashCode);
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, vehicleNumber.hashCode);
    _$hash = $jc(_$hash, saleType.hashCode);
    _$hash = $jc(_$hash, paymentMode.hashCode);
    _$hash = $jc(_$hash, amountPaid.hashCode);
    _$hash = $jc(_$hash, amountDue.hashCode);
    _$hash = $jc(_$hash, scrapSerial.hashCode);
    _$hash = $jc(_$hash, serviceType.hashCode);
    _$hash = $jc(_$hash, rentStatus.hashCode);
    _$hash = $jc(_$hash, deposit.hashCode);
    _$hash = $jc(_$hash, place.hashCode);
    _$hash = $jc(_$hash, seller.hashCode);
    _$hash = $jc(_$hash, customer.hashCode);
    _$hash = $jc(_$hash, product.hashCode);
    _$hash = $jc(_$hash, shipment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminSaleRecord')
          ..add('id', id)
          ..add('soldAt', soldAt)
          ..add('quantity', quantity)
          ..add('sellPrice', sellPrice)
          ..add('serialNumber', serialNumber)
          ..add('vehicleNumber', vehicleNumber)
          ..add('saleType', saleType)
          ..add('paymentMode', paymentMode)
          ..add('amountPaid', amountPaid)
          ..add('amountDue', amountDue)
          ..add('scrapSerial', scrapSerial)
          ..add('serviceType', serviceType)
          ..add('rentStatus', rentStatus)
          ..add('deposit', deposit)
          ..add('place', place)
          ..add('seller', seller)
          ..add('customer', customer)
          ..add('product', product)
          ..add('shipment', shipment))
        .toString();
  }
}

class AdminSaleRecordBuilder
    implements Builder<AdminSaleRecord, AdminSaleRecordBuilder> {
  _$AdminSaleRecord? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  DateTime? _soldAt;
  DateTime? get soldAt => _$this._soldAt;
  set soldAt(DateTime? soldAt) => _$this._soldAt = soldAt;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  num? _sellPrice;
  num? get sellPrice => _$this._sellPrice;
  set sellPrice(num? sellPrice) => _$this._sellPrice = sellPrice;

  String? _serialNumber;
  String? get serialNumber => _$this._serialNumber;
  set serialNumber(String? serialNumber) => _$this._serialNumber = serialNumber;

  String? _vehicleNumber;
  String? get vehicleNumber => _$this._vehicleNumber;
  set vehicleNumber(String? vehicleNumber) =>
      _$this._vehicleNumber = vehicleNumber;

  AdminSaleRecordSaleTypeEnum? _saleType;
  AdminSaleRecordSaleTypeEnum? get saleType => _$this._saleType;
  set saleType(AdminSaleRecordSaleTypeEnum? saleType) =>
      _$this._saleType = saleType;

  AdminSaleRecordPaymentModeEnum? _paymentMode;
  AdminSaleRecordPaymentModeEnum? get paymentMode => _$this._paymentMode;
  set paymentMode(AdminSaleRecordPaymentModeEnum? paymentMode) =>
      _$this._paymentMode = paymentMode;

  num? _amountPaid;
  num? get amountPaid => _$this._amountPaid;
  set amountPaid(num? amountPaid) => _$this._amountPaid = amountPaid;

  num? _amountDue;
  num? get amountDue => _$this._amountDue;
  set amountDue(num? amountDue) => _$this._amountDue = amountDue;

  String? _scrapSerial;
  String? get scrapSerial => _$this._scrapSerial;
  set scrapSerial(String? scrapSerial) => _$this._scrapSerial = scrapSerial;

  String? _serviceType;
  String? get serviceType => _$this._serviceType;
  set serviceType(String? serviceType) => _$this._serviceType = serviceType;

  String? _rentStatus;
  String? get rentStatus => _$this._rentStatus;
  set rentStatus(String? rentStatus) => _$this._rentStatus = rentStatus;

  num? _deposit;
  num? get deposit => _$this._deposit;
  set deposit(num? deposit) => _$this._deposit = deposit;

  String? _place;
  String? get place => _$this._place;
  set place(String? place) => _$this._place = place;

  SaleSellerBuilder? _seller;
  SaleSellerBuilder get seller => _$this._seller ??= SaleSellerBuilder();
  set seller(SaleSellerBuilder? seller) => _$this._seller = seller;

  SaleCustomerBuilder? _customer;
  SaleCustomerBuilder get customer =>
      _$this._customer ??= SaleCustomerBuilder();
  set customer(SaleCustomerBuilder? customer) => _$this._customer = customer;

  SaleProductBuilder? _product;
  SaleProductBuilder get product => _$this._product ??= SaleProductBuilder();
  set product(SaleProductBuilder? product) => _$this._product = product;

  AdminSaleShipmentBuilder? _shipment;
  AdminSaleShipmentBuilder get shipment =>
      _$this._shipment ??= AdminSaleShipmentBuilder();
  set shipment(AdminSaleShipmentBuilder? shipment) =>
      _$this._shipment = shipment;

  AdminSaleRecordBuilder() {
    AdminSaleRecord._defaults(this);
  }

  AdminSaleRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _soldAt = $v.soldAt;
      _quantity = $v.quantity;
      _sellPrice = $v.sellPrice;
      _serialNumber = $v.serialNumber;
      _vehicleNumber = $v.vehicleNumber;
      _saleType = $v.saleType;
      _paymentMode = $v.paymentMode;
      _amountPaid = $v.amountPaid;
      _amountDue = $v.amountDue;
      _scrapSerial = $v.scrapSerial;
      _serviceType = $v.serviceType;
      _rentStatus = $v.rentStatus;
      _deposit = $v.deposit;
      _place = $v.place;
      _seller = $v.seller?.toBuilder();
      _customer = $v.customer?.toBuilder();
      _product = $v.product?.toBuilder();
      _shipment = $v.shipment?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminSaleRecord other) {
    _$v = other as _$AdminSaleRecord;
  }

  @override
  void update(void Function(AdminSaleRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminSaleRecord build() => _build();

  _$AdminSaleRecord _build() {
    _$AdminSaleRecord _$result;
    try {
      _$result =
          _$v ??
          _$AdminSaleRecord._(
            id: id,
            soldAt: soldAt,
            quantity: quantity,
            sellPrice: sellPrice,
            serialNumber: serialNumber,
            vehicleNumber: vehicleNumber,
            saleType: saleType,
            paymentMode: paymentMode,
            amountPaid: amountPaid,
            amountDue: amountDue,
            scrapSerial: scrapSerial,
            serviceType: serviceType,
            rentStatus: rentStatus,
            deposit: deposit,
            place: place,
            seller: _seller?.build(),
            customer: _customer?.build(),
            product: _product?.build(),
            shipment: _shipment?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'seller';
        _seller?.build();
        _$failedField = 'customer';
        _customer?.build();
        _$failedField = 'product';
        _product?.build();
        _$failedField = 'shipment';
        _shipment?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminSaleRecord',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
