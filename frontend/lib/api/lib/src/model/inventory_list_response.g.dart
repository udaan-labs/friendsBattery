// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InventoryListResponse extends InventoryListResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final InventoryListPayload? data;

  factory _$InventoryListResponse([
    void Function(InventoryListResponseBuilder)? updates,
  ]) => (InventoryListResponseBuilder()..update(updates))._build();

  _$InventoryListResponse._({this.success, this.message, this.data})
    : super._();
  @override
  InventoryListResponse rebuild(
    void Function(InventoryListResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InventoryListResponseBuilder toBuilder() =>
      InventoryListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InventoryListResponse &&
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
    return (newBuiltValueToStringHelper(r'InventoryListResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class InventoryListResponseBuilder
    implements Builder<InventoryListResponse, InventoryListResponseBuilder> {
  _$InventoryListResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  InventoryListPayloadBuilder? _data;
  InventoryListPayloadBuilder get data =>
      _$this._data ??= InventoryListPayloadBuilder();
  set data(InventoryListPayloadBuilder? data) => _$this._data = data;

  InventoryListResponseBuilder() {
    InventoryListResponse._defaults(this);
  }

  InventoryListResponseBuilder get _$this {
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
  void replace(InventoryListResponse other) {
    _$v = other as _$InventoryListResponse;
  }

  @override
  void update(void Function(InventoryListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InventoryListResponse build() => _build();

  _$InventoryListResponse _build() {
    _$InventoryListResponse _$result;
    try {
      _$result =
          _$v ??
          _$InventoryListResponse._(
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
          r'InventoryListResponse',
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
