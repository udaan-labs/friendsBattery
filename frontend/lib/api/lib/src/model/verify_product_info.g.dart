// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_product_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VerifyProductInfo extends VerifyProductInfo {
  @override
  final String? name;
  @override
  final String? group;
  @override
  final String? subgroup;
  @override
  final String? model;

  factory _$VerifyProductInfo([
    void Function(VerifyProductInfoBuilder)? updates,
  ]) => (VerifyProductInfoBuilder()..update(updates))._build();

  _$VerifyProductInfo._({this.name, this.group, this.subgroup, this.model})
    : super._();
  @override
  VerifyProductInfo rebuild(void Function(VerifyProductInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerifyProductInfoBuilder toBuilder() =>
      VerifyProductInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyProductInfo &&
        name == other.name &&
        group == other.group &&
        subgroup == other.subgroup &&
        model == other.model;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, group.hashCode);
    _$hash = $jc(_$hash, subgroup.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerifyProductInfo')
          ..add('name', name)
          ..add('group', group)
          ..add('subgroup', subgroup)
          ..add('model', model))
        .toString();
  }
}

class VerifyProductInfoBuilder
    implements Builder<VerifyProductInfo, VerifyProductInfoBuilder> {
  _$VerifyProductInfo? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _group;
  String? get group => _$this._group;
  set group(String? group) => _$this._group = group;

  String? _subgroup;
  String? get subgroup => _$this._subgroup;
  set subgroup(String? subgroup) => _$this._subgroup = subgroup;

  String? _model;
  String? get model => _$this._model;
  set model(String? model) => _$this._model = model;

  VerifyProductInfoBuilder() {
    VerifyProductInfo._defaults(this);
  }

  VerifyProductInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _group = $v.group;
      _subgroup = $v.subgroup;
      _model = $v.model;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyProductInfo other) {
    _$v = other as _$VerifyProductInfo;
  }

  @override
  void update(void Function(VerifyProductInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyProductInfo build() => _build();

  _$VerifyProductInfo _build() {
    final _$result =
        _$v ??
        _$VerifyProductInfo._(
          name: name,
          group: group,
          subgroup: subgroup,
          model: model,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
