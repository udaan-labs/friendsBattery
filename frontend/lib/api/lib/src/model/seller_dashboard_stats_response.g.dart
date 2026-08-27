// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_dashboard_stats_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SellerDashboardStatsResponse extends SellerDashboardStatsResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final SellerDashboardStats? data;

  factory _$SellerDashboardStatsResponse([
    void Function(SellerDashboardStatsResponseBuilder)? updates,
  ]) => (SellerDashboardStatsResponseBuilder()..update(updates))._build();

  _$SellerDashboardStatsResponse._({this.success, this.message, this.data})
    : super._();
  @override
  SellerDashboardStatsResponse rebuild(
    void Function(SellerDashboardStatsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SellerDashboardStatsResponseBuilder toBuilder() =>
      SellerDashboardStatsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SellerDashboardStatsResponse &&
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
    return (newBuiltValueToStringHelper(r'SellerDashboardStatsResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class SellerDashboardStatsResponseBuilder
    implements
        Builder<
          SellerDashboardStatsResponse,
          SellerDashboardStatsResponseBuilder
        > {
  _$SellerDashboardStatsResponse? _$v;

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

  SellerDashboardStatsResponseBuilder() {
    SellerDashboardStatsResponse._defaults(this);
  }

  SellerDashboardStatsResponseBuilder get _$this {
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
  void replace(SellerDashboardStatsResponse other) {
    _$v = other as _$SellerDashboardStatsResponse;
  }

  @override
  void update(void Function(SellerDashboardStatsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SellerDashboardStatsResponse build() => _build();

  _$SellerDashboardStatsResponse _build() {
    _$SellerDashboardStatsResponse _$result;
    try {
      _$result =
          _$v ??
          _$SellerDashboardStatsResponse._(
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
          r'SellerDashboardStatsResponse',
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
