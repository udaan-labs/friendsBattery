// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_list_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReturnListItem extends ReturnListItem {
  @override
  final String? id;
  @override
  final String? transactionId;
  @override
  final String? productId;
  @override
  final String? serialNumber;
  @override
  final String? reason;
  @override
  final String? returnType;
  @override
  final String? returnById;
  @override
  final String? returnToId;
  @override
  final DateTime? createdAt;
  @override
  final ReturnListProduct? product;

  factory _$ReturnListItem([void Function(ReturnListItemBuilder)? updates]) =>
      (ReturnListItemBuilder()..update(updates))._build();

  _$ReturnListItem._({
    this.id,
    this.transactionId,
    this.productId,
    this.serialNumber,
    this.reason,
    this.returnType,
    this.returnById,
    this.returnToId,
    this.createdAt,
    this.product,
  }) : super._();
  @override
  ReturnListItem rebuild(void Function(ReturnListItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReturnListItemBuilder toBuilder() => ReturnListItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReturnListItem &&
        id == other.id &&
        transactionId == other.transactionId &&
        productId == other.productId &&
        serialNumber == other.serialNumber &&
        reason == other.reason &&
        returnType == other.returnType &&
        returnById == other.returnById &&
        returnToId == other.returnToId &&
        createdAt == other.createdAt &&
        product == other.product;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, transactionId.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, returnType.hashCode);
    _$hash = $jc(_$hash, returnById.hashCode);
    _$hash = $jc(_$hash, returnToId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, product.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReturnListItem')
          ..add('id', id)
          ..add('transactionId', transactionId)
          ..add('productId', productId)
          ..add('serialNumber', serialNumber)
          ..add('reason', reason)
          ..add('returnType', returnType)
          ..add('returnById', returnById)
          ..add('returnToId', returnToId)
          ..add('createdAt', createdAt)
          ..add('product', product))
        .toString();
  }
}

class ReturnListItemBuilder
    implements Builder<ReturnListItem, ReturnListItemBuilder> {
  _$ReturnListItem? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _transactionId;
  String? get transactionId => _$this._transactionId;
  set transactionId(String? transactionId) =>
      _$this._transactionId = transactionId;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  String? _serialNumber;
  String? get serialNumber => _$this._serialNumber;
  set serialNumber(String? serialNumber) => _$this._serialNumber = serialNumber;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _returnType;
  String? get returnType => _$this._returnType;
  set returnType(String? returnType) => _$this._returnType = returnType;

  String? _returnById;
  String? get returnById => _$this._returnById;
  set returnById(String? returnById) => _$this._returnById = returnById;

  String? _returnToId;
  String? get returnToId => _$this._returnToId;
  set returnToId(String? returnToId) => _$this._returnToId = returnToId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ReturnListProductBuilder? _product;
  ReturnListProductBuilder get product =>
      _$this._product ??= ReturnListProductBuilder();
  set product(ReturnListProductBuilder? product) => _$this._product = product;

  ReturnListItemBuilder() {
    ReturnListItem._defaults(this);
  }

  ReturnListItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _transactionId = $v.transactionId;
      _productId = $v.productId;
      _serialNumber = $v.serialNumber;
      _reason = $v.reason;
      _returnType = $v.returnType;
      _returnById = $v.returnById;
      _returnToId = $v.returnToId;
      _createdAt = $v.createdAt;
      _product = $v.product?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReturnListItem other) {
    _$v = other as _$ReturnListItem;
  }

  @override
  void update(void Function(ReturnListItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReturnListItem build() => _build();

  _$ReturnListItem _build() {
    _$ReturnListItem _$result;
    try {
      _$result =
          _$v ??
          _$ReturnListItem._(
            id: id,
            transactionId: transactionId,
            productId: productId,
            serialNumber: serialNumber,
            reason: reason,
            returnType: returnType,
            returnById: returnById,
            returnToId: returnToId,
            createdAt: createdAt,
            product: _product?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'product';
        _product?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ReturnListItem',
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
