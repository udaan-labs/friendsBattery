// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_products_categories_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiProductsCategoriesPostRequest
    extends ApiProductsCategoriesPostRequest {
  @override
  final String? name;

  factory _$ApiProductsCategoriesPostRequest([
    void Function(ApiProductsCategoriesPostRequestBuilder)? updates,
  ]) => (ApiProductsCategoriesPostRequestBuilder()..update(updates))._build();

  _$ApiProductsCategoriesPostRequest._({this.name}) : super._();
  @override
  ApiProductsCategoriesPostRequest rebuild(
    void Function(ApiProductsCategoriesPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiProductsCategoriesPostRequestBuilder toBuilder() =>
      ApiProductsCategoriesPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiProductsCategoriesPostRequest && name == other.name;
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
      r'ApiProductsCategoriesPostRequest',
    )..add('name', name)).toString();
  }
}

class ApiProductsCategoriesPostRequestBuilder
    implements
        Builder<
          ApiProductsCategoriesPostRequest,
          ApiProductsCategoriesPostRequestBuilder
        > {
  _$ApiProductsCategoriesPostRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ApiProductsCategoriesPostRequestBuilder() {
    ApiProductsCategoriesPostRequest._defaults(this);
  }

  ApiProductsCategoriesPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiProductsCategoriesPostRequest other) {
    _$v = other as _$ApiProductsCategoriesPostRequest;
  }

  @override
  void update(void Function(ApiProductsCategoriesPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiProductsCategoriesPostRequest build() => _build();

  _$ApiProductsCategoriesPostRequest _build() {
    final _$result = _$v ?? _$ApiProductsCategoriesPostRequest._(name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
