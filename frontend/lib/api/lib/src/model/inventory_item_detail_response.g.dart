// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InventoryItemDetailResponse extends InventoryItemDetailResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final InventoryItemDetail? data;

  factory _$InventoryItemDetailResponse([
    void Function(InventoryItemDetailResponseBuilder)? updates,
  ]) => (InventoryItemDetailResponseBuilder()..update(updates))._build();

  _$InventoryItemDetailResponse._({this.success, this.message, this.data})
    : super._();
  @override
  InventoryItemDetailResponse rebuild(
    void Function(InventoryItemDetailResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InventoryItemDetailResponseBuilder toBuilder() =>
      InventoryItemDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InventoryItemDetailResponse &&
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
    return (newBuiltValueToStringHelper(r'InventoryItemDetailResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class InventoryItemDetailResponseBuilder
    implements
        Builder<
          InventoryItemDetailResponse,
          InventoryItemDetailResponseBuilder
        > {
  _$InventoryItemDetailResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  InventoryItemDetailBuilder? _data;
  InventoryItemDetailBuilder get data =>
      _$this._data ??= InventoryItemDetailBuilder();
  set data(InventoryItemDetailBuilder? data) => _$this._data = data;

  InventoryItemDetailResponseBuilder() {
    InventoryItemDetailResponse._defaults(this);
  }

  InventoryItemDetailResponseBuilder get _$this {
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
  void replace(InventoryItemDetailResponse other) {
    _$v = other as _$InventoryItemDetailResponse;
  }

  @override
  void update(void Function(InventoryItemDetailResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InventoryItemDetailResponse build() => _build();

  _$InventoryItemDetailResponse _build() {
    _$InventoryItemDetailResponse _$result;
    try {
      _$result =
          _$v ??
          _$InventoryItemDetailResponse._(
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
          r'InventoryItemDetailResponse',
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
