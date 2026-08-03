// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_employee_detail_data_current_attendance.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminEmployeeDetailDataCurrentAttendance
    extends AdminEmployeeDetailDataCurrentAttendance {
  @override
  final int? id;
  @override
  final DateTime? checkInTime;
  @override
  final String? status;
  @override
  final EmployeeActionLocation? location;

  factory _$AdminEmployeeDetailDataCurrentAttendance([
    void Function(AdminEmployeeDetailDataCurrentAttendanceBuilder)? updates,
  ]) => (AdminEmployeeDetailDataCurrentAttendanceBuilder()..update(updates))
      ._build();

  _$AdminEmployeeDetailDataCurrentAttendance._({
    this.id,
    this.checkInTime,
    this.status,
    this.location,
  }) : super._();
  @override
  AdminEmployeeDetailDataCurrentAttendance rebuild(
    void Function(AdminEmployeeDetailDataCurrentAttendanceBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminEmployeeDetailDataCurrentAttendanceBuilder toBuilder() =>
      AdminEmployeeDetailDataCurrentAttendanceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminEmployeeDetailDataCurrentAttendance &&
        id == other.id &&
        checkInTime == other.checkInTime &&
        status == other.status &&
        location == other.location;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, checkInTime.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AdminEmployeeDetailDataCurrentAttendance',
          )
          ..add('id', id)
          ..add('checkInTime', checkInTime)
          ..add('status', status)
          ..add('location', location))
        .toString();
  }
}

class AdminEmployeeDetailDataCurrentAttendanceBuilder
    implements
        Builder<
          AdminEmployeeDetailDataCurrentAttendance,
          AdminEmployeeDetailDataCurrentAttendanceBuilder
        > {
  _$AdminEmployeeDetailDataCurrentAttendance? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  DateTime? _checkInTime;
  DateTime? get checkInTime => _$this._checkInTime;
  set checkInTime(DateTime? checkInTime) => _$this._checkInTime = checkInTime;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  EmployeeActionLocationBuilder? _location;
  EmployeeActionLocationBuilder get location =>
      _$this._location ??= EmployeeActionLocationBuilder();
  set location(EmployeeActionLocationBuilder? location) =>
      _$this._location = location;

  AdminEmployeeDetailDataCurrentAttendanceBuilder() {
    AdminEmployeeDetailDataCurrentAttendance._defaults(this);
  }

  AdminEmployeeDetailDataCurrentAttendanceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _checkInTime = $v.checkInTime;
      _status = $v.status;
      _location = $v.location?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminEmployeeDetailDataCurrentAttendance other) {
    _$v = other as _$AdminEmployeeDetailDataCurrentAttendance;
  }

  @override
  void update(
    void Function(AdminEmployeeDetailDataCurrentAttendanceBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminEmployeeDetailDataCurrentAttendance build() => _build();

  _$AdminEmployeeDetailDataCurrentAttendance _build() {
    _$AdminEmployeeDetailDataCurrentAttendance _$result;
    try {
      _$result =
          _$v ??
          _$AdminEmployeeDetailDataCurrentAttendance._(
            id: id,
            checkInTime: checkInTime,
            status: status,
            location: _location?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminEmployeeDetailDataCurrentAttendance',
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
