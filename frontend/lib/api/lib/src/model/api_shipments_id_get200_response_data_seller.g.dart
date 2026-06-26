// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_shipments_id_get200_response_data_seller.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiShipmentsIdGet200ResponseDataSeller
    extends ApiShipmentsIdGet200ResponseDataSeller {
  @override
  final int? id;
  @override
  final String? userName;
  @override
  final String? shopName;
  @override
  final String? userNumber;

  factory _$ApiShipmentsIdGet200ResponseDataSeller([
    void Function(ApiShipmentsIdGet200ResponseDataSellerBuilder)? updates,
  ]) => (ApiShipmentsIdGet200ResponseDataSellerBuilder()..update(updates))
      ._build();

  _$ApiShipmentsIdGet200ResponseDataSeller._({
    this.id,
    this.userName,
    this.shopName,
    this.userNumber,
  }) : super._();
  @override
  ApiShipmentsIdGet200ResponseDataSeller rebuild(
    void Function(ApiShipmentsIdGet200ResponseDataSellerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiShipmentsIdGet200ResponseDataSellerBuilder toBuilder() =>
      ApiShipmentsIdGet200ResponseDataSellerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiShipmentsIdGet200ResponseDataSeller &&
        id == other.id &&
        userName == other.userName &&
        shopName == other.shopName &&
        userNumber == other.userNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, shopName.hashCode);
    _$hash = $jc(_$hash, userNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiShipmentsIdGet200ResponseDataSeller',
          )
          ..add('id', id)
          ..add('userName', userName)
          ..add('shopName', shopName)
          ..add('userNumber', userNumber))
        .toString();
  }
}

class ApiShipmentsIdGet200ResponseDataSellerBuilder
    implements
        Builder<
          ApiShipmentsIdGet200ResponseDataSeller,
          ApiShipmentsIdGet200ResponseDataSellerBuilder
        > {
  _$ApiShipmentsIdGet200ResponseDataSeller? _$v;

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

  ApiShipmentsIdGet200ResponseDataSellerBuilder() {
    ApiShipmentsIdGet200ResponseDataSeller._defaults(this);
  }

  ApiShipmentsIdGet200ResponseDataSellerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userName = $v.userName;
      _shopName = $v.shopName;
      _userNumber = $v.userNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiShipmentsIdGet200ResponseDataSeller other) {
    _$v = other as _$ApiShipmentsIdGet200ResponseDataSeller;
  }

  @override
  void update(
    void Function(ApiShipmentsIdGet200ResponseDataSellerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiShipmentsIdGet200ResponseDataSeller build() => _build();

  _$ApiShipmentsIdGet200ResponseDataSeller _build() {
    final _$result =
        _$v ??
        _$ApiShipmentsIdGet200ResponseDataSeller._(
          id: id,
          userName: userName,
          shopName: shopName,
          userNumber: userNumber,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
