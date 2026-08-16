// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_employee_user_id_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NextEmployeeUserIdData extends NextEmployeeUserIdData {
  @override
  final String? userId;

  factory _$NextEmployeeUserIdData([
    void Function(NextEmployeeUserIdDataBuilder)? updates,
  ]) => (NextEmployeeUserIdDataBuilder()..update(updates))._build();

  _$NextEmployeeUserIdData._({this.userId}) : super._();
  @override
  NextEmployeeUserIdData rebuild(
    void Function(NextEmployeeUserIdDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NextEmployeeUserIdDataBuilder toBuilder() =>
      NextEmployeeUserIdDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NextEmployeeUserIdData && userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'NextEmployeeUserIdData',
    )..add('userId', userId)).toString();
  }
}

class NextEmployeeUserIdDataBuilder
    implements Builder<NextEmployeeUserIdData, NextEmployeeUserIdDataBuilder> {
  _$NextEmployeeUserIdData? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  NextEmployeeUserIdDataBuilder() {
    NextEmployeeUserIdData._defaults(this);
  }

  NextEmployeeUserIdDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NextEmployeeUserIdData other) {
    _$v = other as _$NextEmployeeUserIdData;
  }

  @override
  void update(void Function(NextEmployeeUserIdDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NextEmployeeUserIdData build() => _build();

  _$NextEmployeeUserIdData _build() {
    final _$result = _$v ?? _$NextEmployeeUserIdData._(userId: userId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
