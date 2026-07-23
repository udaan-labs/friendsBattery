// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_shipment_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateShipmentItem extends CreateShipmentItem {
  @override
  final int productNameId;
  @override
  final int productModelId;
  @override
  final BuiltList<String> serialNumbers;
  @override
  final num? pricePerPiece;

  factory _$CreateShipmentItem([
    void Function(CreateShipmentItemBuilder)? updates,
  ]) => (CreateShipmentItemBuilder()..update(updates))._build();

  _$CreateShipmentItem._({
    required this.productNameId,
    required this.productModelId,
    required this.serialNumbers,
    this.pricePerPiece,
  }) : super._();
  @override
  CreateShipmentItem rebuild(
    void Function(CreateShipmentItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateShipmentItemBuilder toBuilder() =>
      CreateShipmentItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateShipmentItem &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId &&
        serialNumbers == other.serialNumbers &&
        pricePerPiece == other.pricePerPiece;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
    _$hash = $jc(_$hash, serialNumbers.hashCode);
    _$hash = $jc(_$hash, pricePerPiece.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateShipmentItem')
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId)
          ..add('serialNumbers', serialNumbers)
          ..add('pricePerPiece', pricePerPiece))
        .toString();
  }
}

class CreateShipmentItemBuilder
    implements Builder<CreateShipmentItem, CreateShipmentItemBuilder> {
  _$CreateShipmentItem? _$v;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  int? _productModelId;
  int? get productModelId => _$this._productModelId;
  set productModelId(int? productModelId) =>
      _$this._productModelId = productModelId;

  ListBuilder<String>? _serialNumbers;
  ListBuilder<String> get serialNumbers =>
      _$this._serialNumbers ??= ListBuilder<String>();
  set serialNumbers(ListBuilder<String>? serialNumbers) =>
      _$this._serialNumbers = serialNumbers;

  num? _pricePerPiece;
  num? get pricePerPiece => _$this._pricePerPiece;
  set pricePerPiece(num? pricePerPiece) =>
      _$this._pricePerPiece = pricePerPiece;

  CreateShipmentItemBuilder() {
    CreateShipmentItem._defaults(this);
  }

  CreateShipmentItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
      _serialNumbers = $v.serialNumbers.toBuilder();
      _pricePerPiece = $v.pricePerPiece;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateShipmentItem other) {
    _$v = other as _$CreateShipmentItem;
  }

  @override
  void update(void Function(CreateShipmentItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateShipmentItem build() => _build();

  _$CreateShipmentItem _build() {
    _$CreateShipmentItem _$result;
    try {
      _$result =
          _$v ??
          _$CreateShipmentItem._(
            productNameId: BuiltValueNullFieldError.checkNotNull(
              productNameId,
              r'CreateShipmentItem',
              'productNameId',
            ),
            productModelId: BuiltValueNullFieldError.checkNotNull(
              productModelId,
              r'CreateShipmentItem',
              'productModelId',
            ),
            serialNumbers: serialNumbers.build(),
            pricePerPiece: pricePerPiece,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'serialNumbers';
        serialNumbers.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CreateShipmentItem',
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
