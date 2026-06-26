// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_shipments_get200_response_data_inner_seller.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiShipmentsGet200ResponseDataInnerSeller
    extends ApiShipmentsGet200ResponseDataInnerSeller {
  @override
  final int? id;
  @override
  final String? userName;
  @override
  final String? shopName;

  factory _$ApiShipmentsGet200ResponseDataInnerSeller([
    void Function(ApiShipmentsGet200ResponseDataInnerSellerBuilder)? updates,
  ]) => (ApiShipmentsGet200ResponseDataInnerSellerBuilder()..update(updates))
      ._build();

  _$ApiShipmentsGet200ResponseDataInnerSeller._({
    this.id,
    this.userName,
    this.shopName,
  }) : super._();
  @override
  ApiShipmentsGet200ResponseDataInnerSeller rebuild(
    void Function(ApiShipmentsGet200ResponseDataInnerSellerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiShipmentsGet200ResponseDataInnerSellerBuilder toBuilder() =>
      ApiShipmentsGet200ResponseDataInnerSellerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiShipmentsGet200ResponseDataInnerSeller &&
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
    return (newBuiltValueToStringHelper(
            r'ApiShipmentsGet200ResponseDataInnerSeller',
          )
          ..add('id', id)
          ..add('userName', userName)
          ..add('shopName', shopName))
        .toString();
  }
}

class ApiShipmentsGet200ResponseDataInnerSellerBuilder
    implements
        Builder<
          ApiShipmentsGet200ResponseDataInnerSeller,
          ApiShipmentsGet200ResponseDataInnerSellerBuilder
        > {
  _$ApiShipmentsGet200ResponseDataInnerSeller? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _shopName;
  String? get shopName => _$this._shopName;
  set shopName(String? shopName) => _$this._shopName = shopName;

  ApiShipmentsGet200ResponseDataInnerSellerBuilder() {
    ApiShipmentsGet200ResponseDataInnerSeller._defaults(this);
  }

  ApiShipmentsGet200ResponseDataInnerSellerBuilder get _$this {
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
  void replace(ApiShipmentsGet200ResponseDataInnerSeller other) {
    _$v = other as _$ApiShipmentsGet200ResponseDataInnerSeller;
  }

  @override
  void update(
    void Function(ApiShipmentsGet200ResponseDataInnerSellerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiShipmentsGet200ResponseDataInnerSeller build() => _build();

  _$ApiShipmentsGet200ResponseDataInnerSeller _build() {
    final _$result =
        _$v ??
        _$ApiShipmentsGet200ResponseDataInnerSeller._(
          id: id,
          userName: userName,
          shopName: shopName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
