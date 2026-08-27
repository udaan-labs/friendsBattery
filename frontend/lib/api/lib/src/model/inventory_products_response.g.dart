// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_products_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InventoryProductsResponse extends InventoryProductsResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final BuiltList<InventoryProductNameGroup>? data;

  factory _$InventoryProductsResponse([
    void Function(InventoryProductsResponseBuilder)? updates,
  ]) => (InventoryProductsResponseBuilder()..update(updates))._build();

  _$InventoryProductsResponse._({this.success, this.message, this.data})
    : super._();
  @override
  InventoryProductsResponse rebuild(
    void Function(InventoryProductsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InventoryProductsResponseBuilder toBuilder() =>
      InventoryProductsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InventoryProductsResponse &&
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
    return (newBuiltValueToStringHelper(r'InventoryProductsResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class InventoryProductsResponseBuilder
    implements
        Builder<InventoryProductsResponse, InventoryProductsResponseBuilder> {
  _$InventoryProductsResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<InventoryProductNameGroup>? _data;
  ListBuilder<InventoryProductNameGroup> get data =>
      _$this._data ??= ListBuilder<InventoryProductNameGroup>();
  set data(ListBuilder<InventoryProductNameGroup>? data) => _$this._data = data;

  InventoryProductsResponseBuilder() {
    InventoryProductsResponse._defaults(this);
  }

  InventoryProductsResponseBuilder get _$this {
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
  void replace(InventoryProductsResponse other) {
    _$v = other as _$InventoryProductsResponse;
  }

  @override
  void update(void Function(InventoryProductsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InventoryProductsResponse build() => _build();

  _$InventoryProductsResponse _build() {
    _$InventoryProductsResponse _$result;
    try {
      _$result =
          _$v ??
          _$InventoryProductsResponse._(
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
          r'InventoryProductsResponse',
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
