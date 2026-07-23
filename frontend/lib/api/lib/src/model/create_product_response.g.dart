// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_product_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateProductResponse extends CreateProductResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ProductCreated? data;

  factory _$CreateProductResponse([
    void Function(CreateProductResponseBuilder)? updates,
  ]) => (CreateProductResponseBuilder()..update(updates))._build();

  _$CreateProductResponse._({this.success, this.message, this.data})
    : super._();
  @override
  CreateProductResponse rebuild(
    void Function(CreateProductResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateProductResponseBuilder toBuilder() =>
      CreateProductResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateProductResponse &&
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
    return (newBuiltValueToStringHelper(r'CreateProductResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreateProductResponseBuilder
    implements Builder<CreateProductResponse, CreateProductResponseBuilder> {
  _$CreateProductResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ProductCreatedBuilder? _data;
  ProductCreatedBuilder get data => _$this._data ??= ProductCreatedBuilder();
  set data(ProductCreatedBuilder? data) => _$this._data = data;

  CreateProductResponseBuilder() {
    CreateProductResponse._defaults(this);
  }

  CreateProductResponseBuilder get _$this {
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
  void replace(CreateProductResponse other) {
    _$v = other as _$CreateProductResponse;
  }

  @override
  void update(void Function(CreateProductResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateProductResponse build() => _build();

  _$CreateProductResponse _build() {
    _$CreateProductResponse _$result;
    try {
      _$result =
          _$v ??
          _$CreateProductResponse._(
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
          r'CreateProductResponse',
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
