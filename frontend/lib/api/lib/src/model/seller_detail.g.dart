// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SellerDetail extends SellerDetail {
  @override
  final int? id;
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
  final int? locationId;
  @override
  final SellerDetailLocation? location;
  @override
  final SellerStatistics? statistics;
  @override
  final BuiltList<InventoryListItem>? inventory;
  @override
  final DateTime? createdAt;

  factory _$SellerDetail([void Function(SellerDetailBuilder)? updates]) =>
      (SellerDetailBuilder()..update(updates))._build();

  _$SellerDetail._({
    this.id,
    this.userName,
    this.shopName,
    this.userNumber,
    this.isActive,
    this.isVerified,
    this.locationId,
    this.location,
    this.statistics,
    this.inventory,
    this.createdAt,
  }) : super._();
  @override
  SellerDetail rebuild(void Function(SellerDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SellerDetailBuilder toBuilder() => SellerDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SellerDetail &&
        id == other.id &&
        userName == other.userName &&
        shopName == other.shopName &&
        userNumber == other.userNumber &&
        isActive == other.isActive &&
        isVerified == other.isVerified &&
        locationId == other.locationId &&
        location == other.location &&
        statistics == other.statistics &&
        inventory == other.inventory &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, shopName.hashCode);
    _$hash = $jc(_$hash, userNumber.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, isVerified.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, statistics.hashCode);
    _$hash = $jc(_$hash, inventory.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SellerDetail')
          ..add('id', id)
          ..add('userName', userName)
          ..add('shopName', shopName)
          ..add('userNumber', userNumber)
          ..add('isActive', isActive)
          ..add('isVerified', isVerified)
          ..add('locationId', locationId)
          ..add('location', location)
          ..add('statistics', statistics)
          ..add('inventory', inventory)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class SellerDetailBuilder
    implements Builder<SellerDetail, SellerDetailBuilder> {
  _$SellerDetail? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

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

  int? _locationId;
  int? get locationId => _$this._locationId;
  set locationId(int? locationId) => _$this._locationId = locationId;

  SellerDetailLocationBuilder? _location;
  SellerDetailLocationBuilder get location =>
      _$this._location ??= SellerDetailLocationBuilder();
  set location(SellerDetailLocationBuilder? location) =>
      _$this._location = location;

  SellerStatisticsBuilder? _statistics;
  SellerStatisticsBuilder get statistics =>
      _$this._statistics ??= SellerStatisticsBuilder();
  set statistics(SellerStatisticsBuilder? statistics) =>
      _$this._statistics = statistics;

  ListBuilder<InventoryListItem>? _inventory;
  ListBuilder<InventoryListItem> get inventory =>
      _$this._inventory ??= ListBuilder<InventoryListItem>();
  set inventory(ListBuilder<InventoryListItem>? inventory) =>
      _$this._inventory = inventory;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  SellerDetailBuilder() {
    SellerDetail._defaults(this);
  }

  SellerDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userName = $v.userName;
      _shopName = $v.shopName;
      _userNumber = $v.userNumber;
      _isActive = $v.isActive;
      _isVerified = $v.isVerified;
      _locationId = $v.locationId;
      _location = $v.location?.toBuilder();
      _statistics = $v.statistics?.toBuilder();
      _inventory = $v.inventory?.toBuilder();
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SellerDetail other) {
    _$v = other as _$SellerDetail;
  }

  @override
  void update(void Function(SellerDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SellerDetail build() => _build();

  _$SellerDetail _build() {
    _$SellerDetail _$result;
    try {
      _$result =
          _$v ??
          _$SellerDetail._(
            id: id,
            userName: userName,
            shopName: shopName,
            userNumber: userNumber,
            isActive: isActive,
            isVerified: isVerified,
            locationId: locationId,
            location: _location?.build(),
            statistics: _statistics?.build(),
            inventory: _inventory?.build(),
            createdAt: createdAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
        _$failedField = 'statistics';
        _statistics?.build();
        _$failedField = 'inventory';
        _inventory?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SellerDetail',
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
