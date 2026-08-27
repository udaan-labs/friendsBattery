// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductModelResponse extends ProductModelResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ProductModel? data;

  factory _$ProductModelResponse([
    void Function(ProductModelResponseBuilder)? updates,
  ]) => (ProductModelResponseBuilder()..update(updates))._build();

  _$ProductModelResponse._({this.success, this.message, this.data}) : super._();
  @override
  ProductModelResponse rebuild(
    void Function(ProductModelResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProductModelResponseBuilder toBuilder() =>
      ProductModelResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductModelResponse &&
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
    return (newBuiltValueToStringHelper(r'ProductModelResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ProductModelResponseBuilder
    implements Builder<ProductModelResponse, ProductModelResponseBuilder> {
  _$ProductModelResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ProductModelBuilder? _data;
  ProductModelBuilder get data => _$this._data ??= ProductModelBuilder();
  set data(ProductModelBuilder? data) => _$this._data = data;

  ProductModelResponseBuilder() {
    ProductModelResponse._defaults(this);
  }

  ProductModelResponseBuilder get _$this {
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
  void replace(ProductModelResponse other) {
    _$v = other as _$ProductModelResponse;
  }

  @override
  void update(void Function(ProductModelResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductModelResponse build() => _build();

  _$ProductModelResponse _build() {
    _$ProductModelResponse _$result;
    try {
      _$result =
          _$v ??
          _$ProductModelResponse._(
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
          r'ProductModelResponse',
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
