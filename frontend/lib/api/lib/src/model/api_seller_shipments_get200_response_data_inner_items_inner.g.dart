// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_seller_shipments_get200_response_data_inner_items_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiSellerShipmentsGet200ResponseDataInnerItemsInner
    extends ApiSellerShipmentsGet200ResponseDataInnerItemsInner {
  @override
  final String? productModel;
  @override
  final int? quantity;

  factory _$ApiSellerShipmentsGet200ResponseDataInnerItemsInner([
    void Function(ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder)?
    updates,
  ]) =>
      (ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder()
            ..update(updates))
          ._build();

  _$ApiSellerShipmentsGet200ResponseDataInnerItemsInner._({
    this.productModel,
    this.quantity,
  }) : super._();
  @override
  ApiSellerShipmentsGet200ResponseDataInnerItemsInner rebuild(
    void Function(ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder toBuilder() =>
      ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiSellerShipmentsGet200ResponseDataInnerItemsInner &&
        productModel == other.productModel &&
        quantity == other.quantity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productModel.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiSellerShipmentsGet200ResponseDataInnerItemsInner',
          )
          ..add('productModel', productModel)
          ..add('quantity', quantity))
        .toString();
  }
}

class ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder
    implements
        Builder<
          ApiSellerShipmentsGet200ResponseDataInnerItemsInner,
          ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder
        > {
  _$ApiSellerShipmentsGet200ResponseDataInnerItemsInner? _$v;

  String? _productModel;
  String? get productModel => _$this._productModel;
  set productModel(String? productModel) => _$this._productModel = productModel;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder() {
    ApiSellerShipmentsGet200ResponseDataInnerItemsInner._defaults(this);
  }

  ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productModel = $v.productModel;
      _quantity = $v.quantity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiSellerShipmentsGet200ResponseDataInnerItemsInner other) {
    _$v = other as _$ApiSellerShipmentsGet200ResponseDataInnerItemsInner;
  }

  @override
  void update(
    void Function(ApiSellerShipmentsGet200ResponseDataInnerItemsInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiSellerShipmentsGet200ResponseDataInnerItemsInner build() => _build();

  _$ApiSellerShipmentsGet200ResponseDataInnerItemsInner _build() {
    final _$result =
        _$v ??
        _$ApiSellerShipmentsGet200ResponseDataInnerItemsInner._(
          productModel: productModel,
          quantity: quantity,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
