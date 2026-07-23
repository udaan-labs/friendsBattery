// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adjust_inventory_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdjustInventoryResponse extends AdjustInventoryResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final AdjustInventoryResult? data;

  factory _$AdjustInventoryResponse([
    void Function(AdjustInventoryResponseBuilder)? updates,
  ]) => (AdjustInventoryResponseBuilder()..update(updates))._build();

  _$AdjustInventoryResponse._({this.success, this.message, this.data})
    : super._();
  @override
  AdjustInventoryResponse rebuild(
    void Function(AdjustInventoryResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdjustInventoryResponseBuilder toBuilder() =>
      AdjustInventoryResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdjustInventoryResponse &&
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
    return (newBuiltValueToStringHelper(r'AdjustInventoryResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class AdjustInventoryResponseBuilder
    implements
        Builder<AdjustInventoryResponse, AdjustInventoryResponseBuilder> {
  _$AdjustInventoryResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AdjustInventoryResultBuilder? _data;
  AdjustInventoryResultBuilder get data =>
      _$this._data ??= AdjustInventoryResultBuilder();
  set data(AdjustInventoryResultBuilder? data) => _$this._data = data;

  AdjustInventoryResponseBuilder() {
    AdjustInventoryResponse._defaults(this);
  }

  AdjustInventoryResponseBuilder get _$this {
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
  void replace(AdjustInventoryResponse other) {
    _$v = other as _$AdjustInventoryResponse;
  }

  @override
  void update(void Function(AdjustInventoryResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdjustInventoryResponse build() => _build();

  _$AdjustInventoryResponse _build() {
    _$AdjustInventoryResponse _$result;
    try {
      _$result =
          _$v ??
          _$AdjustInventoryResponse._(
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
          r'AdjustInventoryResponse',
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
