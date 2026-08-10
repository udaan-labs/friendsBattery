// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_employee_attendance_checked_in_get200_response_data_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiEmployeeAttendanceCheckedInGet200ResponseDataInner
    extends ApiEmployeeAttendanceCheckedInGet200ResponseDataInner {
  @override
  final int? id;
  @override
  final int? employeeId;
  @override
  final DateTime? checkInTime;
  @override
  final num? checkInLat;
  @override
  final num? checkInLng;
  @override
  final String? status;
  @override
  final JsonObject? location;
  @override
  final JsonObject? employee;

  factory _$ApiEmployeeAttendanceCheckedInGet200ResponseDataInner([
    void Function(ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder)?
    updates,
  ]) =>
      (ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder()
            ..update(updates))
          ._build();

  _$ApiEmployeeAttendanceCheckedInGet200ResponseDataInner._({
    this.id,
    this.employeeId,
    this.checkInTime,
    this.checkInLat,
    this.checkInLng,
    this.status,
    this.location,
    this.employee,
  }) : super._();
  @override
  ApiEmployeeAttendanceCheckedInGet200ResponseDataInner rebuild(
    void Function(ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder toBuilder() =>
      ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiEmployeeAttendanceCheckedInGet200ResponseDataInner &&
        id == other.id &&
        employeeId == other.employeeId &&
        checkInTime == other.checkInTime &&
        checkInLat == other.checkInLat &&
        checkInLng == other.checkInLng &&
        status == other.status &&
        location == other.location &&
        employee == other.employee;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, employeeId.hashCode);
    _$hash = $jc(_$hash, checkInTime.hashCode);
    _$hash = $jc(_$hash, checkInLat.hashCode);
    _$hash = $jc(_$hash, checkInLng.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, employee.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiEmployeeAttendanceCheckedInGet200ResponseDataInner',
          )
          ..add('id', id)
          ..add('employeeId', employeeId)
          ..add('checkInTime', checkInTime)
          ..add('checkInLat', checkInLat)
          ..add('checkInLng', checkInLng)
          ..add('status', status)
          ..add('location', location)
          ..add('employee', employee))
        .toString();
  }
}

class ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder
    implements
        Builder<
          ApiEmployeeAttendanceCheckedInGet200ResponseDataInner,
          ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder
        > {
  _$ApiEmployeeAttendanceCheckedInGet200ResponseDataInner? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _employeeId;
  int? get employeeId => _$this._employeeId;
  set employeeId(int? employeeId) => _$this._employeeId = employeeId;

  DateTime? _checkInTime;
  DateTime? get checkInTime => _$this._checkInTime;
  set checkInTime(DateTime? checkInTime) => _$this._checkInTime = checkInTime;

  num? _checkInLat;
  num? get checkInLat => _$this._checkInLat;
  set checkInLat(num? checkInLat) => _$this._checkInLat = checkInLat;

  num? _checkInLng;
  num? get checkInLng => _$this._checkInLng;
  set checkInLng(num? checkInLng) => _$this._checkInLng = checkInLng;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  JsonObject? _location;
  JsonObject? get location => _$this._location;
  set location(JsonObject? location) => _$this._location = location;

  JsonObject? _employee;
  JsonObject? get employee => _$this._employee;
  set employee(JsonObject? employee) => _$this._employee = employee;

  ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder() {
    ApiEmployeeAttendanceCheckedInGet200ResponseDataInner._defaults(this);
  }

  ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _employeeId = $v.employeeId;
      _checkInTime = $v.checkInTime;
      _checkInLat = $v.checkInLat;
      _checkInLng = $v.checkInLng;
      _status = $v.status;
      _location = $v.location;
      _employee = $v.employee;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiEmployeeAttendanceCheckedInGet200ResponseDataInner other) {
    _$v = other as _$ApiEmployeeAttendanceCheckedInGet200ResponseDataInner;
  }

  @override
  void update(
    void Function(ApiEmployeeAttendanceCheckedInGet200ResponseDataInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiEmployeeAttendanceCheckedInGet200ResponseDataInner build() => _build();

  _$ApiEmployeeAttendanceCheckedInGet200ResponseDataInner _build() {
    final _$result =
        _$v ??
        _$ApiEmployeeAttendanceCheckedInGet200ResponseDataInner._(
          id: id,
          employeeId: employeeId,
          checkInTime: checkInTime,
          checkInLat: checkInLat,
          checkInLng: checkInLng,
          status: status,
          location: location,
          employee: employee,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
