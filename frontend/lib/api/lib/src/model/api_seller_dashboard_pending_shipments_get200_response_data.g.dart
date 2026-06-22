// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_seller_dashboard_pending_shipments_get200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiSellerDashboardPendingShipmentsGet200ResponseData
    extends ApiSellerDashboardPendingShipmentsGet200ResponseData {
  @override
  final int? pendingShipments;

  factory _$ApiSellerDashboardPendingShipmentsGet200ResponseData([
    void Function(ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder)?
    updates,
  ]) =>
      (ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder()
            ..update(updates))
          ._build();

  _$ApiSellerDashboardPendingShipmentsGet200ResponseData._({
    this.pendingShipments,
  }) : super._();
  @override
  ApiSellerDashboardPendingShipmentsGet200ResponseData rebuild(
    void Function(ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder toBuilder() =>
      ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiSellerDashboardPendingShipmentsGet200ResponseData &&
        pendingShipments == other.pendingShipments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pendingShipments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ApiSellerDashboardPendingShipmentsGet200ResponseData',
    )..add('pendingShipments', pendingShipments)).toString();
  }
}

class ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder
    implements
        Builder<
          ApiSellerDashboardPendingShipmentsGet200ResponseData,
          ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder
        > {
  _$ApiSellerDashboardPendingShipmentsGet200ResponseData? _$v;

  int? _pendingShipments;
  int? get pendingShipments => _$this._pendingShipments;
  set pendingShipments(int? pendingShipments) =>
      _$this._pendingShipments = pendingShipments;

  ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder() {
    ApiSellerDashboardPendingShipmentsGet200ResponseData._defaults(this);
  }

  ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pendingShipments = $v.pendingShipments;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiSellerDashboardPendingShipmentsGet200ResponseData other) {
    _$v = other as _$ApiSellerDashboardPendingShipmentsGet200ResponseData;
  }

  @override
  void update(
    void Function(ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiSellerDashboardPendingShipmentsGet200ResponseData build() => _build();

  _$ApiSellerDashboardPendingShipmentsGet200ResponseData _build() {
    final _$result =
        _$v ??
        _$ApiSellerDashboardPendingShipmentsGet200ResponseData._(
          pendingShipments: pendingShipments,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
