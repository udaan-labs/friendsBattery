// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Product extends Product {
  @override
  final String? id;
  @override
  final String? categoryId;
  @override
  final String? productNameId;
  @override
  final String? productModelId;
  @override
  final double? minPrice;
  @override
  final bool? onSale;
  @override
  final double? offerPrice;
  @override
  final int? minQuantity;
  @override
  final DateTime? createdAt;
  @override
  final Category? category;
  @override
  final ProductName? productName;
  @override
  final ProductModel? productModel;

  factory _$Product([void Function(ProductBuilder)? updates]) =>
      (ProductBuilder()..update(updates))._build();

  _$Product._(
      {this.id,
      this.categoryId,
      this.productNameId,
      this.productModelId,
      this.minPrice,
      this.onSale,
      this.offerPrice,
      this.minQuantity,
      this.createdAt,
      this.category,
      this.productName,
      this.productModel})
      : super._();
  @override
  Product rebuild(void Function(ProductBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductBuilder toBuilder() => ProductBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Product &&
        id == other.id &&
        categoryId == other.categoryId &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId &&
        minPrice == other.minPrice &&
        onSale == other.onSale &&
        offerPrice == other.offerPrice &&
        minQuantity == other.minQuantity &&
        createdAt == other.createdAt &&
        category == other.category &&
        productName == other.productName &&
        productModel == other.productModel;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
    _$hash = $jc(_$hash, minPrice.hashCode);
    _$hash = $jc(_$hash, onSale.hashCode);
    _$hash = $jc(_$hash, offerPrice.hashCode);
    _$hash = $jc(_$hash, minQuantity.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, productModel.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Product')
          ..add('id', id)
          ..add('categoryId', categoryId)
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId)
          ..add('minPrice', minPrice)
          ..add('onSale', onSale)
          ..add('offerPrice', offerPrice)
          ..add('minQuantity', minQuantity)
          ..add('createdAt', createdAt)
          ..add('category', category)
          ..add('productName', productName)
          ..add('productModel', productModel))
        .toString();
  }
}

class ProductBuilder implements Builder<Product, ProductBuilder> {
  _$Product? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _categoryId;
  String? get categoryId => _$this._categoryId;
  set categoryId(String? categoryId) => _$this._categoryId = categoryId;

  String? _productNameId;
  String? get productNameId => _$this._productNameId;
  set productNameId(String? productNameId) =>
      _$this._productNameId = productNameId;

  String? _productModelId;
  String? get productModelId => _$this._productModelId;
  set productModelId(String? productModelId) =>
      _$this._productModelId = productModelId;

  double? _minPrice;
  double? get minPrice => _$this._minPrice;
  set minPrice(double? minPrice) => _$this._minPrice = minPrice;

  bool? _onSale;
  bool? get onSale => _$this._onSale;
  set onSale(bool? onSale) => _$this._onSale = onSale;

  double? _offerPrice;
  double? get offerPrice => _$this._offerPrice;
  set offerPrice(double? offerPrice) => _$this._offerPrice = offerPrice;

  int? _minQuantity;
  int? get minQuantity => _$this._minQuantity;
  set minQuantity(int? minQuantity) => _$this._minQuantity = minQuantity;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  CategoryBuilder? _category;
  CategoryBuilder get category => _$this._category ??= CategoryBuilder();
  set category(CategoryBuilder? category) => _$this._category = category;

  ProductNameBuilder? _productName;
  ProductNameBuilder get productName =>
      _$this._productName ??= ProductNameBuilder();
  set productName(ProductNameBuilder? productName) =>
      _$this._productName = productName;

  ProductModelBuilder? _productModel;
  ProductModelBuilder get productModel =>
      _$this._productModel ??= ProductModelBuilder();
  set productModel(ProductModelBuilder? productModel) =>
      _$this._productModel = productModel;

  ProductBuilder() {
    Product._defaults(this);
  }

  ProductBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _categoryId = $v.categoryId;
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
      _minPrice = $v.minPrice;
      _onSale = $v.onSale;
      _offerPrice = $v.offerPrice;
      _minQuantity = $v.minQuantity;
      _createdAt = $v.createdAt;
      _category = $v.category?.toBuilder();
      _productName = $v.productName?.toBuilder();
      _productModel = $v.productModel?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Product other) {
    _$v = other as _$Product;
  }

  @override
  void update(void Function(ProductBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Product build() => _build();

  _$Product _build() {
    _$Product _$result;
    try {
      _$result = _$v ??
          _$Product._(
            id: id,
            categoryId: categoryId,
            productNameId: productNameId,
            productModelId: productModelId,
            minPrice: minPrice,
            onSale: onSale,
            offerPrice: offerPrice,
            minQuantity: minQuantity,
            createdAt: createdAt,
            category: _category?.build(),
            productName: _productName?.build(),
            productModel: _productModel?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'category';
        _category?.build();
        _$failedField = 'productName';
        _productName?.build();
        _$failedField = 'productModel';
        _productModel?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Product', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
