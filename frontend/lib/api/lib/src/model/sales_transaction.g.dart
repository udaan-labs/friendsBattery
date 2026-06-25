// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_transaction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SalesTransaction extends SalesTransaction {
  @override
  final String? id;
  @override
  final String? productId;
  @override
  final String? productUnitId;
  @override
  final String? customerId;
  @override
  final String? sellerId;
  @override
  final double? sellPrice;
  @override
  final String? serialNumber;
  @override
  final String? vehicleNumber;
  @override
  final String? productReplacedId;
  @override
  final DateTime? soldAt;

  factory _$SalesTransaction([
    void Function(SalesTransactionBuilder)? updates,
  ]) => (SalesTransactionBuilder()..update(updates))._build();

  _$SalesTransaction._({
    this.id,
    this.productId,
    this.productUnitId,
    this.customerId,
    this.sellerId,
    this.sellPrice,
    this.serialNumber,
    this.vehicleNumber,
    this.productReplacedId,
    this.soldAt,
  }) : super._();
  @override
  SalesTransaction rebuild(void Function(SalesTransactionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SalesTransactionBuilder toBuilder() =>
      SalesTransactionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SalesTransaction &&
        id == other.id &&
        productId == other.productId &&
        productUnitId == other.productUnitId &&
        customerId == other.customerId &&
        sellerId == other.sellerId &&
        sellPrice == other.sellPrice &&
        serialNumber == other.serialNumber &&
        vehicleNumber == other.vehicleNumber &&
        productReplacedId == other.productReplacedId &&
        soldAt == other.soldAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, productUnitId.hashCode);
    _$hash = $jc(_$hash, customerId.hashCode);
    _$hash = $jc(_$hash, sellerId.hashCode);
    _$hash = $jc(_$hash, sellPrice.hashCode);
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, vehicleNumber.hashCode);
    _$hash = $jc(_$hash, productReplacedId.hashCode);
    _$hash = $jc(_$hash, soldAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SalesTransaction')
          ..add('id', id)
          ..add('productId', productId)
          ..add('productUnitId', productUnitId)
          ..add('customerId', customerId)
          ..add('sellerId', sellerId)
          ..add('sellPrice', sellPrice)
          ..add('serialNumber', serialNumber)
          ..add('vehicleNumber', vehicleNumber)
          ..add('productReplacedId', productReplacedId)
          ..add('soldAt', soldAt))
        .toString();
  }
}

class SalesTransactionBuilder
    implements Builder<SalesTransaction, SalesTransactionBuilder> {
  _$SalesTransaction? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  String? _productUnitId;
  String? get productUnitId => _$this._productUnitId;
  set productUnitId(String? productUnitId) =>
      _$this._productUnitId = productUnitId;

  String? _customerId;
  String? get customerId => _$this._customerId;
  set customerId(String? customerId) => _$this._customerId = customerId;

  String? _sellerId;
  String? get sellerId => _$this._sellerId;
  set sellerId(String? sellerId) => _$this._sellerId = sellerId;

  double? _sellPrice;
  double? get sellPrice => _$this._sellPrice;
  set sellPrice(double? sellPrice) => _$this._sellPrice = sellPrice;

  String? _serialNumber;
  String? get serialNumber => _$this._serialNumber;
  set serialNumber(String? serialNumber) => _$this._serialNumber = serialNumber;

  String? _vehicleNumber;
  String? get vehicleNumber => _$this._vehicleNumber;
  set vehicleNumber(String? vehicleNumber) =>
      _$this._vehicleNumber = vehicleNumber;

  String? _productReplacedId;
  String? get productReplacedId => _$this._productReplacedId;
  set productReplacedId(String? productReplacedId) =>
      _$this._productReplacedId = productReplacedId;

  DateTime? _soldAt;
  DateTime? get soldAt => _$this._soldAt;
  set soldAt(DateTime? soldAt) => _$this._soldAt = soldAt;

  SalesTransactionBuilder() {
    SalesTransaction._defaults(this);
  }

  SalesTransactionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _productId = $v.productId;
      _productUnitId = $v.productUnitId;
      _customerId = $v.customerId;
      _sellerId = $v.sellerId;
      _sellPrice = $v.sellPrice;
      _serialNumber = $v.serialNumber;
      _vehicleNumber = $v.vehicleNumber;
      _productReplacedId = $v.productReplacedId;
      _soldAt = $v.soldAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SalesTransaction other) {
    _$v = other as _$SalesTransaction;
  }

  @override
  void update(void Function(SalesTransactionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SalesTransaction build() => _build();

  _$SalesTransaction _build() {
    final _$result =
        _$v ??
        _$SalesTransaction._(
          id: id,
          productId: productId,
          productUnitId: productUnitId,
          customerId: customerId,
          sellerId: sellerId,
          sellPrice: sellPrice,
          serialNumber: serialNumber,
          vehicleNumber: vehicleNumber,
          productReplacedId: productReplacedId,
          soldAt: soldAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
