// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_statistics.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SellerStatistics extends SellerStatistics {
  @override
  final int? stock;
  @override
  final int? products;
  @override
  final int? sales;
  @override
  final int? returns;

  factory _$SellerStatistics([
    void Function(SellerStatisticsBuilder)? updates,
  ]) => (SellerStatisticsBuilder()..update(updates))._build();

  _$SellerStatistics._({this.stock, this.products, this.sales, this.returns})
    : super._();
  @override
  SellerStatistics rebuild(void Function(SellerStatisticsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SellerStatisticsBuilder toBuilder() =>
      SellerStatisticsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SellerStatistics &&
        stock == other.stock &&
        products == other.products &&
        sales == other.sales &&
        returns == other.returns;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, stock.hashCode);
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jc(_$hash, sales.hashCode);
    _$hash = $jc(_$hash, returns.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SellerStatistics')
          ..add('stock', stock)
          ..add('products', products)
          ..add('sales', sales)
          ..add('returns', returns))
        .toString();
  }
}

class SellerStatisticsBuilder
    implements Builder<SellerStatistics, SellerStatisticsBuilder> {
  _$SellerStatistics? _$v;

  int? _stock;
  int? get stock => _$this._stock;
  set stock(int? stock) => _$this._stock = stock;

  int? _products;
  int? get products => _$this._products;
  set products(int? products) => _$this._products = products;

  int? _sales;
  int? get sales => _$this._sales;
  set sales(int? sales) => _$this._sales = sales;

  int? _returns;
  int? get returns => _$this._returns;
  set returns(int? returns) => _$this._returns = returns;

  SellerStatisticsBuilder() {
    SellerStatistics._defaults(this);
  }

  SellerStatisticsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _stock = $v.stock;
      _products = $v.products;
      _sales = $v.sales;
      _returns = $v.returns;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SellerStatistics other) {
    _$v = other as _$SellerStatistics;
  }

  @override
  void update(void Function(SellerStatisticsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SellerStatistics build() => _build();

  _$SellerStatistics _build() {
    final _$result =
        _$v ??
        _$SellerStatistics._(
          stock: stock,
          products: products,
          sales: sales,
          returns: returns,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
