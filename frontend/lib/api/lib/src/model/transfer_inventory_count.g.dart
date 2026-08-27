// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_inventory_count.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransferInventoryCount extends TransferInventoryCount {
  @override
  final int? productId;
  @override
  final String? productName;
  @override
  final String? productModel;
  @override
  final int? transferred;
  @override
  final int? adminAvailable;
  @override
  final int? sellerAvailable;

  factory _$TransferInventoryCount([
    void Function(TransferInventoryCountBuilder)? updates,
  ]) => (TransferInventoryCountBuilder()..update(updates))._build();

  _$TransferInventoryCount._({
    this.productId,
    this.productName,
    this.productModel,
    this.transferred,
    this.adminAvailable,
    this.sellerAvailable,
  }) : super._();
  @override
  TransferInventoryCount rebuild(
    void Function(TransferInventoryCountBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TransferInventoryCountBuilder toBuilder() =>
      TransferInventoryCountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransferInventoryCount &&
        productId == other.productId &&
        productName == other.productName &&
        productModel == other.productModel &&
        transferred == other.transferred &&
        adminAvailable == other.adminAvailable &&
        sellerAvailable == other.sellerAvailable;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, productModel.hashCode);
    _$hash = $jc(_$hash, transferred.hashCode);
    _$hash = $jc(_$hash, adminAvailable.hashCode);
    _$hash = $jc(_$hash, sellerAvailable.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransferInventoryCount')
          ..add('productId', productId)
          ..add('productName', productName)
          ..add('productModel', productModel)
          ..add('transferred', transferred)
          ..add('adminAvailable', adminAvailable)
          ..add('sellerAvailable', sellerAvailable))
        .toString();
  }
}

class TransferInventoryCountBuilder
    implements Builder<TransferInventoryCount, TransferInventoryCountBuilder> {
  _$TransferInventoryCount? _$v;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  String? _productModel;
  String? get productModel => _$this._productModel;
  set productModel(String? productModel) => _$this._productModel = productModel;

  int? _transferred;
  int? get transferred => _$this._transferred;
  set transferred(int? transferred) => _$this._transferred = transferred;

  int? _adminAvailable;
  int? get adminAvailable => _$this._adminAvailable;
  set adminAvailable(int? adminAvailable) =>
      _$this._adminAvailable = adminAvailable;

  int? _sellerAvailable;
  int? get sellerAvailable => _$this._sellerAvailable;
  set sellerAvailable(int? sellerAvailable) =>
      _$this._sellerAvailable = sellerAvailable;

  TransferInventoryCountBuilder() {
    TransferInventoryCount._defaults(this);
  }

  TransferInventoryCountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _productName = $v.productName;
      _productModel = $v.productModel;
      _transferred = $v.transferred;
      _adminAvailable = $v.adminAvailable;
      _sellerAvailable = $v.sellerAvailable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransferInventoryCount other) {
    _$v = other as _$TransferInventoryCount;
  }

  @override
  void update(void Function(TransferInventoryCountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransferInventoryCount build() => _build();

  _$TransferInventoryCount _build() {
    final _$result =
        _$v ??
        _$TransferInventoryCount._(
          productId: productId,
          productName: productName,
          productModel: productModel,
          transferred: transferred,
          adminAvailable: adminAvailable,
          sellerAvailable: sellerAvailable,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
