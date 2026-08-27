// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SaleRecordSaleTypeEnum _$saleRecordSaleTypeEnum_NORMAL =
    const SaleRecordSaleTypeEnum._('NORMAL');
const SaleRecordSaleTypeEnum _$saleRecordSaleTypeEnum_SCRAP =
    const SaleRecordSaleTypeEnum._('SCRAP');
const SaleRecordSaleTypeEnum _$saleRecordSaleTypeEnum_MECHANIC =
    const SaleRecordSaleTypeEnum._('MECHANIC');
const SaleRecordSaleTypeEnum _$saleRecordSaleTypeEnum_SERVICE =
    const SaleRecordSaleTypeEnum._('SERVICE');
const SaleRecordSaleTypeEnum _$saleRecordSaleTypeEnum_RENT =
    const SaleRecordSaleTypeEnum._('RENT');

SaleRecordSaleTypeEnum _$saleRecordSaleTypeEnumValueOf(String name) {
  switch (name) {
    case 'NORMAL':
      return _$saleRecordSaleTypeEnum_NORMAL;
    case 'SCRAP':
      return _$saleRecordSaleTypeEnum_SCRAP;
    case 'MECHANIC':
      return _$saleRecordSaleTypeEnum_MECHANIC;
    case 'SERVICE':
      return _$saleRecordSaleTypeEnum_SERVICE;
    case 'RENT':
      return _$saleRecordSaleTypeEnum_RENT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<SaleRecordSaleTypeEnum> _$saleRecordSaleTypeEnumValues =
    BuiltSet<SaleRecordSaleTypeEnum>(const <SaleRecordSaleTypeEnum>[
      _$saleRecordSaleTypeEnum_NORMAL,
      _$saleRecordSaleTypeEnum_SCRAP,
      _$saleRecordSaleTypeEnum_MECHANIC,
      _$saleRecordSaleTypeEnum_SERVICE,
      _$saleRecordSaleTypeEnum_RENT,
    ]);

Serializer<SaleRecordSaleTypeEnum> _$saleRecordSaleTypeEnumSerializer =
    _$SaleRecordSaleTypeEnumSerializer();

class _$SaleRecordSaleTypeEnumSerializer
    implements PrimitiveSerializer<SaleRecordSaleTypeEnum> {
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
  final Iterable<Type> types = const <Type>[SaleRecordSaleTypeEnum];
  @override
  final String wireName = 'SaleRecordSaleTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    SaleRecordSaleTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SaleRecordSaleTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SaleRecordSaleTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SaleRecord extends SaleRecord {
  @override
  final int? id;
  @override
  final int? productId;
  @override
  final int? productUnitId;
  @override
  final num? sellPrice;
  @override
  final String? serialNumber;
  @override
  final String? vehicleNumber;
  @override
  final SaleRecordSaleTypeEnum? saleType;
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
  final DateTime? soldAt;
  @override
  final int? quantity;
  @override
  final SaleCustomer? customer;
  @override
  final SaleSeller? seller;
  @override
  final SaleProduct? product;

  factory _$SaleRecord([void Function(SaleRecordBuilder)? updates]) =>
      (SaleRecordBuilder()..update(updates))._build();

  _$SaleRecord._({
    this.id,
    this.productId,
    this.productUnitId,
    this.sellPrice,
    this.serialNumber,
    this.vehicleNumber,
    this.saleType,
    this.scrapSerial,
    this.serviceType,
    this.rentStatus,
    this.deposit,
    this.place,
    this.soldAt,
    this.quantity,
    this.customer,
    this.seller,
    this.product,
  }) : super._();
  @override
  SaleRecord rebuild(void Function(SaleRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SaleRecordBuilder toBuilder() => SaleRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SaleRecord &&
        id == other.id &&
        productId == other.productId &&
        productUnitId == other.productUnitId &&
        sellPrice == other.sellPrice &&
        serialNumber == other.serialNumber &&
        vehicleNumber == other.vehicleNumber &&
        saleType == other.saleType &&
        scrapSerial == other.scrapSerial &&
        serviceType == other.serviceType &&
        rentStatus == other.rentStatus &&
        deposit == other.deposit &&
        place == other.place &&
        soldAt == other.soldAt &&
        quantity == other.quantity &&
        customer == other.customer &&
        seller == other.seller &&
        product == other.product;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, productUnitId.hashCode);
    _$hash = $jc(_$hash, sellPrice.hashCode);
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, vehicleNumber.hashCode);
    _$hash = $jc(_$hash, saleType.hashCode);
    _$hash = $jc(_$hash, scrapSerial.hashCode);
    _$hash = $jc(_$hash, serviceType.hashCode);
    _$hash = $jc(_$hash, rentStatus.hashCode);
    _$hash = $jc(_$hash, deposit.hashCode);
    _$hash = $jc(_$hash, place.hashCode);
    _$hash = $jc(_$hash, soldAt.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, customer.hashCode);
    _$hash = $jc(_$hash, seller.hashCode);
    _$hash = $jc(_$hash, product.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SaleRecord')
          ..add('id', id)
          ..add('productId', productId)
          ..add('productUnitId', productUnitId)
          ..add('sellPrice', sellPrice)
          ..add('serialNumber', serialNumber)
          ..add('vehicleNumber', vehicleNumber)
          ..add('saleType', saleType)
          ..add('scrapSerial', scrapSerial)
          ..add('serviceType', serviceType)
          ..add('rentStatus', rentStatus)
          ..add('deposit', deposit)
          ..add('place', place)
          ..add('soldAt', soldAt)
          ..add('quantity', quantity)
          ..add('customer', customer)
          ..add('seller', seller)
          ..add('product', product))
        .toString();
  }
}

class SaleRecordBuilder implements Builder<SaleRecord, SaleRecordBuilder> {
  _$SaleRecord? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  int? _productUnitId;
  int? get productUnitId => _$this._productUnitId;
  set productUnitId(int? productUnitId) =>
      _$this._productUnitId = productUnitId;

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

  SaleRecordSaleTypeEnum? _saleType;
  SaleRecordSaleTypeEnum? get saleType => _$this._saleType;
  set saleType(SaleRecordSaleTypeEnum? saleType) => _$this._saleType = saleType;

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

  DateTime? _soldAt;
  DateTime? get soldAt => _$this._soldAt;
  set soldAt(DateTime? soldAt) => _$this._soldAt = soldAt;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  SaleCustomerBuilder? _customer;
  SaleCustomerBuilder get customer =>
      _$this._customer ??= SaleCustomerBuilder();
  set customer(SaleCustomerBuilder? customer) => _$this._customer = customer;

  SaleSellerBuilder? _seller;
  SaleSellerBuilder get seller => _$this._seller ??= SaleSellerBuilder();
  set seller(SaleSellerBuilder? seller) => _$this._seller = seller;

  SaleProductBuilder? _product;
  SaleProductBuilder get product => _$this._product ??= SaleProductBuilder();
  set product(SaleProductBuilder? product) => _$this._product = product;

  SaleRecordBuilder() {
    SaleRecord._defaults(this);
  }

  SaleRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _productId = $v.productId;
      _productUnitId = $v.productUnitId;
      _sellPrice = $v.sellPrice;
      _serialNumber = $v.serialNumber;
      _vehicleNumber = $v.vehicleNumber;
      _saleType = $v.saleType;
      _scrapSerial = $v.scrapSerial;
      _serviceType = $v.serviceType;
      _rentStatus = $v.rentStatus;
      _deposit = $v.deposit;
      _place = $v.place;
      _soldAt = $v.soldAt;
      _quantity = $v.quantity;
      _customer = $v.customer?.toBuilder();
      _seller = $v.seller?.toBuilder();
      _product = $v.product?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SaleRecord other) {
    _$v = other as _$SaleRecord;
  }

  @override
  void update(void Function(SaleRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SaleRecord build() => _build();

  _$SaleRecord _build() {
    _$SaleRecord _$result;
    try {
      _$result =
          _$v ??
          _$SaleRecord._(
            id: id,
            productId: productId,
            productUnitId: productUnitId,
            sellPrice: sellPrice,
            serialNumber: serialNumber,
            vehicleNumber: vehicleNumber,
            saleType: saleType,
            scrapSerial: scrapSerial,
            serviceType: serviceType,
            rentStatus: rentStatus,
            deposit: deposit,
            place: place,
            soldAt: soldAt,
            quantity: quantity,
            customer: _customer?.build(),
            seller: _seller?.build(),
            product: _product?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'customer';
        _customer?.build();
        _$failedField = 'seller';
        _seller?.build();
        _$failedField = 'product';
        _product?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SaleRecord',
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
