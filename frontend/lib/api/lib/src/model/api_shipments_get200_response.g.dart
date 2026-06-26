// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_shipments_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiShipmentsGet200Response extends ApiShipmentsGet200Response {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final BuiltList<ApiShipmentsGet200ResponseDataInner>? data;

  factory _$ApiShipmentsGet200Response([
    void Function(ApiShipmentsGet200ResponseBuilder)? updates,
  ]) => (ApiShipmentsGet200ResponseBuilder()..update(updates))._build();

  _$ApiShipmentsGet200Response._({this.success, this.message, this.data})
    : super._();
  @override
  ApiShipmentsGet200Response rebuild(
    void Function(ApiShipmentsGet200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiShipmentsGet200ResponseBuilder toBuilder() =>
      ApiShipmentsGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiShipmentsGet200Response &&
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
    return (newBuiltValueToStringHelper(r'ApiShipmentsGet200Response')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ApiShipmentsGet200ResponseBuilder
    implements
        Builder<ApiShipmentsGet200Response, ApiShipmentsGet200ResponseBuilder> {
  _$ApiShipmentsGet200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<ApiShipmentsGet200ResponseDataInner>? _data;
  ListBuilder<ApiShipmentsGet200ResponseDataInner> get data =>
      _$this._data ??= ListBuilder<ApiShipmentsGet200ResponseDataInner>();
  set data(ListBuilder<ApiShipmentsGet200ResponseDataInner>? data) =>
      _$this._data = data;

  ApiShipmentsGet200ResponseBuilder() {
    ApiShipmentsGet200Response._defaults(this);
  }

  ApiShipmentsGet200ResponseBuilder get _$this {
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
  void replace(ApiShipmentsGet200Response other) {
    _$v = other as _$ApiShipmentsGet200Response;
  }

  @override
  void update(void Function(ApiShipmentsGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiShipmentsGet200Response build() => _build();

  _$ApiShipmentsGet200Response _build() {
    _$ApiShipmentsGet200Response _$result;
    try {
      _$result =
          _$v ??
          _$ApiShipmentsGet200Response._(
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
          r'ApiShipmentsGet200Response',
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
