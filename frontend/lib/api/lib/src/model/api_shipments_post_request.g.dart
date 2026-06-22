// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_shipments_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiShipmentsPostRequest extends ApiShipmentsPostRequest {
  @override
  final int sellerId;
  @override
  final BuiltList<ApiShipmentsPostRequestItemsInner> items;

  factory _$ApiShipmentsPostRequest([
    void Function(ApiShipmentsPostRequestBuilder)? updates,
  ]) => (ApiShipmentsPostRequestBuilder()..update(updates))._build();

  _$ApiShipmentsPostRequest._({required this.sellerId, required this.items})
    : super._();
  @override
  ApiShipmentsPostRequest rebuild(
    void Function(ApiShipmentsPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiShipmentsPostRequestBuilder toBuilder() =>
      ApiShipmentsPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiShipmentsPostRequest &&
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
    return (newBuiltValueToStringHelper(r'ApiShipmentsPostRequest')
          ..add('sellerId', sellerId)
          ..add('items', items))
        .toString();
  }
}

class ApiShipmentsPostRequestBuilder
    implements
        Builder<ApiShipmentsPostRequest, ApiShipmentsPostRequestBuilder> {
  _$ApiShipmentsPostRequest? _$v;

  int? _sellerId;
  int? get sellerId => _$this._sellerId;
  set sellerId(int? sellerId) => _$this._sellerId = sellerId;

  ListBuilder<ApiShipmentsPostRequestItemsInner>? _items;
  ListBuilder<ApiShipmentsPostRequestItemsInner> get items =>
      _$this._items ??= ListBuilder<ApiShipmentsPostRequestItemsInner>();
  set items(ListBuilder<ApiShipmentsPostRequestItemsInner>? items) =>
      _$this._items = items;

  ApiShipmentsPostRequestBuilder() {
    ApiShipmentsPostRequest._defaults(this);
  }

  ApiShipmentsPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sellerId = $v.sellerId;
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiShipmentsPostRequest other) {
    _$v = other as _$ApiShipmentsPostRequest;
  }

  @override
  void update(void Function(ApiShipmentsPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiShipmentsPostRequest build() => _build();

  _$ApiShipmentsPostRequest _build() {
    _$ApiShipmentsPostRequest _$result;
    try {
      _$result =
          _$v ??
          _$ApiShipmentsPostRequest._(
            sellerId: BuiltValueNullFieldError.checkNotNull(
              sellerId,
              r'ApiShipmentsPostRequest',
              'sellerId',
            ),
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ApiShipmentsPostRequest',
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
