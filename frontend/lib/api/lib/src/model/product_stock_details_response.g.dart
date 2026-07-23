// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock_details_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductStockDetailsResponse extends ProductStockDetailsResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ProductStockDetails? data;

  factory _$ProductStockDetailsResponse([
    void Function(ProductStockDetailsResponseBuilder)? updates,
  ]) => (ProductStockDetailsResponseBuilder()..update(updates))._build();

  _$ProductStockDetailsResponse._({this.success, this.message, this.data})
    : super._();
  @override
  ProductStockDetailsResponse rebuild(
    void Function(ProductStockDetailsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProductStockDetailsResponseBuilder toBuilder() =>
      ProductStockDetailsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductStockDetailsResponse &&
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
    return (newBuiltValueToStringHelper(r'ProductStockDetailsResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ProductStockDetailsResponseBuilder
    implements
        Builder<
          ProductStockDetailsResponse,
          ProductStockDetailsResponseBuilder
        > {
  _$ProductStockDetailsResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ProductStockDetailsBuilder? _data;
  ProductStockDetailsBuilder get data =>
      _$this._data ??= ProductStockDetailsBuilder();
  set data(ProductStockDetailsBuilder? data) => _$this._data = data;

  ProductStockDetailsResponseBuilder() {
    ProductStockDetailsResponse._defaults(this);
  }

  ProductStockDetailsResponseBuilder get _$this {
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
  void replace(ProductStockDetailsResponse other) {
    _$v = other as _$ProductStockDetailsResponse;
  }

  @override
  void update(void Function(ProductStockDetailsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductStockDetailsResponse build() => _build();

  _$ProductStockDetailsResponse _build() {
    _$ProductStockDetailsResponse _$result;
    try {
      _$result =
          _$v ??
          _$ProductStockDetailsResponse._(
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
          r'ProductStockDetailsResponse',
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
