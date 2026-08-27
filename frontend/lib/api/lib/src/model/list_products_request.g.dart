// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_products_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListProductsRequest extends ListProductsRequest {
  @override
  final int productNameId;
  @override
  final int productModelId;

  factory _$ListProductsRequest([
    void Function(ListProductsRequestBuilder)? updates,
  ]) => (ListProductsRequestBuilder()..update(updates))._build();

  _$ListProductsRequest._({
    required this.productNameId,
    required this.productModelId,
  }) : super._();
  @override
  ListProductsRequest rebuild(
    void Function(ListProductsRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ListProductsRequestBuilder toBuilder() =>
      ListProductsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListProductsRequest &&
        productNameId == other.productNameId &&
        productModelId == other.productModelId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, productModelId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ListProductsRequest')
          ..add('productNameId', productNameId)
          ..add('productModelId', productModelId))
        .toString();
  }
}

class ListProductsRequestBuilder
    implements Builder<ListProductsRequest, ListProductsRequestBuilder> {
  _$ListProductsRequest? _$v;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  int? _productModelId;
  int? get productModelId => _$this._productModelId;
  set productModelId(int? productModelId) =>
      _$this._productModelId = productModelId;

  ListProductsRequestBuilder() {
    ListProductsRequest._defaults(this);
  }

  ListProductsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productNameId = $v.productNameId;
      _productModelId = $v.productModelId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListProductsRequest other) {
    _$v = other as _$ListProductsRequest;
  }

  @override
  void update(void Function(ListProductsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListProductsRequest build() => _build();

  _$ListProductsRequest _build() {
    final _$result =
        _$v ??
        _$ListProductsRequest._(
          productNameId: BuiltValueNullFieldError.checkNotNull(
            productNameId,
            r'ListProductsRequest',
            'productNameId',
          ),
          productModelId: BuiltValueNullFieldError.checkNotNull(
            productModelId,
            r'ListProductsRequest',
            'productModelId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
