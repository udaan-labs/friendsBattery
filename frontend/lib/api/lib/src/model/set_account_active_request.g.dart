// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_account_active_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetAccountActiveRequest extends SetAccountActiveRequest {
  @override
  final bool isActive;

  factory _$SetAccountActiveRequest([
    void Function(SetAccountActiveRequestBuilder)? updates,
  ]) => (SetAccountActiveRequestBuilder()..update(updates))._build();

  _$SetAccountActiveRequest._({required this.isActive}) : super._();
  @override
  SetAccountActiveRequest rebuild(
    void Function(SetAccountActiveRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SetAccountActiveRequestBuilder toBuilder() =>
      SetAccountActiveRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetAccountActiveRequest && isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'SetAccountActiveRequest',
    )..add('isActive', isActive)).toString();
  }
}

class SetAccountActiveRequestBuilder
    implements
        Builder<SetAccountActiveRequest, SetAccountActiveRequestBuilder> {
  _$SetAccountActiveRequest? _$v;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  SetAccountActiveRequestBuilder() {
    SetAccountActiveRequest._defaults(this);
  }

  SetAccountActiveRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetAccountActiveRequest other) {
    _$v = other as _$SetAccountActiveRequest;
  }

  @override
  void update(void Function(SetAccountActiveRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetAccountActiveRequest build() => _build();

  _$SetAccountActiveRequest _build() {
    final _$result =
        _$v ??
        _$SetAccountActiveRequest._(
          isActive: BuiltValueNullFieldError.checkNotNull(
            isActive,
            r'SetAccountActiveRequest',
            'isActive',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
