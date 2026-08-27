// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock_details.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductStockDetails extends ProductStockDetails {
  @override
  final int? currentStock;
  @override
  final num? minSellPrice;

  factory _$ProductStockDetails([
    void Function(ProductStockDetailsBuilder)? updates,
  ]) => (ProductStockDetailsBuilder()..update(updates))._build();

  _$ProductStockDetails._({this.currentStock, this.minSellPrice}) : super._();
  @override
  ProductStockDetails rebuild(
    void Function(ProductStockDetailsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProductStockDetailsBuilder toBuilder() =>
      ProductStockDetailsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductStockDetails &&
        currentStock == other.currentStock &&
        minSellPrice == other.minSellPrice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, currentStock.hashCode);
    _$hash = $jc(_$hash, minSellPrice.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductStockDetails')
          ..add('currentStock', currentStock)
          ..add('minSellPrice', minSellPrice))
        .toString();
  }
}

class ProductStockDetailsBuilder
    implements Builder<ProductStockDetails, ProductStockDetailsBuilder> {
  _$ProductStockDetails? _$v;

  int? _currentStock;
  int? get currentStock => _$this._currentStock;
  set currentStock(int? currentStock) => _$this._currentStock = currentStock;

  num? _minSellPrice;
  num? get minSellPrice => _$this._minSellPrice;
  set minSellPrice(num? minSellPrice) => _$this._minSellPrice = minSellPrice;

  ProductStockDetailsBuilder() {
    ProductStockDetails._defaults(this);
  }

  ProductStockDetailsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currentStock = $v.currentStock;
      _minSellPrice = $v.minSellPrice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductStockDetails other) {
    _$v = other as _$ProductStockDetails;
  }

  @override
  void update(void Function(ProductStockDetailsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductStockDetails build() => _build();

  _$ProductStockDetails _build() {
    final _$result =
        _$v ??
        _$ProductStockDetails._(
          currentStock: currentStock,
          minSellPrice: minSellPrice,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
