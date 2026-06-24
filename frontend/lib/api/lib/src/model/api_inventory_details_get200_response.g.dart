// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_details_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryDetailsGet200Response
    extends ApiInventoryDetailsGet200Response {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ApiInventoryDetailsGet200ResponseData? data;

  factory _$ApiInventoryDetailsGet200Response([
    void Function(ApiInventoryDetailsGet200ResponseBuilder)? updates,
  ]) => (ApiInventoryDetailsGet200ResponseBuilder()..update(updates))._build();

  _$ApiInventoryDetailsGet200Response._({this.success, this.message, this.data})
    : super._();
  @override
  ApiInventoryDetailsGet200Response rebuild(
    void Function(ApiInventoryDetailsGet200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryDetailsGet200ResponseBuilder toBuilder() =>
      ApiInventoryDetailsGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryDetailsGet200Response &&
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
    return (newBuiltValueToStringHelper(r'ApiInventoryDetailsGet200Response')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ApiInventoryDetailsGet200ResponseBuilder
    implements
        Builder<
          ApiInventoryDetailsGet200Response,
          ApiInventoryDetailsGet200ResponseBuilder
        > {
  _$ApiInventoryDetailsGet200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ApiInventoryDetailsGet200ResponseDataBuilder? _data;
  ApiInventoryDetailsGet200ResponseDataBuilder get data =>
      _$this._data ??= ApiInventoryDetailsGet200ResponseDataBuilder();
  set data(ApiInventoryDetailsGet200ResponseDataBuilder? data) =>
      _$this._data = data;

  ApiInventoryDetailsGet200ResponseBuilder() {
    ApiInventoryDetailsGet200Response._defaults(this);
  }

  ApiInventoryDetailsGet200ResponseBuilder get _$this {
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
  void replace(ApiInventoryDetailsGet200Response other) {
    _$v = other as _$ApiInventoryDetailsGet200Response;
  }

  @override
  void update(
    void Function(ApiInventoryDetailsGet200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryDetailsGet200Response build() => _build();

  _$ApiInventoryDetailsGet200Response _build() {
    _$ApiInventoryDetailsGet200Response _$result;
    try {
      _$result =
          _$v ??
          _$ApiInventoryDetailsGet200Response._(
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
          r'ApiInventoryDetailsGet200Response',
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
