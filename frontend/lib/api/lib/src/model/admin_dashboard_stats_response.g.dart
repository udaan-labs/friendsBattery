// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dashboard_stats_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminDashboardStatsResponse extends AdminDashboardStatsResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final AdminDashboardStats? data;

  factory _$AdminDashboardStatsResponse([
    void Function(AdminDashboardStatsResponseBuilder)? updates,
  ]) => (AdminDashboardStatsResponseBuilder()..update(updates))._build();

  _$AdminDashboardStatsResponse._({this.success, this.message, this.data})
    : super._();
  @override
  AdminDashboardStatsResponse rebuild(
    void Function(AdminDashboardStatsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminDashboardStatsResponseBuilder toBuilder() =>
      AdminDashboardStatsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminDashboardStatsResponse &&
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
    return (newBuiltValueToStringHelper(r'AdminDashboardStatsResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class AdminDashboardStatsResponseBuilder
    implements
        Builder<
          AdminDashboardStatsResponse,
          AdminDashboardStatsResponseBuilder
        > {
  _$AdminDashboardStatsResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AdminDashboardStatsBuilder? _data;
  AdminDashboardStatsBuilder get data =>
      _$this._data ??= AdminDashboardStatsBuilder();
  set data(AdminDashboardStatsBuilder? data) => _$this._data = data;

  AdminDashboardStatsResponseBuilder() {
    AdminDashboardStatsResponse._defaults(this);
  }

  AdminDashboardStatsResponseBuilder get _$this {
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
  void replace(AdminDashboardStatsResponse other) {
    _$v = other as _$AdminDashboardStatsResponse;
  }

  @override
  void update(void Function(AdminDashboardStatsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminDashboardStatsResponse build() => _build();

  _$AdminDashboardStatsResponse _build() {
    _$AdminDashboardStatsResponse _$result;
    try {
      _$result =
          _$v ??
          _$AdminDashboardStatsResponse._(
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
          r'AdminDashboardStatsResponse',
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
