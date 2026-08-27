// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_name_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductNameResponse extends ProductNameResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ProductName? data;

  factory _$ProductNameResponse([
    void Function(ProductNameResponseBuilder)? updates,
  ]) => (ProductNameResponseBuilder()..update(updates))._build();

  _$ProductNameResponse._({this.success, this.message, this.data}) : super._();
  @override
  ProductNameResponse rebuild(
    void Function(ProductNameResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProductNameResponseBuilder toBuilder() =>
      ProductNameResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductNameResponse &&
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
    return (newBuiltValueToStringHelper(r'ProductNameResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ProductNameResponseBuilder
    implements Builder<ProductNameResponse, ProductNameResponseBuilder> {
  _$ProductNameResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ProductNameBuilder? _data;
  ProductNameBuilder get data => _$this._data ??= ProductNameBuilder();
  set data(ProductNameBuilder? data) => _$this._data = data;

  ProductNameResponseBuilder() {
    ProductNameResponse._defaults(this);
  }

  ProductNameResponseBuilder get _$this {
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
  void replace(ProductNameResponse other) {
    _$v = other as _$ProductNameResponse;
  }

  @override
  void update(void Function(ProductNameResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductNameResponse build() => _build();

  _$ProductNameResponse _build() {
    _$ProductNameResponse _$result;
    try {
      _$result =
          _$v ??
          _$ProductNameResponse._(
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
          r'ProductNameResponse',
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
