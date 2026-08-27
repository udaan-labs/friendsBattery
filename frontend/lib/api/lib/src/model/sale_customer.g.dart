// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_customer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SaleCustomer extends SaleCustomer {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? phone;

  factory _$SaleCustomer([void Function(SaleCustomerBuilder)? updates]) =>
      (SaleCustomerBuilder()..update(updates))._build();

  _$SaleCustomer._({this.id, this.name, this.phone}) : super._();
  @override
  SaleCustomer rebuild(void Function(SaleCustomerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SaleCustomerBuilder toBuilder() => SaleCustomerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SaleCustomer &&
        id == other.id &&
        name == other.name &&
        phone == other.phone;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SaleCustomer')
          ..add('id', id)
          ..add('name', name)
          ..add('phone', phone))
        .toString();
  }
}

class SaleCustomerBuilder
    implements Builder<SaleCustomer, SaleCustomerBuilder> {
  _$SaleCustomer? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  SaleCustomerBuilder() {
    SaleCustomer._defaults(this);
  }

  SaleCustomerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _phone = $v.phone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SaleCustomer other) {
    _$v = other as _$SaleCustomer;
  }

  @override
  void update(void Function(SaleCustomerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SaleCustomer build() => _build();

  _$SaleCustomer _build() {
    final _$result = _$v ?? _$SaleCustomer._(id: id, name: name, phone: phone);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
