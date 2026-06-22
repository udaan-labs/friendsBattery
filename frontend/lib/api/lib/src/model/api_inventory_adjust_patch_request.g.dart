// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inventory_adjust_patch_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiInventoryAdjustPatchRequest extends ApiInventoryAdjustPatchRequest {
  @override
  final int productId;
  @override
  final int userId;
  @override
  final int adjustmentQuantity;

  factory _$ApiInventoryAdjustPatchRequest([
    void Function(ApiInventoryAdjustPatchRequestBuilder)? updates,
  ]) => (ApiInventoryAdjustPatchRequestBuilder()..update(updates))._build();

  _$ApiInventoryAdjustPatchRequest._({
    required this.productId,
    required this.userId,
    required this.adjustmentQuantity,
  }) : super._();
  @override
  ApiInventoryAdjustPatchRequest rebuild(
    void Function(ApiInventoryAdjustPatchRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiInventoryAdjustPatchRequestBuilder toBuilder() =>
      ApiInventoryAdjustPatchRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiInventoryAdjustPatchRequest &&
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
    return (newBuiltValueToStringHelper(r'ApiInventoryAdjustPatchRequest')
          ..add('productId', productId)
          ..add('userId', userId)
          ..add('adjustmentQuantity', adjustmentQuantity))
        .toString();
  }
}

class ApiInventoryAdjustPatchRequestBuilder
    implements
        Builder<
          ApiInventoryAdjustPatchRequest,
          ApiInventoryAdjustPatchRequestBuilder
        > {
  _$ApiInventoryAdjustPatchRequest? _$v;

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

  ApiInventoryAdjustPatchRequestBuilder() {
    ApiInventoryAdjustPatchRequest._defaults(this);
  }

  ApiInventoryAdjustPatchRequestBuilder get _$this {
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
  void replace(ApiInventoryAdjustPatchRequest other) {
    _$v = other as _$ApiInventoryAdjustPatchRequest;
  }

  @override
  void update(void Function(ApiInventoryAdjustPatchRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiInventoryAdjustPatchRequest build() => _build();

  _$ApiInventoryAdjustPatchRequest _build() {
    final _$result =
        _$v ??
        _$ApiInventoryAdjustPatchRequest._(
          productId: BuiltValueNullFieldError.checkNotNull(
            productId,
            r'ApiInventoryAdjustPatchRequest',
            'productId',
          ),
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'ApiInventoryAdjustPatchRequest',
            'userId',
          ),
          adjustmentQuantity: BuiltValueNullFieldError.checkNotNull(
            adjustmentQuantity,
            r'ApiInventoryAdjustPatchRequest',
            'adjustmentQuantity',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
