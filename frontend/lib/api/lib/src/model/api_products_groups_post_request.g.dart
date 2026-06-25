// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_products_groups_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiProductsGroupsPostRequest extends ApiProductsGroupsPostRequest {
  @override
  final String? name;

  factory _$ApiProductsGroupsPostRequest([
    void Function(ApiProductsGroupsPostRequestBuilder)? updates,
  ]) => (ApiProductsGroupsPostRequestBuilder()..update(updates))._build();

  _$ApiProductsGroupsPostRequest._({this.name}) : super._();
  @override
  ApiProductsGroupsPostRequest rebuild(
    void Function(ApiProductsGroupsPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiProductsGroupsPostRequestBuilder toBuilder() =>
      ApiProductsGroupsPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiProductsGroupsPostRequest && name == other.name;
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
      r'ApiProductsGroupsPostRequest',
    )..add('name', name)).toString();
  }
}

class ApiProductsGroupsPostRequestBuilder
    implements
        Builder<
          ApiProductsGroupsPostRequest,
          ApiProductsGroupsPostRequestBuilder
        > {
  _$ApiProductsGroupsPostRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ApiProductsGroupsPostRequestBuilder() {
    ApiProductsGroupsPostRequest._defaults(this);
  }

  ApiProductsGroupsPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiProductsGroupsPostRequest other) {
    _$v = other as _$ApiProductsGroupsPostRequest;
  }

  @override
  void update(void Function(ApiProductsGroupsPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiProductsGroupsPostRequest build() => _build();

  _$ApiProductsGroupsPostRequest _build() {
    final _$result = _$v ?? _$ApiProductsGroupsPostRequest._(name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
