// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_location_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateLocationRequestTypeEnum _$createLocationRequestTypeEnum_SHOP =
    const CreateLocationRequestTypeEnum._('SHOP');
const CreateLocationRequestTypeEnum _$createLocationRequestTypeEnum_WAREHOUSE =
    const CreateLocationRequestTypeEnum._('WAREHOUSE');

CreateLocationRequestTypeEnum _$createLocationRequestTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'SHOP':
      return _$createLocationRequestTypeEnum_SHOP;
    case 'WAREHOUSE':
      return _$createLocationRequestTypeEnum_WAREHOUSE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateLocationRequestTypeEnum>
_$createLocationRequestTypeEnumValues = BuiltSet<CreateLocationRequestTypeEnum>(
  const <CreateLocationRequestTypeEnum>[
    _$createLocationRequestTypeEnum_SHOP,
    _$createLocationRequestTypeEnum_WAREHOUSE,
  ],
);

Serializer<CreateLocationRequestTypeEnum>
_$createLocationRequestTypeEnumSerializer =
    _$CreateLocationRequestTypeEnumSerializer();

class _$CreateLocationRequestTypeEnumSerializer
    implements PrimitiveSerializer<CreateLocationRequestTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'SHOP': 'SHOP',
    'WAREHOUSE': 'WAREHOUSE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'SHOP': 'SHOP',
    'WAREHOUSE': 'WAREHOUSE',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateLocationRequestTypeEnum];
  @override
  final String wireName = 'CreateLocationRequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateLocationRequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateLocationRequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateLocationRequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateLocationRequest extends CreateLocationRequest {
  @override
  final String? code;
  @override
  final String name;
  @override
  final CreateLocationRequestTypeEnum type;
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
  @override
  final int? warehouseId;

  factory _$CreateLocationRequest([
    void Function(CreateLocationRequestBuilder)? updates,
  ]) => (CreateLocationRequestBuilder()..update(updates))._build();

  _$CreateLocationRequest._({
    this.code,
    required this.name,
    required this.type,
    this.address,
    this.phone,
    this.latitude,
    this.longitude,
    this.allowedRadius,
    this.warehouseId,
  }) : super._();
  @override
  CreateLocationRequest rebuild(
    void Function(CreateLocationRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateLocationRequestBuilder toBuilder() =>
      CreateLocationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateLocationRequest &&
        code == other.code &&
        name == other.name &&
        type == other.type &&
        address == other.address &&
        phone == other.phone &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        allowedRadius == other.allowedRadius &&
        warehouseId == other.warehouseId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, allowedRadius.hashCode);
    _$hash = $jc(_$hash, warehouseId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateLocationRequest')
          ..add('code', code)
          ..add('name', name)
          ..add('type', type)
          ..add('address', address)
          ..add('phone', phone)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('allowedRadius', allowedRadius)
          ..add('warehouseId', warehouseId))
        .toString();
  }
}

class CreateLocationRequestBuilder
    implements Builder<CreateLocationRequest, CreateLocationRequestBuilder> {
  _$CreateLocationRequest? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  CreateLocationRequestTypeEnum? _type;
  CreateLocationRequestTypeEnum? get type => _$this._type;
  set type(CreateLocationRequestTypeEnum? type) => _$this._type = type;

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

  int? _warehouseId;
  int? get warehouseId => _$this._warehouseId;
  set warehouseId(int? warehouseId) => _$this._warehouseId = warehouseId;

  CreateLocationRequestBuilder() {
    CreateLocationRequest._defaults(this);
  }

  CreateLocationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _name = $v.name;
      _type = $v.type;
      _address = $v.address;
      _phone = $v.phone;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _allowedRadius = $v.allowedRadius;
      _warehouseId = $v.warehouseId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateLocationRequest other) {
    _$v = other as _$CreateLocationRequest;
  }

  @override
  void update(void Function(CreateLocationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateLocationRequest build() => _build();

  _$CreateLocationRequest _build() {
    final _$result =
        _$v ??
        _$CreateLocationRequest._(
          code: code,
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'CreateLocationRequest',
            'name',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'CreateLocationRequest',
            'type',
          ),
          address: address,
          phone: phone,
          latitude: latitude,
          longitude: longitude,
          allowedRadius: allowedRadius,
          warehouseId: warehouseId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
