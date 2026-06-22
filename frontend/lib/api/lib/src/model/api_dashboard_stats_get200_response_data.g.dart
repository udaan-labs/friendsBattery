// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_dashboard_stats_get200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiDashboardStatsGet200ResponseData
    extends ApiDashboardStatsGet200ResponseData {
  @override
  final int? totalStock;
  @override
  final int? todaySales;
  @override
  final int? pendingRequests;
  @override
  final int? totalSellers;

  factory _$ApiDashboardStatsGet200ResponseData([
    void Function(ApiDashboardStatsGet200ResponseDataBuilder)? updates,
  ]) =>
      (ApiDashboardStatsGet200ResponseDataBuilder()..update(updates))._build();

  _$ApiDashboardStatsGet200ResponseData._({
    this.totalStock,
    this.todaySales,
    this.pendingRequests,
    this.totalSellers,
  }) : super._();
  @override
  ApiDashboardStatsGet200ResponseData rebuild(
    void Function(ApiDashboardStatsGet200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiDashboardStatsGet200ResponseDataBuilder toBuilder() =>
      ApiDashboardStatsGet200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiDashboardStatsGet200ResponseData &&
        totalStock == other.totalStock &&
        todaySales == other.todaySales &&
        pendingRequests == other.pendingRequests &&
        totalSellers == other.totalSellers;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalStock.hashCode);
    _$hash = $jc(_$hash, todaySales.hashCode);
    _$hash = $jc(_$hash, pendingRequests.hashCode);
    _$hash = $jc(_$hash, totalSellers.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiDashboardStatsGet200ResponseData')
          ..add('totalStock', totalStock)
          ..add('todaySales', todaySales)
          ..add('pendingRequests', pendingRequests)
          ..add('totalSellers', totalSellers))
        .toString();
  }
}

class ApiDashboardStatsGet200ResponseDataBuilder
    implements
        Builder<
          ApiDashboardStatsGet200ResponseData,
          ApiDashboardStatsGet200ResponseDataBuilder
        > {
  _$ApiDashboardStatsGet200ResponseData? _$v;

  int? _totalStock;
  int? get totalStock => _$this._totalStock;
  set totalStock(int? totalStock) => _$this._totalStock = totalStock;

  int? _todaySales;
  int? get todaySales => _$this._todaySales;
  set todaySales(int? todaySales) => _$this._todaySales = todaySales;

  int? _pendingRequests;
  int? get pendingRequests => _$this._pendingRequests;
  set pendingRequests(int? pendingRequests) =>
      _$this._pendingRequests = pendingRequests;

  int? _totalSellers;
  int? get totalSellers => _$this._totalSellers;
  set totalSellers(int? totalSellers) => _$this._totalSellers = totalSellers;

  ApiDashboardStatsGet200ResponseDataBuilder() {
    ApiDashboardStatsGet200ResponseData._defaults(this);
  }

  ApiDashboardStatsGet200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalStock = $v.totalStock;
      _todaySales = $v.todaySales;
      _pendingRequests = $v.pendingRequests;
      _totalSellers = $v.totalSellers;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiDashboardStatsGet200ResponseData other) {
    _$v = other as _$ApiDashboardStatsGet200ResponseData;
  }

  @override
  void update(
    void Function(ApiDashboardStatsGet200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiDashboardStatsGet200ResponseData build() => _build();

  _$ApiDashboardStatsGet200ResponseData _build() {
    final _$result =
        _$v ??
        _$ApiDashboardStatsGet200ResponseData._(
          totalStock: totalStock,
          todaySales: todaySales,
          pendingRequests: pendingRequests,
          totalSellers: totalSellers,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
