// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_shipments_id_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiShipmentsIdGet200Response extends ApiShipmentsIdGet200Response {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final ApiShipmentsIdGet200ResponseData? data;

  factory _$ApiShipmentsIdGet200Response([
    void Function(ApiShipmentsIdGet200ResponseBuilder)? updates,
  ]) => (ApiShipmentsIdGet200ResponseBuilder()..update(updates))._build();

  _$ApiShipmentsIdGet200Response._({this.success, this.message, this.data})
    : super._();
  @override
  ApiShipmentsIdGet200Response rebuild(
    void Function(ApiShipmentsIdGet200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiShipmentsIdGet200ResponseBuilder toBuilder() =>
      ApiShipmentsIdGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiShipmentsIdGet200Response &&
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
    return (newBuiltValueToStringHelper(r'ApiShipmentsIdGet200Response')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ApiShipmentsIdGet200ResponseBuilder
    implements
        Builder<
          ApiShipmentsIdGet200Response,
          ApiShipmentsIdGet200ResponseBuilder
        > {
  _$ApiShipmentsIdGet200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ApiShipmentsIdGet200ResponseDataBuilder? _data;
  ApiShipmentsIdGet200ResponseDataBuilder get data =>
      _$this._data ??= ApiShipmentsIdGet200ResponseDataBuilder();
  set data(ApiShipmentsIdGet200ResponseDataBuilder? data) =>
      _$this._data = data;

  ApiShipmentsIdGet200ResponseBuilder() {
    ApiShipmentsIdGet200Response._defaults(this);
  }

  ApiShipmentsIdGet200ResponseBuilder get _$this {
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
  void replace(ApiShipmentsIdGet200Response other) {
    _$v = other as _$ApiShipmentsIdGet200Response;
  }

  @override
  void update(void Function(ApiShipmentsIdGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiShipmentsIdGet200Response build() => _build();

  _$ApiShipmentsIdGet200Response _build() {
    _$ApiShipmentsIdGet200Response _$result;
    try {
      _$result =
          _$v ??
          _$ApiShipmentsIdGet200Response._(
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
          r'ApiShipmentsIdGet200Response',
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
