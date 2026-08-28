// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AttendanceRecordStatusEnum _$attendanceRecordStatusEnum_CHECKED_IN =
    const AttendanceRecordStatusEnum._('CHECKED_IN');
const AttendanceRecordStatusEnum _$attendanceRecordStatusEnum_CHECKED_OUT =
    const AttendanceRecordStatusEnum._('CHECKED_OUT');

AttendanceRecordStatusEnum _$attendanceRecordStatusEnumValueOf(String name) {
  switch (name) {
    case 'CHECKED_IN':
      return _$attendanceRecordStatusEnum_CHECKED_IN;
    case 'CHECKED_OUT':
      return _$attendanceRecordStatusEnum_CHECKED_OUT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AttendanceRecordStatusEnum> _$attendanceRecordStatusEnumValues =
    BuiltSet<AttendanceRecordStatusEnum>(const <AttendanceRecordStatusEnum>[
      _$attendanceRecordStatusEnum_CHECKED_IN,
      _$attendanceRecordStatusEnum_CHECKED_OUT,
    ]);

Serializer<AttendanceRecordStatusEnum> _$attendanceRecordStatusEnumSerializer =
    _$AttendanceRecordStatusEnumSerializer();

class _$AttendanceRecordStatusEnumSerializer
    implements PrimitiveSerializer<AttendanceRecordStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CHECKED_IN': 'CHECKED_IN',
    'CHECKED_OUT': 'CHECKED_OUT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CHECKED_IN': 'CHECKED_IN',
    'CHECKED_OUT': 'CHECKED_OUT',
  };

  @override
  final Iterable<Type> types = const <Type>[AttendanceRecordStatusEnum];
  @override
  final String wireName = 'AttendanceRecordStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    AttendanceRecordStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AttendanceRecordStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AttendanceRecordStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AttendanceRecord extends AttendanceRecord {
  @override
  final int? id;
  @override
  final int? employeeId;
  @override
  final int? assignedLocationId;
  @override
  final DateTime? checkInTime;
  @override
  final DateTime? checkOutTime;
  @override
  final num? checkInLat;
  @override
  final num? checkInLng;
  @override
  final num? lastLat;
  @override
  final num? lastLng;
  @override
  final DateTime? lastSeenAt;
  @override
  final AttendanceRecordStatusEnum? status;
  @override
  final AssignedLocation? location;

  factory _$AttendanceRecord([
    void Function(AttendanceRecordBuilder)? updates,
  ]) => (AttendanceRecordBuilder()..update(updates))._build();

  _$AttendanceRecord._({
    this.id,
    this.employeeId,
    this.assignedLocationId,
    this.checkInTime,
    this.checkOutTime,
    this.checkInLat,
    this.checkInLng,
    this.lastLat,
    this.lastLng,
    this.lastSeenAt,
    this.status,
    this.location,
  }) : super._();
  @override
  AttendanceRecord rebuild(void Function(AttendanceRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AttendanceRecordBuilder toBuilder() =>
      AttendanceRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AttendanceRecord &&
        id == other.id &&
        employeeId == other.employeeId &&
        assignedLocationId == other.assignedLocationId &&
        checkInTime == other.checkInTime &&
        checkOutTime == other.checkOutTime &&
        checkInLat == other.checkInLat &&
        checkInLng == other.checkInLng &&
        lastLat == other.lastLat &&
        lastLng == other.lastLng &&
        lastSeenAt == other.lastSeenAt &&
        status == other.status &&
        location == other.location;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, employeeId.hashCode);
    _$hash = $jc(_$hash, assignedLocationId.hashCode);
    _$hash = $jc(_$hash, checkInTime.hashCode);
    _$hash = $jc(_$hash, checkOutTime.hashCode);
    _$hash = $jc(_$hash, checkInLat.hashCode);
    _$hash = $jc(_$hash, checkInLng.hashCode);
    _$hash = $jc(_$hash, lastLat.hashCode);
    _$hash = $jc(_$hash, lastLng.hashCode);
    _$hash = $jc(_$hash, lastSeenAt.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AttendanceRecord')
          ..add('id', id)
          ..add('employeeId', employeeId)
          ..add('assignedLocationId', assignedLocationId)
          ..add('checkInTime', checkInTime)
          ..add('checkOutTime', checkOutTime)
          ..add('checkInLat', checkInLat)
          ..add('checkInLng', checkInLng)
          ..add('lastLat', lastLat)
          ..add('lastLng', lastLng)
          ..add('lastSeenAt', lastSeenAt)
          ..add('status', status)
          ..add('location', location))
        .toString();
  }
}

