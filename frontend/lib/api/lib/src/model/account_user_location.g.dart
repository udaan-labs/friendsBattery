// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_user_location.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountUserLocation extends AccountUserLocation {
  @override
  final String? name;

  factory _$AccountUserLocation([
    void Function(AccountUserLocationBuilder)? updates,
  ]) => (AccountUserLocationBuilder()..update(updates))._build();

  _$AccountUserLocation._({this.name}) : super._();
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
    return other is AccountUserLocation && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AccountUserLocation',
    )..add('name', name)).toString();
  }
}

class AccountUserLocationBuilder
    implements Builder<AccountUserLocation, AccountUserLocationBuilder> {
  _$AccountUserLocation? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  AccountUserLocationBuilder() {
    AccountUserLocation._defaults(this);
  }

  AccountUserLocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
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
    final _$result = _$v ?? _$AccountUserLocation._(name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
