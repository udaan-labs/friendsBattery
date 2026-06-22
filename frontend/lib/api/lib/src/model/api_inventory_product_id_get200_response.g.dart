// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_product_id_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryProductIdGet200Response
    extends ApiInventoryProductIdGet200Response {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ApiInventoryProductIdGet200ResponseData? data;

  factory _$ApiInventoryProductIdGet200Response([
    void Function(ApiInventoryProductIdGet200ResponseBuilder)? updates,
  ]) =>
      (ApiInventoryProductIdGet200ResponseBuilder()..update(updates))._build();

  _$ApiInventoryProductIdGet200Response._({
    this.success,
    this.message,
    this.data,
  }) : super._();
  @override
  ApiInventoryProductIdGet200Response rebuild(
    void Function(ApiInventoryProductIdGet200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryProductIdGet200ResponseBuilder toBuilder() =>
      ApiInventoryProductIdGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryProductIdGet200Response &&
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
    return (newBuiltValueToStringHelper(r'ApiInventoryProductIdGet200Response')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ApiInventoryProductIdGet200ResponseBuilder
    implements
        Builder<
          ApiInventoryProductIdGet200Response,
          ApiInventoryProductIdGet200ResponseBuilder
        > {
  _$ApiInventoryProductIdGet200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ApiInventoryProductIdGet200ResponseDataBuilder? _data;
  ApiInventoryProductIdGet200ResponseDataBuilder get data =>
      _$this._data ??= ApiInventoryProductIdGet200ResponseDataBuilder();
  set data(ApiInventoryProductIdGet200ResponseDataBuilder? data) =>
      _$this._data = data;

  ApiInventoryProductIdGet200ResponseBuilder() {
    ApiInventoryProductIdGet200Response._defaults(this);
  }

  ApiInventoryProductIdGet200ResponseBuilder get _$this {
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
  void replace(ApiInventoryProductIdGet200Response other) {
    _$v = other as _$ApiInventoryProductIdGet200Response;
  }

  @override
  void update(
    void Function(ApiInventoryProductIdGet200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryProductIdGet200Response build() => _build();

  _$ApiInventoryProductIdGet200Response _build() {
    _$ApiInventoryProductIdGet200Response _$result;
    try {
      _$result =
          _$v ??
          _$ApiInventoryProductIdGet200Response._(
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
          r'ApiInventoryProductIdGet200Response',
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
