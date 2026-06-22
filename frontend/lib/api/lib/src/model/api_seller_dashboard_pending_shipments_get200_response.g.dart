// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_seller_dashboard_pending_shipments_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiSellerDashboardPendingShipmentsGet200Response
    extends ApiSellerDashboardPendingShipmentsGet200Response {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ApiSellerDashboardPendingShipmentsGet200ResponseData? data;

  factory _$ApiSellerDashboardPendingShipmentsGet200Response([
    void Function(ApiSellerDashboardPendingShipmentsGet200ResponseBuilder)?
    updates,
  ]) =>
      (ApiSellerDashboardPendingShipmentsGet200ResponseBuilder()
            ..update(updates))
          ._build();

  _$ApiSellerDashboardPendingShipmentsGet200Response._({
    this.success,
    this.message,
    this.data,
  }) : super._();
  @override
  ApiSellerDashboardPendingShipmentsGet200Response rebuild(
    void Function(ApiSellerDashboardPendingShipmentsGet200ResponseBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiSellerDashboardPendingShipmentsGet200ResponseBuilder toBuilder() =>
      ApiSellerDashboardPendingShipmentsGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiSellerDashboardPendingShipmentsGet200Response &&
        success == other.success &&
        message == other.message &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiSellerDashboardPendingShipmentsGet200Response',
          )
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ApiSellerDashboardPendingShipmentsGet200ResponseBuilder
    implements
        Builder<
          ApiSellerDashboardPendingShipmentsGet200Response,
          ApiSellerDashboardPendingShipmentsGet200ResponseBuilder
        > {
  _$ApiSellerDashboardPendingShipmentsGet200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder? _data;
  ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder get data =>
      _$this._data ??=
          ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder();
  set data(ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder? data) =>
      _$this._data = data;

  ApiSellerDashboardPendingShipmentsGet200ResponseBuilder() {
    ApiSellerDashboardPendingShipmentsGet200Response._defaults(this);
  }

  ApiSellerDashboardPendingShipmentsGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _message = $v.message;
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiSellerDashboardPendingShipmentsGet200Response other) {
    _$v = other as _$ApiSellerDashboardPendingShipmentsGet200Response;
  }

  @override
  void update(
    void Function(ApiSellerDashboardPendingShipmentsGet200ResponseBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiSellerDashboardPendingShipmentsGet200Response build() => _build();

  _$ApiSellerDashboardPendingShipmentsGet200Response _build() {
    _$ApiSellerDashboardPendingShipmentsGet200Response _$result;
    try {
      _$result =
          _$v ??
          _$ApiSellerDashboardPendingShipmentsGet200Response._(
            success: success,
            message: message,
            data: _data?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ApiSellerDashboardPendingShipmentsGet200Response',
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
