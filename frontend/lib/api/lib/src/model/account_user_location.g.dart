// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_user_location.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountUserLocationTypeEnum _$accountUserLocationTypeEnum_WAREHOUSE =
    const AccountUserLocationTypeEnum._('WAREHOUSE');
const AccountUserLocationTypeEnum _$accountUserLocationTypeEnum_SHOP =
    const AccountUserLocationTypeEnum._('SHOP');

AccountUserLocationTypeEnum _$accountUserLocationTypeEnumValueOf(String name) {
  switch (name) {
    case 'WAREHOUSE':
      return _$accountUserLocationTypeEnum_WAREHOUSE;
    case 'SHOP':
      return _$accountUserLocationTypeEnum_SHOP;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AccountUserLocationTypeEnum>
_$accountUserLocationTypeEnumValues = BuiltSet<AccountUserLocationTypeEnum>(
  const <AccountUserLocationTypeEnum>[
    _$accountUserLocationTypeEnum_WAREHOUSE,
    _$accountUserLocationTypeEnum_SHOP,
  ],
);

Serializer<AccountUserLocationTypeEnum>
_$accountUserLocationTypeEnumSerializer =
    _$AccountUserLocationTypeEnumSerializer();

class _$AccountUserLocationTypeEnumSerializer
    implements PrimitiveSerializer<AccountUserLocationTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'WAREHOUSE': 'WAREHOUSE',
    'SHOP': 'SHOP',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'WAREHOUSE': 'WAREHOUSE',
    'SHOP': 'SHOP',
  };

  @override
  final Iterable<Type> types = const <Type>[AccountUserLocationTypeEnum];
  @override
  final String wireName = 'AccountUserLocationTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AccountUserLocationTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AccountUserLocationTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AccountUserLocationTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AccountUserLocation extends AccountUserLocation {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final AccountUserLocationTypeEnum? type;

  factory _$AccountUserLocation([
    void Function(AccountUserLocationBuilder)? updates,
  ]) => (AccountUserLocationBuilder()..update(updates))._build();

  _$AccountUserLocation._({this.id, this.name, this.type}) : super._();
  @override
  AccountUserLocation rebuild(
    void Function(AccountUserLocationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountUserLocationBuilder toBuilder() =>
      AccountUserLocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountUserLocation &&
        id == other.id &&
        name == other.name &&
        type == other.type;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountUserLocation')
          ..add('id', id)
          ..add('name', name)
          ..add('type', type))
        .toString();
  }
}

class AccountUserLocationBuilder
    implements Builder<AccountUserLocation, AccountUserLocationBuilder> {
  _$AccountUserLocation? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  AccountUserLocationTypeEnum? _type;
  AccountUserLocationTypeEnum? get type => _$this._type;
  set type(AccountUserLocationTypeEnum? type) => _$this._type = type;

  AccountUserLocationBuilder() {
    AccountUserLocation._defaults(this);
  }

  AccountUserLocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountUserLocation other) {
    _$v = other as _$AccountUserLocation;
  }

  @override
  void update(void Function(AccountUserLocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountUserLocation build() => _build();

  _$AccountUserLocation _build() {
    final _$result =
        _$v ?? _$AccountUserLocation._(id: id, name: name, type: type);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
