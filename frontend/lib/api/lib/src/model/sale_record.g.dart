// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

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
