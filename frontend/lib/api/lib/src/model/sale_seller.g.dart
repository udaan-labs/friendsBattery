// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_seller.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SaleSeller extends SaleSeller {
  @override
  final int? id;
  @override
  final String? userName;
  @override
  final String? shopName;

  factory _$SaleSeller([void Function(SaleSellerBuilder)? updates]) =>
      (SaleSellerBuilder()..update(updates))._build();

  _$SaleSeller._({this.id, this.userName, this.shopName}) : super._();
  @override
  SaleSeller rebuild(void Function(SaleSellerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SaleSellerBuilder toBuilder() => SaleSellerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SaleSeller &&
        id == other.id &&
        userName == other.userName &&
        shopName == other.shopName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, shopName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SaleSeller')
          ..add('id', id)
          ..add('userName', userName)
          ..add('shopName', shopName))
        .toString();
  }
}

class SaleSellerBuilder implements Builder<SaleSeller, SaleSellerBuilder> {
  _$SaleSeller? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _shopName;
  String? get shopName => _$this._shopName;
  set shopName(String? shopName) => _$this._shopName = shopName;

  SaleSellerBuilder() {
    SaleSeller._defaults(this);
  }

  SaleSellerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userName = $v.userName;
      _shopName = $v.shopName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SaleSeller other) {
    _$v = other as _$SaleSeller;
  }

  @override
  void update(void Function(SaleSellerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SaleSeller build() => _build();

  _$SaleSeller _build() {
    final _$result =
        _$v ?? _$SaleSeller._(id: id, userName: userName, shopName: shopName);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