class AttendanceRecordBuilder
    implements Builder<AttendanceRecord, AttendanceRecordBuilder> {
  _$AttendanceRecord? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _employeeId;
  int? get employeeId => _$this._employeeId;
  set employeeId(int? employeeId) => _$this._employeeId = employeeId;

  int? _assignedLocationId;
  int? get assignedLocationId => _$this._assignedLocationId;
  set assignedLocationId(int? assignedLocationId) =>
      _$this._assignedLocationId = assignedLocationId;

  DateTime? _checkInTime;
  DateTime? get checkInTime => _$this._checkInTime;
  set checkInTime(DateTime? checkInTime) => _$this._checkInTime = checkInTime;

  DateTime? _checkOutTime;
  DateTime? get checkOutTime => _$this._checkOutTime;
  set checkOutTime(DateTime? checkOutTime) =>
      _$this._checkOutTime = checkOutTime;

  num? _checkInLat;
  num? get checkInLat => _$this._checkInLat;
  set checkInLat(num? checkInLat) => _$this._checkInLat = checkInLat;

  num? _checkInLng;
  num? get checkInLng => _$this._checkInLng;
  set checkInLng(num? checkInLng) => _$this._checkInLng = checkInLng;

  num? _lastLat;
  num? get lastLat => _$this._lastLat;
  set lastLat(num? lastLat) => _$this._lastLat = lastLat;

  num? _lastLng;
  num? get lastLng => _$this._lastLng;
  set lastLng(num? lastLng) => _$this._lastLng = lastLng;

  DateTime? _lastSeenAt;
  DateTime? get lastSeenAt => _$this._lastSeenAt;
  set lastSeenAt(DateTime? lastSeenAt) => _$this._lastSeenAt = lastSeenAt;

  AttendanceRecordStatusEnum? _status;
  AttendanceRecordStatusEnum? get status => _$this._status;
  set status(AttendanceRecordStatusEnum? status) => _$this._status = status;

  AssignedLocationBuilder? _location;
  AssignedLocationBuilder get location =>
      _$this._location ??= AssignedLocationBuilder();
  set location(AssignedLocationBuilder? location) =>
      _$this._location = location;

  AttendanceRecordBuilder() {
    AttendanceRecord._defaults(this);
  }

  AttendanceRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _employeeId = $v.employeeId;
      _assignedLocationId = $v.assignedLocationId;
      _checkInTime = $v.checkInTime;
      _checkOutTime = $v.checkOutTime;
      _checkInLat = $v.checkInLat;
      _checkInLng = $v.checkInLng;
      _lastLat = $v.lastLat;
      _lastLng = $v.lastLng;
      _lastSeenAt = $v.lastSeenAt;
      _status = $v.status;
      _location = $v.location?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AttendanceRecord other) {
    _$v = other as _$AttendanceRecord;
  }

  @override
  void update(void Function(AttendanceRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AttendanceRecord build() => _build();

  _$AttendanceRecord _build() {
    _$AttendanceRecord _$result;
    try {
      _$result =
          _$v ??
          _$AttendanceRecord._(
            id: id,
            employeeId: employeeId,
            assignedLocationId: assignedLocationId,
            checkInTime: checkInTime,
            checkOutTime: checkOutTime,
            checkInLat: checkInLat,
            checkInLng: checkInLng,
            lastLat: lastLat,
            lastLng: lastLng,
            lastSeenAt: lastSeenAt,
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
          r'AttendanceRecord',
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
