// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_seller_dashboard_stats_get200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiSellerDashboardStatsGet200ResponseData
    extends ApiSellerDashboardStatsGet200ResponseData {
  @override
  final int? totalStock;
  @override
  final int? todaySales;

  factory _$ApiSellerDashboardStatsGet200ResponseData([
    void Function(ApiSellerDashboardStatsGet200ResponseDataBuilder)? updates,
  ]) => (ApiSellerDashboardStatsGet200ResponseDataBuilder()..update(updates))
      ._build();

  _$ApiSellerDashboardStatsGet200ResponseData._({
    this.totalStock,
    this.todaySales,
  }) : super._();
  @override
  ApiSellerDashboardStatsGet200ResponseData rebuild(
    void Function(ApiSellerDashboardStatsGet200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiSellerDashboardStatsGet200ResponseDataBuilder toBuilder() =>
      ApiSellerDashboardStatsGet200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiSellerDashboardStatsGet200ResponseData &&
        totalStock == other.totalStock &&
        todaySales == other.todaySales;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalStock.hashCode);
    _$hash = $jc(_$hash, todaySales.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiSellerDashboardStatsGet200ResponseData',
          )
          ..add('totalStock', totalStock)
          ..add('todaySales', todaySales))
        .toString();
  }
}

class ApiSellerDashboardStatsGet200ResponseDataBuilder
    implements
        Builder<
          ApiSellerDashboardStatsGet200ResponseData,
          ApiSellerDashboardStatsGet200ResponseDataBuilder
        > {
  _$ApiSellerDashboardStatsGet200ResponseData? _$v;

  int? _totalStock;
  int? get totalStock => _$this._totalStock;
  set totalStock(int? totalStock) => _$this._totalStock = totalStock;

  int? _todaySales;
  int? get todaySales => _$this._todaySales;
  set todaySales(int? todaySales) => _$this._todaySales = todaySales;

  ApiSellerDashboardStatsGet200ResponseDataBuilder() {
    ApiSellerDashboardStatsGet200ResponseData._defaults(this);
  }

  ApiSellerDashboardStatsGet200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalStock = $v.totalStock;
      _todaySales = $v.todaySales;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiSellerDashboardStatsGet200ResponseData other) {
    _$v = other as _$ApiSellerDashboardStatsGet200ResponseData;
  }

  @override
  void update(
    void Function(ApiSellerDashboardStatsGet200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiSellerDashboardStatsGet200ResponseData build() => _build();

  _$ApiSellerDashboardStatsGet200ResponseData _build() {
    final _$result =
        _$v ??
        _$ApiSellerDashboardStatsGet200ResponseData._(
          totalStock: totalStock,
          todaySales: todaySales,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
