// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_geo_body.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AttendanceGeoBody extends AttendanceGeoBody {
  @override
  final num latitude;
  @override
  final num longitude;
  @override
  final num? lat;
  @override
  final num? lng;
  @override
  final num? accuracy;
  @override
  final String? timestamp;
  @override
  final String? address;

  factory _$AttendanceGeoBody([
    void Function(AttendanceGeoBodyBuilder)? updates,
  ]) => (AttendanceGeoBodyBuilder()..update(updates))._build();

  _$AttendanceGeoBody._({
    required this.latitude,
    required this.longitude,
    this.lat,
    this.lng,
    this.accuracy,
    this.timestamp,
    this.address,
  }) : super._();
  @override
  AttendanceGeoBody rebuild(void Function(AttendanceGeoBodyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AttendanceGeoBodyBuilder toBuilder() =>
      AttendanceGeoBodyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AttendanceGeoBody &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        lat == other.lat &&
        lng == other.lng &&
        accuracy == other.accuracy &&
        timestamp == other.timestamp &&
        address == other.address;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, lat.hashCode);
    _$hash = $jc(_$hash, lng.hashCode);
    _$hash = $jc(_$hash, accuracy.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AttendanceGeoBody')
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('lat', lat)
          ..add('lng', lng)
          ..add('accuracy', accuracy)
          ..add('timestamp', timestamp)
          ..add('address', address))
        .toString();
  }
}

class AttendanceGeoBodyBuilder
    implements Builder<AttendanceGeoBody, AttendanceGeoBodyBuilder> {
  _$AttendanceGeoBody? _$v;

  num? _latitude;
  num? get latitude => _$this._latitude;
  set latitude(num? latitude) => _$this._latitude = latitude;

  num? _longitude;
  num? get longitude => _$this._longitude;
  set longitude(num? longitude) => _$this._longitude = longitude;

  num? _lat;
  num? get lat => _$this._lat;
  set lat(num? lat) => _$this._lat = lat;

  num? _lng;
  num? get lng => _$this._lng;
  set lng(num? lng) => _$this._lng = lng;

  num? _accuracy;
  num? get accuracy => _$this._accuracy;
  set accuracy(num? accuracy) => _$this._accuracy = accuracy;

  String? _timestamp;
  String? get timestamp => _$this._timestamp;
  set timestamp(String? timestamp) => _$this._timestamp = timestamp;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  AttendanceGeoBodyBuilder() {
    AttendanceGeoBody._defaults(this);
  }

  AttendanceGeoBodyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _lat = $v.lat;
      _lng = $v.lng;
      _accuracy = $v.accuracy;
      _timestamp = $v.timestamp;
      _address = $v.address;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AttendanceGeoBody other) {
    _$v = other as _$AttendanceGeoBody;
  }

  @override
  void update(void Function(AttendanceGeoBodyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AttendanceGeoBody build() => _build();

  _$AttendanceGeoBody _build() {
    final _$result =
        _$v ??
        _$AttendanceGeoBody._(
          latitude: BuiltValueNullFieldError.checkNotNull(
            latitude,
            r'AttendanceGeoBody',
            'latitude',
          ),
          longitude: BuiltValueNullFieldError.checkNotNull(
            longitude,
            r'AttendanceGeoBody',
            'longitude',
          ),
          lat: lat,
          lng: lng,
          accuracy: accuracy,
          timestamp: timestamp,
          address: address,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
