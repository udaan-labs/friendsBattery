// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EmployeeActionActionEnum _$employeeActionActionEnum_CHECK_IN =
    const EmployeeActionActionEnum._('CHECK_IN');
const EmployeeActionActionEnum _$employeeActionActionEnum_CHECK_OUT =
    const EmployeeActionActionEnum._('CHECK_OUT');

EmployeeActionActionEnum _$employeeActionActionEnumValueOf(String name) {
  switch (name) {
    case 'CHECK_IN':
      return _$employeeActionActionEnum_CHECK_IN;
    case 'CHECK_OUT':
      return _$employeeActionActionEnum_CHECK_OUT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EmployeeActionActionEnum> _$employeeActionActionEnumValues =
    BuiltSet<EmployeeActionActionEnum>(const <EmployeeActionActionEnum>[
      _$employeeActionActionEnum_CHECK_IN,
      _$employeeActionActionEnum_CHECK_OUT,
    ]);

Serializer<EmployeeActionActionEnum> _$employeeActionActionEnumSerializer =
    _$EmployeeActionActionEnumSerializer();

class _$EmployeeActionActionEnumSerializer
    implements PrimitiveSerializer<EmployeeActionActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CHECK_IN': 'CHECK_IN',
    'CHECK_OUT': 'CHECK_OUT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CHECK_IN': 'CHECK_IN',
    'CHECK_OUT': 'CHECK_OUT',
  };

  @override
  final Iterable<Type> types = const <Type>[EmployeeActionActionEnum];
  @override
  final String wireName = 'EmployeeActionActionEnum';

  @override
  Object serialize(
    Serializers serializers,
    EmployeeActionActionEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  EmployeeActionActionEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => EmployeeActionActionEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$EmployeeAction extends EmployeeAction {
  @override
  final EmployeeActionActionEnum? action;
  @override
  final int? attendanceId;
  @override
  final DateTime? at;
  @override
  final num? lat;
  @override
  final num? lng;
  @override
  final String? address;
  @override
  final EmployeeActionLocation? location;

  factory _$EmployeeAction([void Function(EmployeeActionBuilder)? updates]) =>
      (EmployeeActionBuilder()..update(updates))._build();

  _$EmployeeAction._({
    this.action,
    this.attendanceId,
    this.at,
    this.lat,
    this.lng,
    this.address,
    this.location,
  }) : super._();
  @override
  EmployeeAction rebuild(void Function(EmployeeActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EmployeeActionBuilder toBuilder() => EmployeeActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EmployeeAction &&
        action == other.action &&
        attendanceId == other.attendanceId &&
        at == other.at &&
        lat == other.lat &&
        lng == other.lng &&
        address == other.address &&
        location == other.location;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, attendanceId.hashCode);
    _$hash = $jc(_$hash, at.hashCode);
    _$hash = $jc(_$hash, lat.hashCode);
    _$hash = $jc(_$hash, lng.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EmployeeAction')
          ..add('action', action)
          ..add('attendanceId', attendanceId)
          ..add('at', at)
          ..add('lat', lat)
          ..add('lng', lng)
          ..add('address', address)
          ..add('location', location))
        .toString();
  }
}

class EmployeeActionBuilder
    implements Builder<EmployeeAction, EmployeeActionBuilder> {
  _$EmployeeAction? _$v;

  EmployeeActionActionEnum? _action;
  EmployeeActionActionEnum? get action => _$this._action;
  set action(EmployeeActionActionEnum? action) => _$this._action = action;

  int? _attendanceId;
  int? get attendanceId => _$this._attendanceId;
  set attendanceId(int? attendanceId) => _$this._attendanceId = attendanceId;

  DateTime? _at;
  DateTime? get at => _$this._at;
  set at(DateTime? at) => _$this._at = at;

  num? _lat;
  num? get lat => _$this._lat;
  set lat(num? lat) => _$this._lat = lat;

  num? _lng;
  num? get lng => _$this._lng;
  set lng(num? lng) => _$this._lng = lng;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  EmployeeActionLocationBuilder? _location;
  EmployeeActionLocationBuilder get location =>
      _$this._location ??= EmployeeActionLocationBuilder();
  set location(EmployeeActionLocationBuilder? location) =>
      _$this._location = location;

  EmployeeActionBuilder() {
    EmployeeAction._defaults(this);
  }

  EmployeeActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _attendanceId = $v.attendanceId;
      _at = $v.at;
      _lat = $v.lat;
      _lng = $v.lng;
      _address = $v.address;
      _location = $v.location?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EmployeeAction other) {
    _$v = other as _$EmployeeAction;
  }

  @override
  void update(void Function(EmployeeActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EmployeeAction build() => _build();

  _$EmployeeAction _build() {
    _$EmployeeAction _$result;
    try {
      _$result =
          _$v ??
          _$EmployeeAction._(
            action: action,
            attendanceId: attendanceId,
            at: at,
            lat: lat,
            lng: lng,
            address: address,
            location: _location?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EmployeeAction',
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
