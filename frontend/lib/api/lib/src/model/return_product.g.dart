// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_product.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReturnProduct extends ReturnProduct {
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

  factory _$ReturnProduct([void Function(ReturnProductBuilder)? updates]) =>
      (ReturnProductBuilder()..update(updates))._build();

  _$ReturnProduct._({
    this.id,
    this.transactionId,
    this.productId,
    this.serialNumber,
    this.reason,
    this.returnType,
    this.returnById,
    this.returnToId,
    this.createdAt,
  }) : super._();
  @override
  ReturnProduct rebuild(void Function(ReturnProductBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReturnProductBuilder toBuilder() => ReturnProductBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReturnProduct &&
        id == other.id &&
        transactionId == other.transactionId &&
        productId == other.productId &&
        serialNumber == other.serialNumber &&
        reason == other.reason &&
        returnType == other.returnType &&
        returnById == other.returnById &&
        returnToId == other.returnToId &&
        createdAt == other.createdAt;
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReturnProduct')
          ..add('id', id)
          ..add('transactionId', transactionId)
          ..add('productId', productId)
          ..add('serialNumber', serialNumber)
          ..add('reason', reason)
          ..add('returnType', returnType)
          ..add('returnById', returnById)
          ..add('returnToId', returnToId)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ReturnProductBuilder
    implements Builder<ReturnProduct, ReturnProductBuilder> {
  _$ReturnProduct? _$v;

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

  ReturnProductBuilder() {
    ReturnProduct._defaults(this);
  }

  ReturnProductBuilder get _$this {
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
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReturnProduct other) {
    _$v = other as _$ReturnProduct;
  }

  @override
  void update(void Function(ReturnProductBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReturnProduct build() => _build();

  _$ReturnProduct _build() {
    final _$result =
        _$v ??
        _$ReturnProduct._(
          id: id,
          transactionId: transactionId,
          productId: productId,
          serialNumber: serialNumber,
          reason: reason,
          returnType: returnType,
          returnById: returnById,
          returnToId: returnToId,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
