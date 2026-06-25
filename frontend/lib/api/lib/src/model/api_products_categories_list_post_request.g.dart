// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_products_categories_list_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiProductsCategoriesListPostRequest
    extends ApiProductsCategoriesListPostRequest {
  @override
  final int? groupId;

  factory _$ApiProductsCategoriesListPostRequest([
    void Function(ApiProductsCategoriesListPostRequestBuilder)? updates,
  ]) =>
      (ApiProductsCategoriesListPostRequestBuilder()..update(updates))._build();

  _$ApiProductsCategoriesListPostRequest._({this.groupId}) : super._();
  @override
  ApiProductsCategoriesListPostRequest rebuild(
    void Function(ApiProductsCategoriesListPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiProductsCategoriesListPostRequestBuilder toBuilder() =>
      ApiProductsCategoriesListPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiProductsCategoriesListPostRequest &&
        groupId == other.groupId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, groupId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ApiProductsCategoriesListPostRequest',
    )..add('groupId', groupId)).toString();
  }
}

class ApiProductsCategoriesListPostRequestBuilder
    implements
        Builder<
          ApiProductsCategoriesListPostRequest,
          ApiProductsCategoriesListPostRequestBuilder
        > {
  _$ApiProductsCategoriesListPostRequest? _$v;

  int? _groupId;
  int? get groupId => _$this._groupId;
  set groupId(int? groupId) => _$this._groupId = groupId;

  ApiProductsCategoriesListPostRequestBuilder() {
    ApiProductsCategoriesListPostRequest._defaults(this);
  }

  ApiProductsCategoriesListPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _groupId = $v.groupId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiProductsCategoriesListPostRequest other) {
    _$v = other as _$ApiProductsCategoriesListPostRequest;
  }

  @override
  void update(
    void Function(ApiProductsCategoriesListPostRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiProductsCategoriesListPostRequest build() => _build();

  _$ApiProductsCategoriesListPostRequest _build() {
    final _$result =
        _$v ?? _$ApiProductsCategoriesListPostRequest._(groupId: groupId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
