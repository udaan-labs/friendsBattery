// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_seller_dashboard_stats_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiSellerDashboardStatsGet200Response
    extends ApiSellerDashboardStatsGet200Response {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final SellerDashboardStats? data;

  factory _$ApiSellerDashboardStatsGet200Response([
    void Function(ApiSellerDashboardStatsGet200ResponseBuilder)? updates,
  ]) => (ApiSellerDashboardStatsGet200ResponseBuilder()..update(updates))
      ._build();

  _$ApiSellerDashboardStatsGet200Response._({
    this.success,
    this.message,
    this.data,
  }) : super._();
  @override
  ApiSellerDashboardStatsGet200Response rebuild(
    void Function(ApiSellerDashboardStatsGet200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiSellerDashboardStatsGet200ResponseBuilder toBuilder() =>
      ApiSellerDashboardStatsGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiSellerDashboardStatsGet200Response &&
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
            r'ApiSellerDashboardStatsGet200Response',
          )
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ApiSellerDashboardStatsGet200ResponseBuilder
    implements
        Builder<
          ApiSellerDashboardStatsGet200Response,
          ApiSellerDashboardStatsGet200ResponseBuilder
        > {
  _$ApiSellerDashboardStatsGet200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SellerDashboardStatsBuilder? _data;
  SellerDashboardStatsBuilder get data =>
      _$this._data ??= SellerDashboardStatsBuilder();
  set data(SellerDashboardStatsBuilder? data) => _$this._data = data;

  ApiSellerDashboardStatsGet200ResponseBuilder() {
    ApiSellerDashboardStatsGet200Response._defaults(this);
  }

  ApiSellerDashboardStatsGet200ResponseBuilder get _$this {
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
  void replace(ApiSellerDashboardStatsGet200Response other) {
    _$v = other as _$ApiSellerDashboardStatsGet200Response;
  }

  @override
  void update(
    void Function(ApiSellerDashboardStatsGet200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiSellerDashboardStatsGet200Response build() => _build();

  _$ApiSellerDashboardStatsGet200Response _build() {
    _$ApiSellerDashboardStatsGet200Response _$result;
    try {
      _$result =
          _$v ??
          _$ApiSellerDashboardStatsGet200Response._(
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
          r'ApiSellerDashboardStatsGet200Response',
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
