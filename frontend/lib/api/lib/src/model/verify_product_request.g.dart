// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_product_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VerifyProductRequest extends VerifyProductRequest {
  @override
  final String identifier;

  factory _$VerifyProductRequest([
    void Function(VerifyProductRequestBuilder)? updates,
  ]) => (VerifyProductRequestBuilder()..update(updates))._build();

  _$VerifyProductRequest._({required this.identifier}) : super._();
  @override
  VerifyProductRequest rebuild(
    void Function(VerifyProductRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  VerifyProductRequestBuilder toBuilder() =>
      VerifyProductRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyProductRequest && identifier == other.identifier;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, identifier.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'VerifyProductRequest',
    )..add('identifier', identifier)).toString();
  }
}

class VerifyProductRequestBuilder
    implements Builder<VerifyProductRequest, VerifyProductRequestBuilder> {
  _$VerifyProductRequest? _$v;

  String? _identifier;
  String? get identifier => _$this._identifier;
  set identifier(String? identifier) => _$this._identifier = identifier;

  VerifyProductRequestBuilder() {
    VerifyProductRequest._defaults(this);
  }

  VerifyProductRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _identifier = $v.identifier;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyProductRequest other) {
    _$v = other as _$VerifyProductRequest;
  }

  @override
  void update(void Function(VerifyProductRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyProductRequest build() => _build();

  _$VerifyProductRequest _build() {
    final _$result =
        _$v ??
        _$VerifyProductRequest._(
          identifier: BuiltValueNullFieldError.checkNotNull(
            identifier,
            r'VerifyProductRequest',
            'identifier',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
