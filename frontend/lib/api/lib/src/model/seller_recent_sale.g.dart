// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_recent_sale.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SellerRecentSale extends SellerRecentSale {
  @override
  final int? id;
  @override
  final String? customerName;
  @override
  final String? productName;
  @override
  final String? productModel;
  @override
  final String? serialNumber;
  @override
  final num? sellPrice;
  @override
  final DateTime? soldAt;

  factory _$SellerRecentSale([
    void Function(SellerRecentSaleBuilder)? updates,
  ]) => (SellerRecentSaleBuilder()..update(updates))._build();

  _$SellerRecentSale._({
    this.id,
    this.customerName,
    this.productName,
    this.productModel,
    this.serialNumber,
    this.sellPrice,
    this.soldAt,
  }) : super._();
  @override
  SellerRecentSale rebuild(void Function(SellerRecentSaleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SellerRecentSaleBuilder toBuilder() =>
      SellerRecentSaleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SellerRecentSale &&
        id == other.id &&
        customerName == other.customerName &&
        productName == other.productName &&
        productModel == other.productModel &&
        serialNumber == other.serialNumber &&
        sellPrice == other.sellPrice &&
        soldAt == other.soldAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, customerName.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, productModel.hashCode);
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, sellPrice.hashCode);
    _$hash = $jc(_$hash, soldAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SellerRecentSale')
          ..add('id', id)
          ..add('customerName', customerName)
          ..add('productName', productName)
          ..add('productModel', productModel)
          ..add('serialNumber', serialNumber)
          ..add('sellPrice', sellPrice)
          ..add('soldAt', soldAt))
        .toString();
  }
}

class SellerRecentSaleBuilder
    implements Builder<SellerRecentSale, SellerRecentSaleBuilder> {
  _$SellerRecentSale? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _customerName;
  String? get customerName => _$this._customerName;
  set customerName(String? customerName) => _$this._customerName = customerName;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  String? _productModel;
  String? get productModel => _$this._productModel;
  set productModel(String? productModel) => _$this._productModel = productModel;

  String? _serialNumber;
  String? get serialNumber => _$this._serialNumber;
  set serialNumber(String? serialNumber) => _$this._serialNumber = serialNumber;

  num? _sellPrice;
  num? get sellPrice => _$this._sellPrice;
  set sellPrice(num? sellPrice) => _$this._sellPrice = sellPrice;

  DateTime? _soldAt;
  DateTime? get soldAt => _$this._soldAt;
  set soldAt(DateTime? soldAt) => _$this._soldAt = soldAt;

  SellerRecentSaleBuilder() {
    SellerRecentSale._defaults(this);
  }

  SellerRecentSaleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _customerName = $v.customerName;
      _productName = $v.productName;
      _productModel = $v.productModel;
      _serialNumber = $v.serialNumber;
      _sellPrice = $v.sellPrice;
      _soldAt = $v.soldAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SellerRecentSale other) {
    _$v = other as _$SellerRecentSale;
  }

  @override
  void update(void Function(SellerRecentSaleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SellerRecentSale build() => _build();

  _$SellerRecentSale _build() {
    final _$result =
        _$v ??
        _$SellerRecentSale._(
          id: id,
          customerName: customerName,
          productName: productName,
          productModel: productModel,
          serialNumber: serialNumber,
          sellPrice: sellPrice,
          soldAt: soldAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
