// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'created_employee_location.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreatedEmployeeLocationTypeEnum
_$createdEmployeeLocationTypeEnum_WAREHOUSE =
    const CreatedEmployeeLocationTypeEnum._('WAREHOUSE');
const CreatedEmployeeLocationTypeEnum _$createdEmployeeLocationTypeEnum_SHOP =
    const CreatedEmployeeLocationTypeEnum._('SHOP');

CreatedEmployeeLocationTypeEnum _$createdEmployeeLocationTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'WAREHOUSE':
      return _$createdEmployeeLocationTypeEnum_WAREHOUSE;
    case 'SHOP':
      return _$createdEmployeeLocationTypeEnum_SHOP;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreatedEmployeeLocationTypeEnum>
_$createdEmployeeLocationTypeEnumValues =
    BuiltSet<CreatedEmployeeLocationTypeEnum>(
      const <CreatedEmployeeLocationTypeEnum>[
        _$createdEmployeeLocationTypeEnum_WAREHOUSE,
        _$createdEmployeeLocationTypeEnum_SHOP,
      ],
    );

Serializer<CreatedEmployeeLocationTypeEnum>
_$createdEmployeeLocationTypeEnumSerializer =
    _$CreatedEmployeeLocationTypeEnumSerializer();

class _$CreatedEmployeeLocationTypeEnumSerializer
    implements PrimitiveSerializer<CreatedEmployeeLocationTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'WAREHOUSE': 'WAREHOUSE',
    'SHOP': 'SHOP',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'WAREHOUSE': 'WAREHOUSE',
    'SHOP': 'SHOP',
  };

  @override
  final Iterable<Type> types = const <Type>[CreatedEmployeeLocationTypeEnum];
  @override
  final String wireName = 'CreatedEmployeeLocationTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreatedEmployeeLocationTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreatedEmployeeLocationTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreatedEmployeeLocationTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreatedEmployeeLocation extends CreatedEmployeeLocation {
  @override
  final int? id;
  @override
  final String? code;
  @override
  final String? name;
  @override
  final CreatedEmployeeLocationTypeEnum? type;
  @override
  final bool? isActive;

  factory _$CreatedEmployeeLocation([
    void Function(CreatedEmployeeLocationBuilder)? updates,
  ]) => (CreatedEmployeeLocationBuilder()..update(updates))._build();

  _$CreatedEmployeeLocation._({
    this.id,
    this.code,
    this.name,
    this.type,
    this.isActive,
  }) : super._();
  @override
  CreatedEmployeeLocation rebuild(
    void Function(CreatedEmployeeLocationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreatedEmployeeLocationBuilder toBuilder() =>
      CreatedEmployeeLocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatedEmployeeLocation &&
        id == other.id &&
        code == other.code &&
        name == other.name &&
        type == other.type &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreatedEmployeeLocation')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('type', type)
          ..add('isActive', isActive))
        .toString();
  }
}

class CreatedEmployeeLocationBuilder
    implements
        Builder<CreatedEmployeeLocation, CreatedEmployeeLocationBuilder> {
  _$CreatedEmployeeLocation? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  CreatedEmployeeLocationTypeEnum? _type;
  CreatedEmployeeLocationTypeEnum? get type => _$this._type;
  set type(CreatedEmployeeLocationTypeEnum? type) => _$this._type = type;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  CreatedEmployeeLocationBuilder() {
    CreatedEmployeeLocation._defaults(this);
  }

  CreatedEmployeeLocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _type = $v.type;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatedEmployeeLocation other) {
    _$v = other as _$CreatedEmployeeLocation;
  }

  @override
  void update(void Function(CreatedEmployeeLocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatedEmployeeLocation build() => _build();

  _$CreatedEmployeeLocation _build() {
    final _$result =
        _$v ??
        _$CreatedEmployeeLocation._(
          id: id,
          code: code,
          name: name,
          type: type,
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
