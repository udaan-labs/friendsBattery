// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_product_model_option.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InventoryProductModelOption extends InventoryProductModelOption {
  @override
  final int? id;
  @override
  final int? productModelId;
  @override
  final String? productModel;
  @override
  final int? availableQuantity;
  @override
  final num? minSellPrice;

  factory _$InventoryProductModelOption([
    void Function(InventoryProductModelOptionBuilder)? updates,
  ]) => (InventoryProductModelOptionBuilder()..update(updates))._build();

  _$InventoryProductModelOption._({
    this.id,
    this.productModelId,
    this.productModel,
    this.availableQuantity,
    this.minSellPrice,
  }) : super._();
  @override
  InventoryProductModelOption rebuild(
    void Function(InventoryProductModelOptionBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InventoryProductModelOptionBuilder toBuilder() =>
      InventoryProductModelOptionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InventoryProductModelOption &&
        id == other.id &&
        productModelId == other.productModelId &&
        productModel == other.productModel &&
        availableQuantity == other.availableQuantity &&
        minSellPrice == other.minSellPrice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
    _$hash = $jc(_$hash, productModel.hashCode);
    _$hash = $jc(_$hash, availableQuantity.hashCode);
    _$hash = $jc(_$hash, minSellPrice.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InventoryProductModelOption')
          ..add('id', id)
          ..add('productModelId', productModelId)
          ..add('productModel', productModel)
          ..add('availableQuantity', availableQuantity)
          ..add('minSellPrice', minSellPrice))
        .toString();
  }
}

class InventoryProductModelOptionBuilder
    implements
        Builder<
          InventoryProductModelOption,
          InventoryProductModelOptionBuilder
        > {
  _$InventoryProductModelOption? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _productModelId;
  int? get productModelId => _$this._productModelId;
  set productModelId(int? productModelId) =>
      _$this._productModelId = productModelId;

  String? _productModel;
  String? get productModel => _$this._productModel;
  set productModel(String? productModel) => _$this._productModel = productModel;

  int? _availableQuantity;
  int? get availableQuantity => _$this._availableQuantity;
  set availableQuantity(int? availableQuantity) =>
      _$this._availableQuantity = availableQuantity;

  num? _minSellPrice;
  num? get minSellPrice => _$this._minSellPrice;
  set minSellPrice(num? minSellPrice) => _$this._minSellPrice = minSellPrice;

  InventoryProductModelOptionBuilder() {
    InventoryProductModelOption._defaults(this);
  }

  InventoryProductModelOptionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _productModelId = $v.productModelId;
      _productModel = $v.productModel;
      _availableQuantity = $v.availableQuantity;
      _minSellPrice = $v.minSellPrice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InventoryProductModelOption other) {
    _$v = other as _$InventoryProductModelOption;
  }

  @override
  void update(void Function(InventoryProductModelOptionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InventoryProductModelOption build() => _build();

  _$InventoryProductModelOption _build() {
    final _$result =
        _$v ??
        _$InventoryProductModelOption._(
          id: id,
          productModelId: productModelId,
          productModel: productModel,
          availableQuantity: availableQuantity,
          minSellPrice: minSellPrice,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
