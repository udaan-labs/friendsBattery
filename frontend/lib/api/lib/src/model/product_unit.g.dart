// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_unit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProductUnitStatusEnum _$productUnitStatusEnum_AVAILABLE =
    const ProductUnitStatusEnum._('AVAILABLE');
const ProductUnitStatusEnum _$productUnitStatusEnum_IN_TRANSIT =
    const ProductUnitStatusEnum._('IN_TRANSIT');
const ProductUnitStatusEnum _$productUnitStatusEnum_SOLD =
    const ProductUnitStatusEnum._('SOLD');
const ProductUnitStatusEnum _$productUnitStatusEnum_RETURNED =
    const ProductUnitStatusEnum._('RETURNED');
const ProductUnitStatusEnum _$productUnitStatusEnum_DEFECTIVE =
    const ProductUnitStatusEnum._('DEFECTIVE');

ProductUnitStatusEnum _$productUnitStatusEnumValueOf(String name) {
  switch (name) {
    case 'AVAILABLE':
      return _$productUnitStatusEnum_AVAILABLE;
    case 'IN_TRANSIT':
      return _$productUnitStatusEnum_IN_TRANSIT;
    case 'SOLD':
      return _$productUnitStatusEnum_SOLD;
    case 'RETURNED':
      return _$productUnitStatusEnum_RETURNED;
    case 'DEFECTIVE':
      return _$productUnitStatusEnum_DEFECTIVE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ProductUnitStatusEnum> _$productUnitStatusEnumValues =
    BuiltSet<ProductUnitStatusEnum>(const <ProductUnitStatusEnum>[
      _$productUnitStatusEnum_AVAILABLE,
      _$productUnitStatusEnum_IN_TRANSIT,
      _$productUnitStatusEnum_SOLD,
      _$productUnitStatusEnum_RETURNED,
      _$productUnitStatusEnum_DEFECTIVE,
    ]);

Serializer<ProductUnitStatusEnum> _$productUnitStatusEnumSerializer =
    _$ProductUnitStatusEnumSerializer();

class _$ProductUnitStatusEnumSerializer
    implements PrimitiveSerializer<ProductUnitStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'AVAILABLE': 'AVAILABLE',
    'IN_TRANSIT': 'IN_TRANSIT',
    'SOLD': 'SOLD',
    'RETURNED': 'RETURNED',
    'DEFECTIVE': 'DEFECTIVE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'AVAILABLE': 'AVAILABLE',
    'IN_TRANSIT': 'IN_TRANSIT',
    'SOLD': 'SOLD',
    'RETURNED': 'RETURNED',
    'DEFECTIVE': 'DEFECTIVE',
  };

  @override
  final Iterable<Type> types = const <Type>[ProductUnitStatusEnum];
  @override
  final String wireName = 'ProductUnitStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    ProductUnitStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ProductUnitStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ProductUnitStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ProductUnit extends ProductUnit {
  @override
  final String? id;
  @override
  final String? productId;
  @override
  final String? ownerId;
  @override
  final String? serialNumber;
  @override
  final ProductUnitStatusEnum? status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$ProductUnit([void Function(ProductUnitBuilder)? updates]) =>
      (ProductUnitBuilder()..update(updates))._build();

  _$ProductUnit._({
    this.id,
    this.productId,
    this.ownerId,
    this.serialNumber,
    this.status,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  ProductUnit rebuild(void Function(ProductUnitBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductUnitBuilder toBuilder() => ProductUnitBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductUnit &&
        id == other.id &&
        productId == other.productId &&
        ownerId == other.ownerId &&
        serialNumber == other.serialNumber &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, ownerId.hashCode);
    _$hash = $jc(_$hash, serialNumber.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductUnit')
          ..add('id', id)
          ..add('productId', productId)
          ..add('ownerId', ownerId)
          ..add('serialNumber', serialNumber)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class ProductUnitBuilder implements Builder<ProductUnit, ProductUnitBuilder> {
  _$ProductUnit? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  String? _ownerId;
  String? get ownerId => _$this._ownerId;
  set ownerId(String? ownerId) => _$this._ownerId = ownerId;

  String? _serialNumber;
  String? get serialNumber => _$this._serialNumber;
  set serialNumber(String? serialNumber) => _$this._serialNumber = serialNumber;

  ProductUnitStatusEnum? _status;
  ProductUnitStatusEnum? get status => _$this._status;
  set status(ProductUnitStatusEnum? status) => _$this._status = status;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  ProductUnitBuilder() {
    ProductUnit._defaults(this);
  }

  ProductUnitBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _productId = $v.productId;
      _ownerId = $v.ownerId;
      _serialNumber = $v.serialNumber;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductUnit other) {
    _$v = other as _$ProductUnit;
  }

  @override
  void update(void Function(ProductUnitBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductUnit build() => _build();

  _$ProductUnit _build() {
    final _$result =
        _$v ??
        _$ProductUnit._(
          id: id,
          productId: productId,
          ownerId: ownerId,
          serialNumber: serialNumber,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
