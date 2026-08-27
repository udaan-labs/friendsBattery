// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_product_payload.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VerifyProductPayload extends VerifyProductPayload {
  @override
  final VerifyProductUnit? productUnit;
  @override
  final VerifyProductInfo? product;

  factory _$VerifyProductPayload([
    void Function(VerifyProductPayloadBuilder)? updates,
  ]) => (VerifyProductPayloadBuilder()..update(updates))._build();

  _$VerifyProductPayload._({this.productUnit, this.product}) : super._();
  @override
  VerifyProductPayload rebuild(
    void Function(VerifyProductPayloadBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  VerifyProductPayloadBuilder toBuilder() =>
      VerifyProductPayloadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyProductPayload &&
        productUnit == other.productUnit &&
        product == other.product;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productUnit.hashCode);
    _$hash = $jc(_$hash, product.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerifyProductPayload')
          ..add('productUnit', productUnit)
          ..add('product', product))
        .toString();
  }
}

class VerifyProductPayloadBuilder
    implements Builder<VerifyProductPayload, VerifyProductPayloadBuilder> {
  _$VerifyProductPayload? _$v;

  VerifyProductUnitBuilder? _productUnit;
  VerifyProductUnitBuilder get productUnit =>
      _$this._productUnit ??= VerifyProductUnitBuilder();
  set productUnit(VerifyProductUnitBuilder? productUnit) =>
      _$this._productUnit = productUnit;

  VerifyProductInfoBuilder? _product;
  VerifyProductInfoBuilder get product =>
      _$this._product ??= VerifyProductInfoBuilder();
  set product(VerifyProductInfoBuilder? product) => _$this._product = product;

  VerifyProductPayloadBuilder() {
    VerifyProductPayload._defaults(this);
  }

  VerifyProductPayloadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productUnit = $v.productUnit?.toBuilder();
      _product = $v.product?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyProductPayload other) {
    _$v = other as _$VerifyProductPayload;
  }

  @override
  void update(void Function(VerifyProductPayloadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyProductPayload build() => _build();

  _$VerifyProductPayload _build() {
    _$VerifyProductPayload _$result;
    try {
      _$result =
          _$v ??
          _$VerifyProductPayload._(
            productUnit: _productUnit?.build(),
            product: _product?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'productUnit';
        _productUnit?.build();
        _$failedField = 'product';
        _product?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'VerifyProductPayload',
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
