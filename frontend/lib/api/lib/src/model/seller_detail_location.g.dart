// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_detail_location.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SellerDetailLocation extends SellerDetailLocation {
  @override
  final int? id;
  @override
  final String? code;
  @override
  final String? name;
  @override
  final String? type;
  @override
  final bool? isActive;

  factory _$SellerDetailLocation([
    void Function(SellerDetailLocationBuilder)? updates,
  ]) => (SellerDetailLocationBuilder()..update(updates))._build();

  _$SellerDetailLocation._({
    this.id,
    this.code,
    this.name,
    this.type,
    this.isActive,
  }) : super._();
  @override
  SellerDetailLocation rebuild(
    void Function(SellerDetailLocationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SellerDetailLocationBuilder toBuilder() =>
      SellerDetailLocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SellerDetailLocation &&
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
    return (newBuiltValueToStringHelper(r'SellerDetailLocation')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('type', type)
          ..add('isActive', isActive))
        .toString();
  }
}

class SellerDetailLocationBuilder
    implements Builder<SellerDetailLocation, SellerDetailLocationBuilder> {
  _$SellerDetailLocation? _$v;

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

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  SellerDetailLocationBuilder() {
    SellerDetailLocation._defaults(this);
  }

  SellerDetailLocationBuilder get _$this {
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
  void replace(SellerDetailLocation other) {
    _$v = other as _$SellerDetailLocation;
  }

  @override
  void update(void Function(SellerDetailLocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SellerDetailLocation build() => _build();

  _$SellerDetailLocation _build() {
    final _$result =
        _$v ??
        _$SellerDetailLocation._(
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
