// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_location_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateLocationRequest extends UpdateLocationRequest {
  @override
  final String? name;
  @override
  final String? address;
  @override
  final num? latitude;
  @override
  final num? longitude;
  @override
  final int? allowedRadius;

  factory _$UpdateLocationRequest([
    void Function(UpdateLocationRequestBuilder)? updates,
  ]) => (UpdateLocationRequestBuilder()..update(updates))._build();

  _$UpdateLocationRequest._({
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.allowedRadius,
  }) : super._();
  @override
  UpdateLocationRequest rebuild(
    void Function(UpdateLocationRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateLocationRequestBuilder toBuilder() =>
      UpdateLocationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateLocationRequest &&
        name == other.name &&
        address == other.address &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        allowedRadius == other.allowedRadius;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, allowedRadius.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateLocationRequest')
          ..add('name', name)
          ..add('address', address)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('allowedRadius', allowedRadius))
        .toString();
  }
}

class UpdateLocationRequestBuilder
    implements Builder<UpdateLocationRequest, UpdateLocationRequestBuilder> {
  _$UpdateLocationRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

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

  UpdateLocationRequestBuilder() {
    UpdateLocationRequest._defaults(this);
  }

  UpdateLocationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _address = $v.address;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _allowedRadius = $v.allowedRadius;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateLocationRequest other) {
    _$v = other as _$UpdateLocationRequest;
  }

  @override
  void update(void Function(UpdateLocationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateLocationRequest build() => _build();

  _$UpdateLocationRequest _build() {
    final _$result =
        _$v ??
        _$UpdateLocationRequest._(
          name: name,
          address: address,
          latitude: latitude,
          longitude: longitude,
          allowedRadius: allowedRadius,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
