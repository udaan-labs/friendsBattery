// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_employee_attendance_check_in_post201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiEmployeeAttendanceCheckInPost201Response
    extends ApiEmployeeAttendanceCheckInPost201Response {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final AttendanceRecord? data;

  factory _$ApiEmployeeAttendanceCheckInPost201Response([
    void Function(ApiEmployeeAttendanceCheckInPost201ResponseBuilder)? updates,
  ]) => (ApiEmployeeAttendanceCheckInPost201ResponseBuilder()..update(updates))
      ._build();

  _$ApiEmployeeAttendanceCheckInPost201Response._({
    this.success,
    this.message,
    this.data,
  }) : super._();
  @override
  ApiEmployeeAttendanceCheckInPost201Response rebuild(
    void Function(ApiEmployeeAttendanceCheckInPost201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiEmployeeAttendanceCheckInPost201ResponseBuilder toBuilder() =>
      ApiEmployeeAttendanceCheckInPost201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiEmployeeAttendanceCheckInPost201Response &&
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
            r'ApiEmployeeAttendanceCheckInPost201Response',
          )
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ApiEmployeeAttendanceCheckInPost201ResponseBuilder
    implements
        Builder<
          ApiEmployeeAttendanceCheckInPost201Response,
          ApiEmployeeAttendanceCheckInPost201ResponseBuilder
        > {
  _$ApiEmployeeAttendanceCheckInPost201Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AttendanceRecordBuilder? _data;
  AttendanceRecordBuilder get data =>
      _$this._data ??= AttendanceRecordBuilder();
  set data(AttendanceRecordBuilder? data) => _$this._data = data;

  ApiEmployeeAttendanceCheckInPost201ResponseBuilder() {
    ApiEmployeeAttendanceCheckInPost201Response._defaults(this);
  }

  ApiEmployeeAttendanceCheckInPost201ResponseBuilder get _$this {
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
  void replace(ApiEmployeeAttendanceCheckInPost201Response other) {
    _$v = other as _$ApiEmployeeAttendanceCheckInPost201Response;
  }

  @override
  void update(
    void Function(ApiEmployeeAttendanceCheckInPost201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiEmployeeAttendanceCheckInPost201Response build() => _build();

  _$ApiEmployeeAttendanceCheckInPost201Response _build() {
    _$ApiEmployeeAttendanceCheckInPost201Response _$result;
    try {
      _$result =
          _$v ??
          _$ApiEmployeeAttendanceCheckInPost201Response._(
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
          r'ApiEmployeeAttendanceCheckInPost201Response',
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
