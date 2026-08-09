// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LocationItemTypeEnum _$locationItemTypeEnum_WAREHOUSE =
    const LocationItemTypeEnum._('WAREHOUSE');
const LocationItemTypeEnum _$locationItemTypeEnum_SHOP =
    const LocationItemTypeEnum._('SHOP');

LocationItemTypeEnum _$locationItemTypeEnumValueOf(String name) {
  switch (name) {
    case 'WAREHOUSE':
      return _$locationItemTypeEnum_WAREHOUSE;
    case 'SHOP':
      return _$locationItemTypeEnum_SHOP;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<LocationItemTypeEnum> _$locationItemTypeEnumValues =
    BuiltSet<LocationItemTypeEnum>(const <LocationItemTypeEnum>[
      _$locationItemTypeEnum_WAREHOUSE,
      _$locationItemTypeEnum_SHOP,
    ]);

Serializer<LocationItemTypeEnum> _$locationItemTypeEnumSerializer =
    _$LocationItemTypeEnumSerializer();

class _$LocationItemTypeEnumSerializer
    implements PrimitiveSerializer<LocationItemTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'WAREHOUSE': 'WAREHOUSE',
    'SHOP': 'SHOP',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'WAREHOUSE': 'WAREHOUSE',
    'SHOP': 'SHOP',
  };

  @override
  final Iterable<Type> types = const <Type>[LocationItemTypeEnum];
  @override
  final String wireName = 'LocationItemTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    LocationItemTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LocationItemTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LocationItemTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$LocationItem extends LocationItem {
  @override
  final int? id;
  @override
  final String? code;
  @override
  final String? name;
  @override
  final LocationItemTypeEnum? type;
  @override
  final bool? isActive;
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final num? latitude;
  @override
  final num? longitude;
  @override
  final int? allowedRadius;

  factory _$LocationItem([void Function(LocationItemBuilder)? updates]) =>
      (LocationItemBuilder()..update(updates))._build();

  _$LocationItem._({
    this.id,
    this.code,
    this.name,
    this.type,
    this.isActive,
    this.address,
    this.phone,
    this.latitude,
    this.longitude,
    this.allowedRadius,
  }) : super._();
  @override
  LocationItem rebuild(void Function(LocationItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LocationItemBuilder toBuilder() => LocationItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LocationItem &&
        id == other.id &&
        code == other.code &&
        name == other.name &&
        type == other.type &&
        isActive == other.isActive &&
        address == other.address &&
        phone == other.phone &&
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
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, allowedRadius.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LocationItem')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('type', type)
          ..add('isActive', isActive)
          ..add('address', address)
          ..add('phone', phone)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('allowedRadius', allowedRadius))
        .toString();
  }
}

class LocationItemBuilder
    implements Builder<LocationItem, LocationItemBuilder> {
  _$LocationItem? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  LocationItemTypeEnum? _type;
  LocationItemTypeEnum? get type => _$this._type;
  set type(LocationItemTypeEnum? type) => _$this._type = type;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

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

  LocationItemBuilder() {
    LocationItem._defaults(this);
  }

  LocationItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _type = $v.type;
      _isActive = $v.isActive;
      _address = $v.address;
      _phone = $v.phone;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _allowedRadius = $v.allowedRadius;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LocationItem other) {
    _$v = other as _$LocationItem;
  }

  @override
  void update(void Function(LocationItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LocationItem build() => _build();

  _$LocationItem _build() {
    final _$result =
        _$v ??
        _$LocationItem._(
          id: id,
          code: code,
          name: name,
          type: type,
          isActive: isActive,
          address: address,
          phone: phone,
          latitude: latitude,
          longitude: longitude,
          allowedRadius: allowedRadius,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
