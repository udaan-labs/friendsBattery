// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_sale_history_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminSaleHistoryResponse extends AdminSaleHistoryResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final AdminSaleHistoryPage? data;

  factory _$AdminSaleHistoryResponse([
    void Function(AdminSaleHistoryResponseBuilder)? updates,
  ]) => (AdminSaleHistoryResponseBuilder()..update(updates))._build();

  _$AdminSaleHistoryResponse._({this.success, this.message, this.data})
    : super._();
  @override
  AdminSaleHistoryResponse rebuild(
    void Function(AdminSaleHistoryResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminSaleHistoryResponseBuilder toBuilder() =>
      AdminSaleHistoryResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminSaleHistoryResponse &&
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
    return (newBuiltValueToStringHelper(r'AdminSaleHistoryResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class AdminSaleHistoryResponseBuilder
    implements
        Builder<AdminSaleHistoryResponse, AdminSaleHistoryResponseBuilder> {
  _$AdminSaleHistoryResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AdminSaleHistoryPageBuilder? _data;
  AdminSaleHistoryPageBuilder get data =>
      _$this._data ??= AdminSaleHistoryPageBuilder();
  set data(AdminSaleHistoryPageBuilder? data) => _$this._data = data;

  AdminSaleHistoryResponseBuilder() {
    AdminSaleHistoryResponse._defaults(this);
  }

  AdminSaleHistoryResponseBuilder get _$this {
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
  void replace(AdminSaleHistoryResponse other) {
    _$v = other as _$AdminSaleHistoryResponse;
  }

  @override
  void update(void Function(AdminSaleHistoryResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminSaleHistoryResponse build() => _build();

  _$AdminSaleHistoryResponse _build() {
    _$AdminSaleHistoryResponse _$result;
    try {
      _$result =
          _$v ??
          _$AdminSaleHistoryResponse._(
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
          r'AdminSaleHistoryResponse',
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
