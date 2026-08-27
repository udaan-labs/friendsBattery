// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_names_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductNamesResponse extends ProductNamesResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final BuiltList<ProductName>? data;

  factory _$ProductNamesResponse([
    void Function(ProductNamesResponseBuilder)? updates,
  ]) => (ProductNamesResponseBuilder()..update(updates))._build();

  _$ProductNamesResponse._({this.success, this.message, this.data}) : super._();
  @override
  ProductNamesResponse rebuild(
    void Function(ProductNamesResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProductNamesResponseBuilder toBuilder() =>
      ProductNamesResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductNamesResponse &&
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
    return (newBuiltValueToStringHelper(r'ProductNamesResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ProductNamesResponseBuilder
    implements Builder<ProductNamesResponse, ProductNamesResponseBuilder> {
  _$ProductNamesResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<ProductName>? _data;
  ListBuilder<ProductName> get data =>
      _$this._data ??= ListBuilder<ProductName>();
  set data(ListBuilder<ProductName>? data) => _$this._data = data;

  ProductNamesResponseBuilder() {
    ProductNamesResponse._defaults(this);
  }

  ProductNamesResponseBuilder get _$this {
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
  void replace(ProductNamesResponse other) {
    _$v = other as _$ProductNamesResponse;
  }

  @override
  void update(void Function(ProductNamesResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductNamesResponse build() => _build();

  _$ProductNamesResponse _build() {
    _$ProductNamesResponse _$result;
    try {
      _$result =
          _$v ??
          _$ProductNamesResponse._(
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
          r'ProductNamesResponse',
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
