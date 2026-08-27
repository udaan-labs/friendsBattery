// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_employee_attendance_status_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiEmployeeAttendanceStatusGet200Response
    extends ApiEmployeeAttendanceStatusGet200Response {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final AttendanceStatusData? data;

  factory _$ApiEmployeeAttendanceStatusGet200Response([
    void Function(ApiEmployeeAttendanceStatusGet200ResponseBuilder)? updates,
  ]) => (ApiEmployeeAttendanceStatusGet200ResponseBuilder()..update(updates))
      ._build();

  _$ApiEmployeeAttendanceStatusGet200Response._({
    this.success,
    this.message,
    this.data,
  }) : super._();
  @override
  ApiEmployeeAttendanceStatusGet200Response rebuild(
    void Function(ApiEmployeeAttendanceStatusGet200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiEmployeeAttendanceStatusGet200ResponseBuilder toBuilder() =>
      ApiEmployeeAttendanceStatusGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiEmployeeAttendanceStatusGet200Response &&
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
            r'ApiEmployeeAttendanceStatusGet200Response',
          )
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ApiEmployeeAttendanceStatusGet200ResponseBuilder
    implements
        Builder<
          ApiEmployeeAttendanceStatusGet200Response,
          ApiEmployeeAttendanceStatusGet200ResponseBuilder
        > {
  _$ApiEmployeeAttendanceStatusGet200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AttendanceStatusDataBuilder? _data;
  AttendanceStatusDataBuilder get data =>
      _$this._data ??= AttendanceStatusDataBuilder();
  set data(AttendanceStatusDataBuilder? data) => _$this._data = data;

  ApiEmployeeAttendanceStatusGet200ResponseBuilder() {
    ApiEmployeeAttendanceStatusGet200Response._defaults(this);
  }

  ApiEmployeeAttendanceStatusGet200ResponseBuilder get _$this {
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
  void replace(ApiEmployeeAttendanceStatusGet200Response other) {
    _$v = other as _$ApiEmployeeAttendanceStatusGet200Response;
  }

  @override
  void update(
    void Function(ApiEmployeeAttendanceStatusGet200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiEmployeeAttendanceStatusGet200Response build() => _build();

  _$ApiEmployeeAttendanceStatusGet200Response _build() {
    _$ApiEmployeeAttendanceStatusGet200Response _$result;
    try {
      _$result =
          _$v ??
          _$ApiEmployeeAttendanceStatusGet200Response._(
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
          r'ApiEmployeeAttendanceStatusGet200Response',
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
