// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_shipment_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateShipmentResponse extends CreateShipmentResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final CreateShipmentResult? data;

  factory _$CreateShipmentResponse([
    void Function(CreateShipmentResponseBuilder)? updates,
  ]) => (CreateShipmentResponseBuilder()..update(updates))._build();

  _$CreateShipmentResponse._({this.success, this.message, this.data})
    : super._();
  @override
  CreateShipmentResponse rebuild(
    void Function(CreateShipmentResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateShipmentResponseBuilder toBuilder() =>
      CreateShipmentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateShipmentResponse &&
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
    return (newBuiltValueToStringHelper(r'CreateShipmentResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreateShipmentResponseBuilder
    implements Builder<CreateShipmentResponse, CreateShipmentResponseBuilder> {
  _$CreateShipmentResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  CreateShipmentResultBuilder? _data;
  CreateShipmentResultBuilder get data =>
      _$this._data ??= CreateShipmentResultBuilder();
  set data(CreateShipmentResultBuilder? data) => _$this._data = data;

  CreateShipmentResponseBuilder() {
    CreateShipmentResponse._defaults(this);
  }

  CreateShipmentResponseBuilder get _$this {
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
  void replace(CreateShipmentResponse other) {
    _$v = other as _$CreateShipmentResponse;
  }

  @override
  void update(void Function(CreateShipmentResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateShipmentResponse build() => _build();

  _$CreateShipmentResponse _build() {
    _$CreateShipmentResponse _$result;
    try {
      _$result =
          _$v ??
          _$CreateShipmentResponse._(
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
          r'CreateShipmentResponse',
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
