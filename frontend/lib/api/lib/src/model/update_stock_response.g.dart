// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_stock_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateStockResponse extends UpdateStockResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final UpdateStockResult? data;

  factory _$UpdateStockResponse([
    void Function(UpdateStockResponseBuilder)? updates,
  ]) => (UpdateStockResponseBuilder()..update(updates))._build();

  _$UpdateStockResponse._({this.success, this.message, this.data}) : super._();
  @override
  UpdateStockResponse rebuild(
    void Function(UpdateStockResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateStockResponseBuilder toBuilder() =>
      UpdateStockResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateStockResponse &&
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
    return (newBuiltValueToStringHelper(r'UpdateStockResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class UpdateStockResponseBuilder
    implements Builder<UpdateStockResponse, UpdateStockResponseBuilder> {
  _$UpdateStockResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  UpdateStockResultBuilder? _data;
  UpdateStockResultBuilder get data =>
      _$this._data ??= UpdateStockResultBuilder();
  set data(UpdateStockResultBuilder? data) => _$this._data = data;

  UpdateStockResponseBuilder() {
    UpdateStockResponse._defaults(this);
  }

  UpdateStockResponseBuilder get _$this {
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
  void replace(UpdateStockResponse other) {
    _$v = other as _$UpdateStockResponse;
  }

  @override
  void update(void Function(UpdateStockResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateStockResponse build() => _build();

  _$UpdateStockResponse _build() {
    _$UpdateStockResponse _$result;
    try {
      _$result =
          _$v ??
          _$UpdateStockResponse._(
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
          r'UpdateStockResponse',
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
