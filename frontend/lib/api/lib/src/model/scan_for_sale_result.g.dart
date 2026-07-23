// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_for_sale_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScanForSaleResult extends ScanForSaleResult {
  @override
  final int? productId;
  @override
  final int? productNameId;
  @override
  final int? productModelId;
  @override
  final String? productName;
  @override
  final String? productModel;
  @override
  final num? minSellPrice;

  factory _$ScanForSaleResult([
    void Function(ScanForSaleResultBuilder)? updates,
  ]) => (ScanForSaleResultBuilder()..update(updates))._build();

  _$ScanForSaleResult._({
    this.productId,
    this.productNameId,
    this.productModelId,
    this.productName,
    this.productModel,
    this.minSellPrice,
  }) : super._();
  @override
  ScanForSaleResult rebuild(void Function(ScanForSaleResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScanForSaleResultBuilder toBuilder() =>
      ScanForSaleResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScanForSaleResult &&
        productId == other.productId &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId &&
        productName == other.productName &&
        productModel == other.productModel &&
        minSellPrice == other.minSellPrice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, productModel.hashCode);
    _$hash = $jc(_$hash, minSellPrice.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScanForSaleResult')
          ..add('productId', productId)
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId)
          ..add('productName', productName)
          ..add('productModel', productModel)
          ..add('minSellPrice', minSellPrice))
        .toString();
  }
}

class ScanForSaleResultBuilder
    implements Builder<ScanForSaleResult, ScanForSaleResultBuilder> {
  _$ScanForSaleResult? _$v;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  int? _productModelId;
  int? get productModelId => _$this._productModelId;
  set productModelId(int? productModelId) =>
      _$this._productModelId = productModelId;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  String? _productModel;
  String? get productModel => _$this._productModel;
  set productModel(String? productModel) => _$this._productModel = productModel;

  num? _minSellPrice;
  num? get minSellPrice => _$this._minSellPrice;
  set minSellPrice(num? minSellPrice) => _$this._minSellPrice = minSellPrice;

  ScanForSaleResultBuilder() {
    ScanForSaleResult._defaults(this);
  }

  ScanForSaleResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
      _productName = $v.productName;
      _productModel = $v.productModel;
      _minSellPrice = $v.minSellPrice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScanForSaleResult other) {
    _$v = other as _$ScanForSaleResult;
  }

  @override
  void update(void Function(ScanForSaleResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScanForSaleResult build() => _build();

  _$ScanForSaleResult _build() {
    final _$result =
        _$v ??
        _$ScanForSaleResult._(
          productId: productId,
          productNameId: productNameId,
          productModelId: productModelId,
          productName: productName,
          productModel: productModel,
          minSellPrice: minSellPrice,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
