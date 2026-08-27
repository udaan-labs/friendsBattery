// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_location.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AssignedLocation extends AssignedLocation {
  @override
  final int? id;
  @override
  final String? code;
  @override
  final String? name;
  @override
  final String? type;
  @override
  final num? latitude;
  @override
  final num? longitude;
  @override
  final int? allowedRadius;

  factory _$AssignedLocation([
    void Function(AssignedLocationBuilder)? updates,
  ]) => (AssignedLocationBuilder()..update(updates))._build();

  _$AssignedLocation._({
    this.id,
    this.code,
    this.name,
    this.type,
    this.latitude,
    this.longitude,
    this.allowedRadius,
  }) : super._();
  @override
  AssignedLocation rebuild(void Function(AssignedLocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssignedLocationBuilder toBuilder() =>
      AssignedLocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssignedLocation &&
        id == other.id &&
        code == other.code &&
        name == other.name &&
        type == other.type &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        allowedRadius == other.allowedRadius;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, allowedRadius.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssignedLocation')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('type', type)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('allowedRadius', allowedRadius))
        .toString();
  }
}

class AssignedLocationBuilder
    implements Builder<AssignedLocation, AssignedLocationBuilder> {
  _$AssignedLocation? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  num? _latitude;
  num? get latitude => _$this._latitude;
  set latitude(num? latitude) => _$this._latitude = latitude;

  num? _longitude;
  num? get longitude => _$this._longitude;
  set longitude(num? longitude) => _$this._longitude = longitude;

  int? _allowedRadius;
  int? get allowedRadius => _$this._allowedRadius;
  set allowedRadius(int? allowedRadius) =>
      _$this._allowedRadius = allowedRadius;

  AssignedLocationBuilder() {
    AssignedLocation._defaults(this);
  }

  AssignedLocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _type = $v.type;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _allowedRadius = $v.allowedRadius;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssignedLocation other) {
    _$v = other as _$AssignedLocation;
  }

  @override
  void update(void Function(AssignedLocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssignedLocation build() => _build();

  _$AssignedLocation _build() {
    final _$result =
        _$v ??
        _$AssignedLocation._(
          id: id,
          code: code,
          name: name,
          type: type,
          latitude: latitude,
          longitude: longitude,
          allowedRadius: allowedRadius,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
