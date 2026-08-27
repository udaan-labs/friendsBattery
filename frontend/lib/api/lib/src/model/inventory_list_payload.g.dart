// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_list_payload.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InventoryListPayload extends InventoryListPayload {
  @override
  final BuiltList<InventoryListItem>? data;
  @override
  final InventoryPagination? pagination;

  factory _$InventoryListPayload([
    void Function(InventoryListPayloadBuilder)? updates,
  ]) => (InventoryListPayloadBuilder()..update(updates))._build();

  _$InventoryListPayload._({this.data, this.pagination}) : super._();
  @override
  InventoryListPayload rebuild(
    void Function(InventoryListPayloadBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InventoryListPayloadBuilder toBuilder() =>
      InventoryListPayloadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InventoryListPayload &&
        data == other.data &&
        pagination == other.pagination;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, pagination.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InventoryListPayload')
          ..add('data', data)
          ..add('pagination', pagination))
        .toString();
  }
}

class InventoryListPayloadBuilder
    implements Builder<InventoryListPayload, InventoryListPayloadBuilder> {
  _$InventoryListPayload? _$v;

  ListBuilder<InventoryListItem>? _data;
  ListBuilder<InventoryListItem> get data =>
      _$this._data ??= ListBuilder<InventoryListItem>();
  set data(ListBuilder<InventoryListItem>? data) => _$this._data = data;

  InventoryPaginationBuilder? _pagination;
  InventoryPaginationBuilder get pagination =>
      _$this._pagination ??= InventoryPaginationBuilder();
  set pagination(InventoryPaginationBuilder? pagination) =>
      _$this._pagination = pagination;

  InventoryListPayloadBuilder() {
    InventoryListPayload._defaults(this);
  }

  InventoryListPayloadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _pagination = $v.pagination?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InventoryListPayload other) {
    _$v = other as _$InventoryListPayload;
  }

  @override
  void update(void Function(InventoryListPayloadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InventoryListPayload build() => _build();

  _$InventoryListPayload _build() {
    _$InventoryListPayload _$result;
    try {
      _$result =
          _$v ??
          _$InventoryListPayload._(
            data: _data?.build(),
            pagination: _pagination?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
        _$failedField = 'pagination';
        _pagination?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'InventoryListPayload',
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
