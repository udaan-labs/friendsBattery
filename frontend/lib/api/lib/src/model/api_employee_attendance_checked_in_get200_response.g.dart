// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_employee_attendance_checked_in_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiEmployeeAttendanceCheckedInGet200Response
    extends ApiEmployeeAttendanceCheckedInGet200Response {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final BuiltList<ApiEmployeeAttendanceCheckedInGet200ResponseDataInner>? data;

  factory _$ApiEmployeeAttendanceCheckedInGet200Response([
    void Function(ApiEmployeeAttendanceCheckedInGet200ResponseBuilder)? updates,
  ]) => (ApiEmployeeAttendanceCheckedInGet200ResponseBuilder()..update(updates))
      ._build();

  _$ApiEmployeeAttendanceCheckedInGet200Response._({
    this.success,
    this.message,
    this.data,
  }) : super._();
  @override
  ApiEmployeeAttendanceCheckedInGet200Response rebuild(
    void Function(ApiEmployeeAttendanceCheckedInGet200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiEmployeeAttendanceCheckedInGet200ResponseBuilder toBuilder() =>
      ApiEmployeeAttendanceCheckedInGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiEmployeeAttendanceCheckedInGet200Response &&
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
            r'ApiEmployeeAttendanceCheckedInGet200Response',
          )
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ApiEmployeeAttendanceCheckedInGet200ResponseBuilder
    implements
        Builder<
          ApiEmployeeAttendanceCheckedInGet200Response,
          ApiEmployeeAttendanceCheckedInGet200ResponseBuilder
        > {
  _$ApiEmployeeAttendanceCheckedInGet200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<ApiEmployeeAttendanceCheckedInGet200ResponseDataInner>? _data;
  ListBuilder<ApiEmployeeAttendanceCheckedInGet200ResponseDataInner> get data =>
      _$this._data ??=
          ListBuilder<ApiEmployeeAttendanceCheckedInGet200ResponseDataInner>();
  set data(
    ListBuilder<ApiEmployeeAttendanceCheckedInGet200ResponseDataInner>? data,
  ) => _$this._data = data;

  ApiEmployeeAttendanceCheckedInGet200ResponseBuilder() {
    ApiEmployeeAttendanceCheckedInGet200Response._defaults(this);
  }

  ApiEmployeeAttendanceCheckedInGet200ResponseBuilder get _$this {
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
  void replace(ApiEmployeeAttendanceCheckedInGet200Response other) {
    _$v = other as _$ApiEmployeeAttendanceCheckedInGet200Response;
  }

  @override
  void update(
    void Function(ApiEmployeeAttendanceCheckedInGet200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiEmployeeAttendanceCheckedInGet200Response build() => _build();

  _$ApiEmployeeAttendanceCheckedInGet200Response _build() {
    _$ApiEmployeeAttendanceCheckedInGet200Response _$result;
    try {
      _$result =
          _$v ??
          _$ApiEmployeeAttendanceCheckedInGet200Response._(
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
          r'ApiEmployeeAttendanceCheckedInGet200Response',
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
