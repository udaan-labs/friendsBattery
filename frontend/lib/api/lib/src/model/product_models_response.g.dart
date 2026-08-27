// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_models_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductModelsResponse extends ProductModelsResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final BuiltList<ProductModel>? data;

  factory _$ProductModelsResponse([
    void Function(ProductModelsResponseBuilder)? updates,
  ]) => (ProductModelsResponseBuilder()..update(updates))._build();

  _$ProductModelsResponse._({this.success, this.message, this.data})
    : super._();
  @override
  ProductModelsResponse rebuild(
    void Function(ProductModelsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProductModelsResponseBuilder toBuilder() =>
      ProductModelsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductModelsResponse &&
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
    return (newBuiltValueToStringHelper(r'ProductModelsResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ProductModelsResponseBuilder
    implements Builder<ProductModelsResponse, ProductModelsResponseBuilder> {
  _$ProductModelsResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<ProductModel>? _data;
  ListBuilder<ProductModel> get data =>
      _$this._data ??= ListBuilder<ProductModel>();
  set data(ListBuilder<ProductModel>? data) => _$this._data = data;

  ProductModelsResponseBuilder() {
    ProductModelsResponse._defaults(this);
  }

  ProductModelsResponseBuilder get _$this {
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
  void replace(ProductModelsResponse other) {
    _$v = other as _$ProductModelsResponse;
  }

  @override
  void update(void Function(ProductModelsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductModelsResponse build() => _build();

  _$ProductModelsResponse _build() {
    _$ProductModelsResponse _$result;
    try {
      _$result =
          _$v ??
          _$ProductModelsResponse._(
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
          r'ProductModelsResponse',
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
