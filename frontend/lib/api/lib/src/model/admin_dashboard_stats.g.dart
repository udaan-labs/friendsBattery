// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dashboard_stats.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminDashboardStats extends AdminDashboardStats {
  @override
  final int? totalStock;
  @override
  final int? todaySales;
  @override
  final num? todaySalesAmount;
  @override
  final int? pendingRequests;
  @override
  final int? totalSellers;
  @override
  final int? pendingShipments;

  factory _$AdminDashboardStats([
    void Function(AdminDashboardStatsBuilder)? updates,
  ]) => (AdminDashboardStatsBuilder()..update(updates))._build();

  _$AdminDashboardStats._({
    this.totalStock,
    this.todaySales,
    this.todaySalesAmount,
    this.pendingRequests,
    this.totalSellers,
    this.pendingShipments,
  }) : super._();
  @override
  AdminDashboardStats rebuild(
    void Function(AdminDashboardStatsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminDashboardStatsBuilder toBuilder() =>
      AdminDashboardStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminDashboardStats &&
        totalStock == other.totalStock &&
        todaySales == other.todaySales &&
        todaySalesAmount == other.todaySalesAmount &&
        pendingRequests == other.pendingRequests &&
        totalSellers == other.totalSellers &&
        pendingShipments == other.pendingShipments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalStock.hashCode);
    _$hash = $jc(_$hash, todaySales.hashCode);
    _$hash = $jc(_$hash, todaySalesAmount.hashCode);
    _$hash = $jc(_$hash, pendingRequests.hashCode);
    _$hash = $jc(_$hash, totalSellers.hashCode);
    _$hash = $jc(_$hash, pendingShipments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminDashboardStats')
          ..add('totalStock', totalStock)
          ..add('todaySales', todaySales)
          ..add('todaySalesAmount', todaySalesAmount)
          ..add('pendingRequests', pendingRequests)
          ..add('totalSellers', totalSellers)
          ..add('pendingShipments', pendingShipments))
        .toString();
  }
}

class AdminDashboardStatsBuilder
    implements Builder<AdminDashboardStats, AdminDashboardStatsBuilder> {
  _$AdminDashboardStats? _$v;

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

  int? _pendingRequests;
  int? get pendingRequests => _$this._pendingRequests;
  set pendingRequests(int? pendingRequests) =>
      _$this._pendingRequests = pendingRequests;

  int? _totalSellers;
  int? get totalSellers => _$this._totalSellers;
  set totalSellers(int? totalSellers) => _$this._totalSellers = totalSellers;

  int? _pendingShipments;
  int? get pendingShipments => _$this._pendingShipments;
  set pendingShipments(int? pendingShipments) =>
      _$this._pendingShipments = pendingShipments;

  AdminDashboardStatsBuilder() {
    AdminDashboardStats._defaults(this);
  }

  AdminDashboardStatsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalStock = $v.totalStock;
      _todaySales = $v.todaySales;
      _todaySalesAmount = $v.todaySalesAmount;
      _pendingRequests = $v.pendingRequests;
      _totalSellers = $v.totalSellers;
      _pendingShipments = $v.pendingShipments;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminDashboardStats other) {
    _$v = other as _$AdminDashboardStats;
  }

  @override
  void update(void Function(AdminDashboardStatsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminDashboardStats build() => _build();

  _$AdminDashboardStats _build() {
    final _$result =
        _$v ??
        _$AdminDashboardStats._(
          totalStock: totalStock,
          todaySales: todaySales,
          todaySalesAmount: todaySalesAmount,
          pendingRequests: pendingRequests,
          totalSellers: totalSellers,
          pendingShipments: pendingShipments,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
