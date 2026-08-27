// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_history_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SaleHistoryResponse extends SaleHistoryResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final SaleHistoryPage? data;

  factory _$SaleHistoryResponse([
    void Function(SaleHistoryResponseBuilder)? updates,
  ]) => (SaleHistoryResponseBuilder()..update(updates))._build();

  _$SaleHistoryResponse._({this.success, this.message, this.data}) : super._();
  @override
  SaleHistoryResponse rebuild(
    void Function(SaleHistoryResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SaleHistoryResponseBuilder toBuilder() =>
      SaleHistoryResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SaleHistoryResponse &&
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
    return (newBuiltValueToStringHelper(r'SaleHistoryResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class SaleHistoryResponseBuilder
    implements Builder<SaleHistoryResponse, SaleHistoryResponseBuilder> {
  _$SaleHistoryResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SaleHistoryPageBuilder? _data;
  SaleHistoryPageBuilder get data => _$this._data ??= SaleHistoryPageBuilder();
  set data(SaleHistoryPageBuilder? data) => _$this._data = data;

  SaleHistoryResponseBuilder() {
    SaleHistoryResponse._defaults(this);
  }

  SaleHistoryResponseBuilder get _$this {
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
  void replace(SaleHistoryResponse other) {
    _$v = other as _$SaleHistoryResponse;
  }

  @override
  void update(void Function(SaleHistoryResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SaleHistoryResponse build() => _build();

  _$SaleHistoryResponse _build() {
    _$SaleHistoryResponse _$result;
    try {
      _$result =
          _$v ??
          _$SaleHistoryResponse._(
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
          r'SaleHistoryResponse',
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
