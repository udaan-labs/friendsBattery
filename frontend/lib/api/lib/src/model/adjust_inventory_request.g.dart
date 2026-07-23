// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adjust_inventory_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdjustInventoryRequest extends AdjustInventoryRequest {
  @override
  final int productId;
  @override
  final int userId;
  @override
  final int adjustmentQuantity;

  factory _$AdjustInventoryRequest([
    void Function(AdjustInventoryRequestBuilder)? updates,
  ]) => (AdjustInventoryRequestBuilder()..update(updates))._build();

  _$AdjustInventoryRequest._({
    required this.productId,
    required this.userId,
    required this.adjustmentQuantity,
  }) : super._();
  @override
  AdjustInventoryRequest rebuild(
    void Function(AdjustInventoryRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdjustInventoryRequestBuilder toBuilder() =>
      AdjustInventoryRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdjustInventoryRequest &&
        productId == other.productId &&
        userId == other.userId &&
        adjustmentQuantity == other.adjustmentQuantity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, adjustmentQuantity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdjustInventoryRequest')
          ..add('productId', productId)
          ..add('userId', userId)
          ..add('adjustmentQuantity', adjustmentQuantity))
        .toString();
  }
}

class AdjustInventoryRequestBuilder
    implements Builder<AdjustInventoryRequest, AdjustInventoryRequestBuilder> {
  _$AdjustInventoryRequest? _$v;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _adjustmentQuantity;
  int? get adjustmentQuantity => _$this._adjustmentQuantity;
  set adjustmentQuantity(int? adjustmentQuantity) =>
      _$this._adjustmentQuantity = adjustmentQuantity;

  AdjustInventoryRequestBuilder() {
    AdjustInventoryRequest._defaults(this);
  }

  AdjustInventoryRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _userId = $v.userId;
      _adjustmentQuantity = $v.adjustmentQuantity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdjustInventoryRequest other) {
    _$v = other as _$AdjustInventoryRequest;
  }

  @override
  void update(void Function(AdjustInventoryRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdjustInventoryRequest build() => _build();

  _$AdjustInventoryRequest _build() {
    final _$result =
        _$v ??
        _$AdjustInventoryRequest._(
          productId: BuiltValueNullFieldError.checkNotNull(
            productId,
            r'AdjustInventoryRequest',
            'productId',
          ),
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'AdjustInventoryRequest',
            'userId',
          ),
          adjustmentQuantity: BuiltValueNullFieldError.checkNotNull(
            adjustmentQuantity,
            r'AdjustInventoryRequest',
            'adjustmentQuantity',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
