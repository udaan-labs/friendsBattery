// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_sale_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

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
