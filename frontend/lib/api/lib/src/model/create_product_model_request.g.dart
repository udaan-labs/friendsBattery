// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_product_model_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateProductModelRequest extends CreateProductModelRequest {
  @override
  final int productNameId;
  @override
  final String name;

  factory _$CreateProductModelRequest([
    void Function(CreateProductModelRequestBuilder)? updates,
  ]) => (CreateProductModelRequestBuilder()..update(updates))._build();

  _$CreateProductModelRequest._({
    required this.productNameId,
    required this.name,
  }) : super._();
  @override
  CreateProductModelRequest rebuild(
    void Function(CreateProductModelRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateProductModelRequestBuilder toBuilder() =>
      CreateProductModelRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateProductModelRequest &&
        productNameId == other.productNameId &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateProductModelRequest')
          ..add('productNameId', productNameId)
          ..add('name', name))
        .toString();
  }
}

class CreateProductModelRequestBuilder
    implements
        Builder<CreateProductModelRequest, CreateProductModelRequestBuilder> {
  _$CreateProductModelRequest? _$v;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  CreateProductModelRequestBuilder() {
    CreateProductModelRequest._defaults(this);
  }

  CreateProductModelRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productNameId = $v.productNameId;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateProductModelRequest other) {
    _$v = other as _$CreateProductModelRequest;
  }

  @override
  void update(void Function(CreateProductModelRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateProductModelRequest build() => _build();

  _$CreateProductModelRequest _build() {
    final _$result =
        _$v ??
        _$CreateProductModelRequest._(
          productNameId: BuiltValueNullFieldError.checkNotNull(
            productNameId,
            r'CreateProductModelRequest',
            'productNameId',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'CreateProductModelRequest',
            'name',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
