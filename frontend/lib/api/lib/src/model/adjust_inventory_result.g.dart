// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adjust_inventory_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdjustInventoryResult extends AdjustInventoryResult {
  @override
  final bool? adjusted;
  @override
  final int? adjustmentQuantity;

  factory _$AdjustInventoryResult([
    void Function(AdjustInventoryResultBuilder)? updates,
  ]) => (AdjustInventoryResultBuilder()..update(updates))._build();

  _$AdjustInventoryResult._({this.adjusted, this.adjustmentQuantity})
    : super._();
  @override
  AdjustInventoryResult rebuild(
    void Function(AdjustInventoryResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdjustInventoryResultBuilder toBuilder() =>
      AdjustInventoryResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdjustInventoryResult &&
        adjusted == other.adjusted &&
        adjustmentQuantity == other.adjustmentQuantity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, adjusted.hashCode);
    _$hash = $jc(_$hash, adjustmentQuantity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdjustInventoryResult')
          ..add('adjusted', adjusted)
          ..add('adjustmentQuantity', adjustmentQuantity))
        .toString();
  }
}

class AdjustInventoryResultBuilder
    implements Builder<AdjustInventoryResult, AdjustInventoryResultBuilder> {
  _$AdjustInventoryResult? _$v;

  bool? _adjusted;
  bool? get adjusted => _$this._adjusted;
  set adjusted(bool? adjusted) => _$this._adjusted = adjusted;

  int? _adjustmentQuantity;
  int? get adjustmentQuantity => _$this._adjustmentQuantity;
  set adjustmentQuantity(int? adjustmentQuantity) =>
      _$this._adjustmentQuantity = adjustmentQuantity;

  AdjustInventoryResultBuilder() {
    AdjustInventoryResult._defaults(this);
  }

  AdjustInventoryResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _adjusted = $v.adjusted;
      _adjustmentQuantity = $v.adjustmentQuantity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdjustInventoryResult other) {
    _$v = other as _$AdjustInventoryResult;
  }

  @override
  void update(void Function(AdjustInventoryResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdjustInventoryResult build() => _build();

  _$AdjustInventoryResult _build() {
    final _$result =
        _$v ??
        _$AdjustInventoryResult._(
          adjusted: adjusted,
          adjustmentQuantity: adjustmentQuantity,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
