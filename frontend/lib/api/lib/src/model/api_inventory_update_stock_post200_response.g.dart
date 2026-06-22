// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_update_stock_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryUpdateStockPost200Response
    extends ApiInventoryUpdateStockPost200Response {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ApiInventoryUpdateStockPost200ResponseData? data;

  factory _$ApiInventoryUpdateStockPost200Response([
    void Function(ApiInventoryUpdateStockPost200ResponseBuilder)? updates,
  ]) => (ApiInventoryUpdateStockPost200ResponseBuilder()..update(updates))
      ._build();

  _$ApiInventoryUpdateStockPost200Response._({
    this.success,
    this.message,
    this.data,
  }) : super._();
  @override
  ApiInventoryUpdateStockPost200Response rebuild(
    void Function(ApiInventoryUpdateStockPost200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryUpdateStockPost200ResponseBuilder toBuilder() =>
      ApiInventoryUpdateStockPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryUpdateStockPost200Response &&
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
            r'ApiInventoryUpdateStockPost200Response',
          )
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ApiInventoryUpdateStockPost200ResponseBuilder
    implements
        Builder<
          ApiInventoryUpdateStockPost200Response,
          ApiInventoryUpdateStockPost200ResponseBuilder
        > {
  _$ApiInventoryUpdateStockPost200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ApiInventoryUpdateStockPost200ResponseDataBuilder? _data;
  ApiInventoryUpdateStockPost200ResponseDataBuilder get data =>
      _$this._data ??= ApiInventoryUpdateStockPost200ResponseDataBuilder();
  set data(ApiInventoryUpdateStockPost200ResponseDataBuilder? data) =>
      _$this._data = data;

  ApiInventoryUpdateStockPost200ResponseBuilder() {
    ApiInventoryUpdateStockPost200Response._defaults(this);
  }

  ApiInventoryUpdateStockPost200ResponseBuilder get _$this {
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
  void replace(ApiInventoryUpdateStockPost200Response other) {
    _$v = other as _$ApiInventoryUpdateStockPost200Response;
  }

  @override
  void update(
    void Function(ApiInventoryUpdateStockPost200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryUpdateStockPost200Response build() => _build();

  _$ApiInventoryUpdateStockPost200Response _build() {
    _$ApiInventoryUpdateStockPost200Response _$result;
    try {
      _$result =
          _$v ??
          _$ApiInventoryUpdateStockPost200Response._(
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
          r'ApiInventoryUpdateStockPost200Response',
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
