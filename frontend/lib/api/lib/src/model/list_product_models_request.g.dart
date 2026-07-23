// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_product_models_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListProductModelsRequest extends ListProductModelsRequest {
  @override
  final int productNameId;

  factory _$ListProductModelsRequest([
    void Function(ListProductModelsRequestBuilder)? updates,
  ]) => (ListProductModelsRequestBuilder()..update(updates))._build();

  _$ListProductModelsRequest._({required this.productNameId}) : super._();
  @override
  ListProductModelsRequest rebuild(
    void Function(ListProductModelsRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ListProductModelsRequestBuilder toBuilder() =>
      ListProductModelsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListProductModelsRequest &&
        productNameId == other.productNameId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ListProductModelsRequest',
    )..add('productNameId', productNameId)).toString();
  }
}

class ListProductModelsRequestBuilder
    implements
        Builder<ListProductModelsRequest, ListProductModelsRequestBuilder> {
  _$ListProductModelsRequest? _$v;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  ListProductModelsRequestBuilder() {
    ListProductModelsRequest._defaults(this);
  }

  ListProductModelsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productNameId = $v.productNameId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListProductModelsRequest other) {
    _$v = other as _$ListProductModelsRequest;
  }

  @override
  void update(void Function(ListProductModelsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListProductModelsRequest build() => _build();

  _$ListProductModelsRequest _build() {
    final _$result =
        _$v ??
        _$ListProductModelsRequest._(
          productNameId: BuiltValueNullFieldError.checkNotNull(
            productNameId,
            r'ListProductModelsRequest',
            'productNameId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
