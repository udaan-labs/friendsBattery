// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_dashboard_stats.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SellerDashboardStats extends SellerDashboardStats {
  @override
  final int? totalStock;
  @override
  final int? todaySales;
  @override
  final num? todaySalesAmount;
  @override
  final int? pendingShipments;
  @override
  final BuiltList<SellerRecentSale>? recentSales;

  factory _$SellerDashboardStats([
    void Function(SellerDashboardStatsBuilder)? updates,
  ]) => (SellerDashboardStatsBuilder()..update(updates))._build();

  _$SellerDashboardStats._({
    this.totalStock,
    this.todaySales,
    this.todaySalesAmount,
    this.pendingShipments,
    this.recentSales,
  }) : super._();
  @override
  SellerDashboardStats rebuild(
    void Function(SellerDashboardStatsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SellerDashboardStatsBuilder toBuilder() =>
      SellerDashboardStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SellerDashboardStats &&
        totalStock == other.totalStock &&
        todaySales == other.todaySales &&
        todaySalesAmount == other.todaySalesAmount &&
        pendingShipments == other.pendingShipments &&
        recentSales == other.recentSales;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalStock.hashCode);
    _$hash = $jc(_$hash, todaySales.hashCode);
    _$hash = $jc(_$hash, todaySalesAmount.hashCode);
    _$hash = $jc(_$hash, pendingShipments.hashCode);
    _$hash = $jc(_$hash, recentSales.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SellerDashboardStats')
          ..add('totalStock', totalStock)
          ..add('todaySales', todaySales)
          ..add('todaySalesAmount', todaySalesAmount)
          ..add('pendingShipments', pendingShipments)
          ..add('recentSales', recentSales))
        .toString();
  }
}

class SellerDashboardStatsBuilder
    implements Builder<SellerDashboardStats, SellerDashboardStatsBuilder> {
  _$SellerDashboardStats? _$v;

  int? _totalStock;
  int? get totalStock => _$this._totalStock;
  set totalStock(int? totalStock) => _$this._totalStock = totalStock;

  int? _todaySales;
  int? get todaySales => _$this._todaySales;
  set todaySales(int? todaySales) => _$this._todaySales = todaySales;

  num? _todaySalesAmount;
  num? get todaySalesAmount => _$this._todaySalesAmount;
  set todaySalesAmount(num? todaySalesAmount) =>
      _$this._todaySalesAmount = todaySalesAmount;

  int? _pendingShipments;
  int? get pendingShipments => _$this._pendingShipments;
  set pendingShipments(int? pendingShipments) =>
      _$this._pendingShipments = pendingShipments;

  ListBuilder<SellerRecentSale>? _recentSales;
  ListBuilder<SellerRecentSale> get recentSales =>
      _$this._recentSales ??= ListBuilder<SellerRecentSale>();
  set recentSales(ListBuilder<SellerRecentSale>? recentSales) =>
      _$this._recentSales = recentSales;

  SellerDashboardStatsBuilder() {
    SellerDashboardStats._defaults(this);
  }

  SellerDashboardStatsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalStock = $v.totalStock;
      _todaySales = $v.todaySales;
      _todaySalesAmount = $v.todaySalesAmount;
      _pendingShipments = $v.pendingShipments;
      _recentSales = $v.recentSales?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SellerDashboardStats other) {
    _$v = other as _$SellerDashboardStats;
  }

  @override
  void update(void Function(SellerDashboardStatsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SellerDashboardStats build() => _build();

  _$SellerDashboardStats _build() {
    _$SellerDashboardStats _$result;
    try {
      _$result =
          _$v ??
          _$SellerDashboardStats._(
            totalStock: totalStock,
            todaySales: todaySales,
            todaySalesAmount: todaySalesAmount,
            pendingShipments: pendingShipments,
            recentSales: _recentSales?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recentSales';
        _recentSales?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SellerDashboardStats',
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
