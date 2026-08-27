// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_location.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LoginUserLocationTypeEnum _$loginUserLocationTypeEnum_WAREHOUSE =
    const LoginUserLocationTypeEnum._('WAREHOUSE');
const LoginUserLocationTypeEnum _$loginUserLocationTypeEnum_SHOP =
    const LoginUserLocationTypeEnum._('SHOP');

LoginUserLocationTypeEnum _$loginUserLocationTypeEnumValueOf(String name) {
  switch (name) {
    case 'WAREHOUSE':
      return _$loginUserLocationTypeEnum_WAREHOUSE;
    case 'SHOP':
      return _$loginUserLocationTypeEnum_SHOP;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<LoginUserLocationTypeEnum> _$loginUserLocationTypeEnumValues =
    BuiltSet<LoginUserLocationTypeEnum>(const <LoginUserLocationTypeEnum>[
      _$loginUserLocationTypeEnum_WAREHOUSE,
      _$loginUserLocationTypeEnum_SHOP,
    ]);

Serializer<LoginUserLocationTypeEnum> _$loginUserLocationTypeEnumSerializer =
    _$LoginUserLocationTypeEnumSerializer();

class _$LoginUserLocationTypeEnumSerializer
    implements PrimitiveSerializer<LoginUserLocationTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'WAREHOUSE': 'WAREHOUSE',
    'SHOP': 'SHOP',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'WAREHOUSE': 'WAREHOUSE',
    'SHOP': 'SHOP',
  };

  @override
  final Iterable<Type> types = const <Type>[LoginUserLocationTypeEnum];
  @override
  final String wireName = 'LoginUserLocationTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    LoginUserLocationTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LoginUserLocationTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LoginUserLocationTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$LoginUserLocation extends LoginUserLocation {
  @override
  final int? id;
  @override
  final String? code;
  @override
  final String? name;
  @override
  final LoginUserLocationTypeEnum? type;

  factory _$LoginUserLocation([
    void Function(LoginUserLocationBuilder)? updates,
  ]) => (LoginUserLocationBuilder()..update(updates))._build();

  _$LoginUserLocation._({this.id, this.code, this.name, this.type}) : super._();
  @override
  LoginUserLocation rebuild(void Function(LoginUserLocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginUserLocationBuilder toBuilder() =>
      LoginUserLocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginUserLocation &&
        id == other.id &&
        code == other.code &&
        name == other.name &&
        type == other.type;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginUserLocation')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('type', type))
        .toString();
  }
}

class LoginUserLocationBuilder
    implements Builder<LoginUserLocation, LoginUserLocationBuilder> {
  _$LoginUserLocation? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  LoginUserLocationTypeEnum? _type;
  LoginUserLocationTypeEnum? get type => _$this._type;
  set type(LoginUserLocationTypeEnum? type) => _$this._type = type;

  LoginUserLocationBuilder() {
    LoginUserLocation._defaults(this);
  }

  LoginUserLocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginUserLocation other) {
    _$v = other as _$LoginUserLocation;
  }

  @override
  void update(void Function(LoginUserLocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginUserLocation build() => _build();

  _$LoginUserLocation _build() {
    final _$result =
        _$v ??
        _$LoginUserLocation._(id: id, code: code, name: name, type: type);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
