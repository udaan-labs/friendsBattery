// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_service_bill_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateServiceBillResponse extends CreateServiceBillResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final CreateServiceBillResult? data;

  factory _$CreateServiceBillResponse([
    void Function(CreateServiceBillResponseBuilder)? updates,
  ]) => (CreateServiceBillResponseBuilder()..update(updates))._build();

  _$CreateServiceBillResponse._({this.success, this.message, this.data})
    : super._();
  @override
  CreateServiceBillResponse rebuild(
    void Function(CreateServiceBillResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateServiceBillResponseBuilder toBuilder() =>
      CreateServiceBillResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateServiceBillResponse &&
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
    return (newBuiltValueToStringHelper(r'CreateServiceBillResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreateServiceBillResponseBuilder
    implements
        Builder<CreateServiceBillResponse, CreateServiceBillResponseBuilder> {
  _$CreateServiceBillResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  CreateServiceBillResultBuilder? _data;
  CreateServiceBillResultBuilder get data =>
      _$this._data ??= CreateServiceBillResultBuilder();
  set data(CreateServiceBillResultBuilder? data) => _$this._data = data;

  CreateServiceBillResponseBuilder() {
    CreateServiceBillResponse._defaults(this);
  }

  CreateServiceBillResponseBuilder get _$this {
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
  void replace(CreateServiceBillResponse other) {
    _$v = other as _$CreateServiceBillResponse;
  }

  @override
  void update(void Function(CreateServiceBillResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateServiceBillResponse build() => _build();

  _$CreateServiceBillResponse _build() {
    _$CreateServiceBillResponse _$result;
    try {
      _$result =
          _$v ??
          _$CreateServiceBillResponse._(
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
          r'CreateServiceBillResponse',
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
