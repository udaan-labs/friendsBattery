// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_product_name_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateProductNameRequest extends CreateProductNameRequest {
  @override
  final String name;

  factory _$CreateProductNameRequest([
    void Function(CreateProductNameRequestBuilder)? updates,
  ]) => (CreateProductNameRequestBuilder()..update(updates))._build();

  _$CreateProductNameRequest._({required this.name}) : super._();
  @override
  CreateProductNameRequest rebuild(
    void Function(CreateProductNameRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateProductNameRequestBuilder toBuilder() =>
      CreateProductNameRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateProductNameRequest && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'CreateProductNameRequest',
    )..add('name', name)).toString();
  }
}

class CreateProductNameRequestBuilder
    implements
        Builder<CreateProductNameRequest, CreateProductNameRequestBuilder> {
  _$CreateProductNameRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  CreateProductNameRequestBuilder() {
    CreateProductNameRequest._defaults(this);
  }

  CreateProductNameRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateProductNameRequest other) {
    _$v = other as _$CreateProductNameRequest;
  }

  @override
  void update(void Function(CreateProductNameRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateProductNameRequest build() => _build();

  _$CreateProductNameRequest _build() {
    final _$result =
        _$v ??
        _$CreateProductNameRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'CreateProductNameRequest',
            'name',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
