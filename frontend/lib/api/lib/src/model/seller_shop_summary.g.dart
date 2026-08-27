// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_shop_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SellerShopSummary extends SellerShopSummary {
  @override
  final int? id;
  @override
  final String? userId;
  @override
  final String? userName;
  @override
  final String? shopName;
  @override
  final String? userNumber;
  @override
  final bool? isActive;
  @override
  final bool? isVerified;
  @override
  final int? totalStock;
  @override
  final int? todaySales;
  @override
  final int? pendingShipments;
  @override
  final bool? hasLowStock;

  factory _$SellerShopSummary([
    void Function(SellerShopSummaryBuilder)? updates,
  ]) => (SellerShopSummaryBuilder()..update(updates))._build();

  _$SellerShopSummary._({
    this.id,
    this.userId,
    this.userName,
    this.shopName,
    this.userNumber,
    this.isActive,
    this.isVerified,
    this.totalStock,
    this.todaySales,
    this.pendingShipments,
    this.hasLowStock,
  }) : super._();
  @override
  SellerShopSummary rebuild(void Function(SellerShopSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SellerShopSummaryBuilder toBuilder() =>
      SellerShopSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SellerShopSummary &&
        id == other.id &&
        userId == other.userId &&
        userName == other.userName &&
        shopName == other.shopName &&
        userNumber == other.userNumber &&
        isActive == other.isActive &&
        isVerified == other.isVerified &&
        totalStock == other.totalStock &&
        todaySales == other.todaySales &&
        pendingShipments == other.pendingShipments &&
        hasLowStock == other.hasLowStock;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, shopName.hashCode);
    _$hash = $jc(_$hash, userNumber.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, isVerified.hashCode);
    _$hash = $jc(_$hash, totalStock.hashCode);
    _$hash = $jc(_$hash, todaySales.hashCode);
    _$hash = $jc(_$hash, pendingShipments.hashCode);
    _$hash = $jc(_$hash, hasLowStock.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SellerShopSummary')
          ..add('id', id)
          ..add('userId', userId)
          ..add('userName', userName)
          ..add('shopName', shopName)
          ..add('userNumber', userNumber)
          ..add('isActive', isActive)
          ..add('isVerified', isVerified)
          ..add('totalStock', totalStock)
          ..add('todaySales', todaySales)
          ..add('pendingShipments', pendingShipments)
          ..add('hasLowStock', hasLowStock))
        .toString();
  }
}

class SellerShopSummaryBuilder
    implements Builder<SellerShopSummary, SellerShopSummaryBuilder> {
  _$SellerShopSummary? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _shopName;
  String? get shopName => _$this._shopName;
  set shopName(String? shopName) => _$this._shopName = shopName;

  String? _userNumber;
  String? get userNumber => _$this._userNumber;
  set userNumber(String? userNumber) => _$this._userNumber = userNumber;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  bool? _isVerified;
  bool? get isVerified => _$this._isVerified;
  set isVerified(bool? isVerified) => _$this._isVerified = isVerified;

  int? _totalStock;
  int? get totalStock => _$this._totalStock;
  set totalStock(int? totalStock) => _$this._totalStock = totalStock;

  int? _todaySales;
  int? get todaySales => _$this._todaySales;
  set todaySales(int? todaySales) => _$this._todaySales = todaySales;

  int? _pendingShipments;
  int? get pendingShipments => _$this._pendingShipments;
  set pendingShipments(int? pendingShipments) =>
      _$this._pendingShipments = pendingShipments;

  bool? _hasLowStock;
  bool? get hasLowStock => _$this._hasLowStock;
  set hasLowStock(bool? hasLowStock) => _$this._hasLowStock = hasLowStock;

  SellerShopSummaryBuilder() {
    SellerShopSummary._defaults(this);
  }

  SellerShopSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _userName = $v.userName;
      _shopName = $v.shopName;
      _userNumber = $v.userNumber;
      _isActive = $v.isActive;
      _isVerified = $v.isVerified;
      _totalStock = $v.totalStock;
      _todaySales = $v.todaySales;
      _pendingShipments = $v.pendingShipments;
      _hasLowStock = $v.hasLowStock;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SellerShopSummary other) {
    _$v = other as _$SellerShopSummary;
  }

  @override
  void update(void Function(SellerShopSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SellerShopSummary build() => _build();

  _$SellerShopSummary _build() {
    final _$result =
        _$v ??
        _$SellerShopSummary._(
          id: id,
          userId: userId,
          userName: userName,
          shopName: shopName,
          userNumber: userNumber,
          isActive: isActive,
          isVerified: isVerified,
          totalStock: totalStock,
          todaySales: todaySales,
          pendingShipments: pendingShipments,
          hasLowStock: hasLowStock,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
