// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_transfers_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiTransfersPostRequest extends ApiTransfersPostRequest {
  @override
  final int? sellerId;
  @override
  final BuiltList<ApiTransfersPostRequestItemsInner>? items;

  factory _$ApiTransfersPostRequest([
    void Function(ApiTransfersPostRequestBuilder)? updates,
  ]) => (ApiTransfersPostRequestBuilder()..update(updates))._build();

  _$ApiTransfersPostRequest._({this.sellerId, this.items}) : super._();
  @override
  ApiTransfersPostRequest rebuild(
    void Function(ApiTransfersPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiTransfersPostRequestBuilder toBuilder() =>
      ApiTransfersPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiTransfersPostRequest &&
        sellerId == other.sellerId &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sellerId.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiTransfersPostRequest')
          ..add('sellerId', sellerId)
          ..add('items', items))
        .toString();
  }
}

class ApiTransfersPostRequestBuilder
    implements
        Builder<ApiTransfersPostRequest, ApiTransfersPostRequestBuilder> {
  _$ApiTransfersPostRequest? _$v;

  int? _sellerId;
  int? get sellerId => _$this._sellerId;
  set sellerId(int? sellerId) => _$this._sellerId = sellerId;

  ListBuilder<ApiTransfersPostRequestItemsInner>? _items;
  ListBuilder<ApiTransfersPostRequestItemsInner> get items =>
      _$this._items ??= ListBuilder<ApiTransfersPostRequestItemsInner>();
  set items(ListBuilder<ApiTransfersPostRequestItemsInner>? items) =>
      _$this._items = items;

  ApiTransfersPostRequestBuilder() {
    ApiTransfersPostRequest._defaults(this);
  }

  ApiTransfersPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sellerId = $v.sellerId;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiTransfersPostRequest other) {
    _$v = other as _$ApiTransfersPostRequest;
  }

  @override
  void update(void Function(ApiTransfersPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiTransfersPostRequest build() => _build();

  _$ApiTransfersPostRequest _build() {
    _$ApiTransfersPostRequest _$result;
    try {
      _$result =
          _$v ??
          _$ApiTransfersPostRequest._(
            sellerId: sellerId,
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ApiTransfersPostRequest',
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
