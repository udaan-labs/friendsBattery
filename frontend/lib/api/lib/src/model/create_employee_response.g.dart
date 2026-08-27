// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_employee_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateEmployeeResponse extends CreateEmployeeResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final CreatedEmployee? data;

  factory _$CreateEmployeeResponse([
    void Function(CreateEmployeeResponseBuilder)? updates,
  ]) => (CreateEmployeeResponseBuilder()..update(updates))._build();

  _$CreateEmployeeResponse._({this.success, this.message, this.data})
    : super._();
  @override
  CreateEmployeeResponse rebuild(
    void Function(CreateEmployeeResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateEmployeeResponseBuilder toBuilder() =>
      CreateEmployeeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateEmployeeResponse &&
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
    return (newBuiltValueToStringHelper(r'CreateEmployeeResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreateEmployeeResponseBuilder
    implements Builder<CreateEmployeeResponse, CreateEmployeeResponseBuilder> {
  _$CreateEmployeeResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  CreatedEmployeeBuilder? _data;
  CreatedEmployeeBuilder get data => _$this._data ??= CreatedEmployeeBuilder();
  set data(CreatedEmployeeBuilder? data) => _$this._data = data;

  CreateEmployeeResponseBuilder() {
    CreateEmployeeResponse._defaults(this);
  }

  CreateEmployeeResponseBuilder get _$this {
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
  void replace(CreateEmployeeResponse other) {
    _$v = other as _$CreateEmployeeResponse;
  }

  @override
  void update(void Function(CreateEmployeeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateEmployeeResponse build() => _build();

  _$CreateEmployeeResponse _build() {
    _$CreateEmployeeResponse _$result;
    try {
      _$result =
          _$v ??
          _$CreateEmployeeResponse._(
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
          r'CreateEmployeeResponse',
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
