// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_auth_activate_put_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiAuthActivatePutRequest extends ApiAuthActivatePutRequest {
  @override
  final String userId;
  @override
  final bool isActive;
  @override
  final bool isVerified;

  factory _$ApiAuthActivatePutRequest([
    void Function(ApiAuthActivatePutRequestBuilder)? updates,
  ]) => (ApiAuthActivatePutRequestBuilder()..update(updates))._build();

  _$ApiAuthActivatePutRequest._({
    required this.userId,
    required this.isActive,
    required this.isVerified,
  }) : super._();
  @override
  ApiAuthActivatePutRequest rebuild(
    void Function(ApiAuthActivatePutRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiAuthActivatePutRequestBuilder toBuilder() =>
      ApiAuthActivatePutRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiAuthActivatePutRequest &&
        userId == other.userId &&
        isActive == other.isActive &&
        isVerified == other.isVerified;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, isVerified.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiAuthActivatePutRequest')
          ..add('userId', userId)
          ..add('isActive', isActive)
          ..add('isVerified', isVerified))
        .toString();
  }
}

class ApiAuthActivatePutRequestBuilder
    implements
        Builder<ApiAuthActivatePutRequest, ApiAuthActivatePutRequestBuilder> {
  _$ApiAuthActivatePutRequest? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  bool? _isVerified;
  bool? get isVerified => _$this._isVerified;
  set isVerified(bool? isVerified) => _$this._isVerified = isVerified;

  ApiAuthActivatePutRequestBuilder() {
    ApiAuthActivatePutRequest._defaults(this);
  }

  ApiAuthActivatePutRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _isActive = $v.isActive;
      _isVerified = $v.isVerified;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiAuthActivatePutRequest other) {
    _$v = other as _$ApiAuthActivatePutRequest;
  }

  @override
  void update(void Function(ApiAuthActivatePutRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiAuthActivatePutRequest build() => _build();

  _$ApiAuthActivatePutRequest _build() {
    final _$result =
        _$v ??
        _$ApiAuthActivatePutRequest._(
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'ApiAuthActivatePutRequest',
            'userId',
          ),
          isActive: BuiltValueNullFieldError.checkNotNull(
            isActive,
            r'ApiAuthActivatePutRequest',
            'isActive',
          ),
          isVerified: BuiltValueNullFieldError.checkNotNull(
            isVerified,
            r'ApiAuthActivatePutRequest',
            'isVerified',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
