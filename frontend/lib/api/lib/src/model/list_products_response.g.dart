// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_products_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListProductsResponse extends ListProductsResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final BuiltList<ProductConfigItem>? data;

  factory _$ListProductsResponse([
    void Function(ListProductsResponseBuilder)? updates,
  ]) => (ListProductsResponseBuilder()..update(updates))._build();

  _$ListProductsResponse._({this.success, this.message, this.data}) : super._();
  @override
  ListProductsResponse rebuild(
    void Function(ListProductsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ListProductsResponseBuilder toBuilder() =>
      ListProductsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListProductsResponse &&
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
    return (newBuiltValueToStringHelper(r'ListProductsResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ListProductsResponseBuilder
    implements Builder<ListProductsResponse, ListProductsResponseBuilder> {
  _$ListProductsResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<ProductConfigItem>? _data;
  ListBuilder<ProductConfigItem> get data =>
      _$this._data ??= ListBuilder<ProductConfigItem>();
  set data(ListBuilder<ProductConfigItem>? data) => _$this._data = data;

  ListProductsResponseBuilder() {
    ListProductsResponse._defaults(this);
  }

  ListProductsResponseBuilder get _$this {
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
  void replace(ListProductsResponse other) {
    _$v = other as _$ListProductsResponse;
  }

  @override
  void update(void Function(ListProductsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListProductsResponse build() => _build();

  _$ListProductsResponse _build() {
    _$ListProductsResponse _$result;
    try {
      _$result =
          _$v ??
          _$ListProductsResponse._(
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
          r'ListProductsResponse',
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
