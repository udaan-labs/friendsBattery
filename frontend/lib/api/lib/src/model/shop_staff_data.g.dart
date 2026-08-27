// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_staff_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ShopStaffData extends ShopStaffData {
  @override
  final SellerDetailLocation? location;
  @override
  final BuiltList<ShopStaffMember>? admins;
  @override
  final BuiltList<ShopStaffMember>? sellers;
  @override
  final BuiltList<ShopStaffMember>? employees;

  factory _$ShopStaffData([void Function(ShopStaffDataBuilder)? updates]) =>
      (ShopStaffDataBuilder()..update(updates))._build();

  _$ShopStaffData._({this.location, this.admins, this.sellers, this.employees})
    : super._();
  @override
  ShopStaffData rebuild(void Function(ShopStaffDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShopStaffDataBuilder toBuilder() => ShopStaffDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShopStaffData &&
        location == other.location &&
        admins == other.admins &&
        sellers == other.sellers &&
        employees == other.employees;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, admins.hashCode);
    _$hash = $jc(_$hash, sellers.hashCode);
    _$hash = $jc(_$hash, employees.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ShopStaffData')
          ..add('location', location)
          ..add('admins', admins)
          ..add('sellers', sellers)
          ..add('employees', employees))
        .toString();
  }
}

class ShopStaffDataBuilder
    implements Builder<ShopStaffData, ShopStaffDataBuilder> {
  _$ShopStaffData? _$v;

  SellerDetailLocationBuilder? _location;
  SellerDetailLocationBuilder get location =>
      _$this._location ??= SellerDetailLocationBuilder();
  set location(SellerDetailLocationBuilder? location) =>
      _$this._location = location;

  ListBuilder<ShopStaffMember>? _admins;
  ListBuilder<ShopStaffMember> get admins =>
      _$this._admins ??= ListBuilder<ShopStaffMember>();
  set admins(ListBuilder<ShopStaffMember>? admins) => _$this._admins = admins;

  ListBuilder<ShopStaffMember>? _sellers;
  ListBuilder<ShopStaffMember> get sellers =>
      _$this._sellers ??= ListBuilder<ShopStaffMember>();
  set sellers(ListBuilder<ShopStaffMember>? sellers) =>
      _$this._sellers = sellers;

  ListBuilder<ShopStaffMember>? _employees;
  ListBuilder<ShopStaffMember> get employees =>
      _$this._employees ??= ListBuilder<ShopStaffMember>();
  set employees(ListBuilder<ShopStaffMember>? employees) =>
      _$this._employees = employees;

  ShopStaffDataBuilder() {
    ShopStaffData._defaults(this);
  }

  ShopStaffDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _location = $v.location?.toBuilder();
      _admins = $v.admins?.toBuilder();
      _sellers = $v.sellers?.toBuilder();
      _employees = $v.employees?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ShopStaffData other) {
    _$v = other as _$ShopStaffData;
  }

  @override
  void update(void Function(ShopStaffDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ShopStaffData build() => _build();

  _$ShopStaffData _build() {
    _$ShopStaffData _$result;
    try {
      _$result =
          _$v ??
          _$ShopStaffData._(
            location: _location?.build(),
            admins: _admins?.build(),
            sellers: _sellers?.build(),
            employees: _employees?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
        _$failedField = 'admins';
        _admins?.build();
        _$failedField = 'sellers';
        _sellers?.build();
        _$failedField = 'employees';
        _employees?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ShopStaffData',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
