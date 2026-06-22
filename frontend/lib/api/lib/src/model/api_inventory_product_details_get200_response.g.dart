// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_product_details_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryProductDetailsGet200Response
    extends ApiInventoryProductDetailsGet200Response {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ApiInventoryProductDetailsGet200ResponseData? data;

  factory _$ApiInventoryProductDetailsGet200Response([
    void Function(ApiInventoryProductDetailsGet200ResponseBuilder)? updates,
  ]) => (ApiInventoryProductDetailsGet200ResponseBuilder()..update(updates))
      ._build();

  _$ApiInventoryProductDetailsGet200Response._({
    this.success,
    this.message,
    this.data,
  }) : super._();
  @override
  ApiInventoryProductDetailsGet200Response rebuild(
    void Function(ApiInventoryProductDetailsGet200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryProductDetailsGet200ResponseBuilder toBuilder() =>
      ApiInventoryProductDetailsGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryProductDetailsGet200Response &&
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
    return (newBuiltValueToStringHelper(
            r'ApiInventoryProductDetailsGet200Response',
          )
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ApiInventoryProductDetailsGet200ResponseBuilder
    implements
        Builder<
          ApiInventoryProductDetailsGet200Response,
          ApiInventoryProductDetailsGet200ResponseBuilder
        > {
  _$ApiInventoryProductDetailsGet200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ApiInventoryProductDetailsGet200ResponseDataBuilder? _data;
  ApiInventoryProductDetailsGet200ResponseDataBuilder get data =>
      _$this._data ??= ApiInventoryProductDetailsGet200ResponseDataBuilder();
  set data(ApiInventoryProductDetailsGet200ResponseDataBuilder? data) =>
      _$this._data = data;

  ApiInventoryProductDetailsGet200ResponseBuilder() {
    ApiInventoryProductDetailsGet200Response._defaults(this);
  }

  ApiInventoryProductDetailsGet200ResponseBuilder get _$this {
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
  void replace(ApiInventoryProductDetailsGet200Response other) {
    _$v = other as _$ApiInventoryProductDetailsGet200Response;
  }

  @override
  void update(
    void Function(ApiInventoryProductDetailsGet200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryProductDetailsGet200Response build() => _build();

  _$ApiInventoryProductDetailsGet200Response _build() {
    _$ApiInventoryProductDetailsGet200Response _$result;
    try {
      _$result =
          _$v ??
          _$ApiInventoryProductDetailsGet200Response._(
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
          r'ApiInventoryProductDetailsGet200Response',
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
