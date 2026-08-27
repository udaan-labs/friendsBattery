// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_status_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AttendanceStatusData extends AttendanceStatusData {
  @override
  final bool? isCheckedIn;
  @override
  final AttendanceRecord? attendance;
  @override
  final AssignedLocation? location;

  factory _$AttendanceStatusData([
    void Function(AttendanceStatusDataBuilder)? updates,
  ]) => (AttendanceStatusDataBuilder()..update(updates))._build();

  _$AttendanceStatusData._({this.isCheckedIn, this.attendance, this.location})
    : super._();
  @override
  AttendanceStatusData rebuild(
    void Function(AttendanceStatusDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AttendanceStatusDataBuilder toBuilder() =>
      AttendanceStatusDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AttendanceStatusData &&
        isCheckedIn == other.isCheckedIn &&
        attendance == other.attendance &&
        location == other.location;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isCheckedIn.hashCode);
    _$hash = $jc(_$hash, attendance.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AttendanceStatusData')
          ..add('isCheckedIn', isCheckedIn)
          ..add('attendance', attendance)
          ..add('location', location))
        .toString();
  }
}

class AttendanceStatusDataBuilder
    implements Builder<AttendanceStatusData, AttendanceStatusDataBuilder> {
  _$AttendanceStatusData? _$v;

  bool? _isCheckedIn;
  bool? get isCheckedIn => _$this._isCheckedIn;
  set isCheckedIn(bool? isCheckedIn) => _$this._isCheckedIn = isCheckedIn;

  AttendanceRecordBuilder? _attendance;
  AttendanceRecordBuilder get attendance =>
      _$this._attendance ??= AttendanceRecordBuilder();
  set attendance(AttendanceRecordBuilder? attendance) =>
      _$this._attendance = attendance;

  AssignedLocationBuilder? _location;
  AssignedLocationBuilder get location =>
      _$this._location ??= AssignedLocationBuilder();
  set location(AssignedLocationBuilder? location) =>
      _$this._location = location;

  AttendanceStatusDataBuilder() {
    AttendanceStatusData._defaults(this);
  }

  AttendanceStatusDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isCheckedIn = $v.isCheckedIn;
      _attendance = $v.attendance?.toBuilder();
      _location = $v.location?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AttendanceStatusData other) {
    _$v = other as _$AttendanceStatusData;
  }

  @override
  void update(void Function(AttendanceStatusDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AttendanceStatusData build() => _build();

  _$AttendanceStatusData _build() {
    _$AttendanceStatusData _$result;
    try {
      _$result =
          _$v ??
          _$AttendanceStatusData._(
            isCheckedIn: isCheckedIn,
            attendance: _attendance?.build(),
            location: _location?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attendance';
        _attendance?.build();
        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AttendanceStatusData',
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
