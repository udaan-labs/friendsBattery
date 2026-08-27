// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_shipment_list_item_items_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SellerShipmentListItemItemsInner
    extends SellerShipmentListItemItemsInner {
  @override
  final String? productName;
  @override
  final String? productModel;
  @override
  final int? quantity;

  factory _$SellerShipmentListItemItemsInner([
    void Function(SellerShipmentListItemItemsInnerBuilder)? updates,
  ]) => (SellerShipmentListItemItemsInnerBuilder()..update(updates))._build();

  _$SellerShipmentListItemItemsInner._({
    this.productName,
    this.productModel,
    this.quantity,
  }) : super._();
  @override
  SellerShipmentListItemItemsInner rebuild(
    void Function(SellerShipmentListItemItemsInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SellerShipmentListItemItemsInnerBuilder toBuilder() =>
      SellerShipmentListItemItemsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SellerShipmentListItemItemsInner &&
        productName == other.productName &&
        productModel == other.productModel &&
        quantity == other.quantity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, productModel.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SellerShipmentListItemItemsInner')
          ..add('productName', productName)
          ..add('productModel', productModel)
          ..add('quantity', quantity))
        .toString();
  }
}

class SellerShipmentListItemItemsInnerBuilder
    implements
        Builder<
          SellerShipmentListItemItemsInner,
          SellerShipmentListItemItemsInnerBuilder
        > {
  _$SellerShipmentListItemItemsInner? _$v;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  String? _productModel;
  String? get productModel => _$this._productModel;
  set productModel(String? productModel) => _$this._productModel = productModel;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  SellerShipmentListItemItemsInnerBuilder() {
    SellerShipmentListItemItemsInner._defaults(this);
  }

  SellerShipmentListItemItemsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productName = $v.productName;
      _productModel = $v.productModel;
      _quantity = $v.quantity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SellerShipmentListItemItemsInner other) {
    _$v = other as _$SellerShipmentListItemItemsInner;
  }

  @override
  void update(void Function(SellerShipmentListItemItemsInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SellerShipmentListItemItemsInner build() => _build();

  _$SellerShipmentListItemItemsInner _build() {
    final _$result =
        _$v ??
        _$SellerShipmentListItemItemsInner._(
          productName: productName,
          productModel: productModel,
          quantity: quantity,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
