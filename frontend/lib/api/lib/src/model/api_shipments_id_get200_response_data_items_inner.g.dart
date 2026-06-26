// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_shipments_id_get200_response_data_items_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiShipmentsIdGet200ResponseDataItemsInner
    extends ApiShipmentsIdGet200ResponseDataItemsInner {
  @override
  final int? id;
  @override
  final String? category;
  @override
  final String? productGroup;
  @override
  final String? productName;
  @override
  final String? productModel;
  @override
  final int? quantity;
  @override
  final String? serialNumber;

  factory _$ApiShipmentsIdGet200ResponseDataItemsInner([
    void Function(ApiShipmentsIdGet200ResponseDataItemsInnerBuilder)? updates,
  ]) => (ApiShipmentsIdGet200ResponseDataItemsInnerBuilder()..update(updates))
      ._build();

  _$ApiShipmentsIdGet200ResponseDataItemsInner._({
    this.id,
    this.category,
    this.productGroup,
    this.productName,
    this.productModel,
    this.quantity,
    this.serialNumber,
  }) : super._();
  @override
  ApiShipmentsIdGet200ResponseDataItemsInner rebuild(
    void Function(ApiShipmentsIdGet200ResponseDataItemsInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiShipmentsIdGet200ResponseDataItemsInnerBuilder toBuilder() =>
      ApiShipmentsIdGet200ResponseDataItemsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiShipmentsIdGet200ResponseDataItemsInner &&
        id == other.id &&
        category == other.category &&
        productGroup == other.productGroup &&
        productName == other.productName &&
        productModel == other.productModel &&
        quantity == other.quantity &&
        serialNumber == other.serialNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, productGroup.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, productModel.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ApiShipmentsIdGet200ResponseDataItemsInner',
          )
          ..add('id', id)
          ..add('category', category)
          ..add('productGroup', productGroup)
          ..add('productName', productName)
          ..add('productModel', productModel)
          ..add('quantity', quantity)
          ..add('serialNumber', serialNumber))
        .toString();
  }
}

class ApiShipmentsIdGet200ResponseDataItemsInnerBuilder
    implements
        Builder<
          ApiShipmentsIdGet200ResponseDataItemsInner,
          ApiShipmentsIdGet200ResponseDataItemsInnerBuilder
        > {
  _$ApiShipmentsIdGet200ResponseDataItemsInner? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _productGroup;
  String? get productGroup => _$this._productGroup;
  set productGroup(String? productGroup) => _$this._productGroup = productGroup;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  String? _productModel;
  String? get productModel => _$this._productModel;
  set productModel(String? productModel) => _$this._productModel = productModel;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  String? _serialNumber;
  String? get serialNumber => _$this._serialNumber;
  set serialNumber(String? serialNumber) => _$this._serialNumber = serialNumber;

  ApiShipmentsIdGet200ResponseDataItemsInnerBuilder() {
    ApiShipmentsIdGet200ResponseDataItemsInner._defaults(this);
  }

  ApiShipmentsIdGet200ResponseDataItemsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _category = $v.category;
      _productGroup = $v.productGroup;
      _productName = $v.productName;
      _productModel = $v.productModel;
      _quantity = $v.quantity;
      _serialNumber = $v.serialNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiShipmentsIdGet200ResponseDataItemsInner other) {
    _$v = other as _$ApiShipmentsIdGet200ResponseDataItemsInner;
  }

  @override
  void update(
    void Function(ApiShipmentsIdGet200ResponseDataItemsInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiShipmentsIdGet200ResponseDataItemsInner build() => _build();

  _$ApiShipmentsIdGet200ResponseDataItemsInner _build() {
    final _$result =
        _$v ??
        _$ApiShipmentsIdGet200ResponseDataItemsInner._(
          id: id,
          category: category,
          productGroup: productGroup,
          productName: productName,
          productModel: productModel,
          quantity: quantity,
          serialNumber: serialNumber,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
