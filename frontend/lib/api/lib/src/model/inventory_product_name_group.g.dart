// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_product_name_group.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InventoryProductNameGroup extends InventoryProductNameGroup {
  @override
  final String? productName;
  @override
  final int? productNameId;
  @override
  final BuiltList<InventoryProductModelOption>? models;

  factory _$InventoryProductNameGroup([
    void Function(InventoryProductNameGroupBuilder)? updates,
  ]) => (InventoryProductNameGroupBuilder()..update(updates))._build();

  _$InventoryProductNameGroup._({
    this.productName,
    this.productNameId,
    this.models,
  }) : super._();
  @override
  InventoryProductNameGroup rebuild(
    void Function(InventoryProductNameGroupBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InventoryProductNameGroupBuilder toBuilder() =>
      InventoryProductNameGroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InventoryProductNameGroup &&
        productName == other.productName &&
        productNameId == other.productNameId &&
        models == other.models;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, productNameId.hashCode);
    _$hash = $jc(_$hash, models.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InventoryProductNameGroup')
          ..add('productName', productName)
          ..add('productNameId', productNameId)
          ..add('models', models))
        .toString();
  }
}

class InventoryProductNameGroupBuilder
    implements
        Builder<InventoryProductNameGroup, InventoryProductNameGroupBuilder> {
  _$InventoryProductNameGroup? _$v;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  int? _productNameId;
  int? get productNameId => _$this._productNameId;
  set productNameId(int? productNameId) =>
      _$this._productNameId = productNameId;

  ListBuilder<InventoryProductModelOption>? _models;
  ListBuilder<InventoryProductModelOption> get models =>
      _$this._models ??= ListBuilder<InventoryProductModelOption>();
  set models(ListBuilder<InventoryProductModelOption>? models) =>
      _$this._models = models;

  InventoryProductNameGroupBuilder() {
    InventoryProductNameGroup._defaults(this);
  }

  InventoryProductNameGroupBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productName = $v.productName;
      _productNameId = $v.productNameId;
      _models = $v.models?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InventoryProductNameGroup other) {
    _$v = other as _$InventoryProductNameGroup;
  }

  @override
  void update(void Function(InventoryProductNameGroupBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InventoryProductNameGroup build() => _build();

  _$InventoryProductNameGroup _build() {
    _$InventoryProductNameGroup _$result;
    try {
      _$result =
          _$v ??
          _$InventoryProductNameGroup._(
            productName: productName,
            productNameId: productNameId,
            models: _models?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'models';
        _models?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'InventoryProductNameGroup',
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
