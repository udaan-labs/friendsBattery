// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_auth_login_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiAuthLoginPostRequest extends ApiAuthLoginPostRequest {
  @override
  final String userId;
  @override
  final String password;

  factory _$ApiAuthLoginPostRequest([
    void Function(ApiAuthLoginPostRequestBuilder)? updates,
  ]) => (ApiAuthLoginPostRequestBuilder()..update(updates))._build();

  _$ApiAuthLoginPostRequest._({required this.userId, required this.password})
    : super._();
  @override
  ApiAuthLoginPostRequest rebuild(
    void Function(ApiAuthLoginPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiAuthLoginPostRequestBuilder toBuilder() =>
      ApiAuthLoginPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiAuthLoginPostRequest &&
        userId == other.userId &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiAuthLoginPostRequest')
          ..add('userId', userId)
          ..add('password', password))
        .toString();
  }
}

class ApiAuthLoginPostRequestBuilder
    implements
        Builder<ApiAuthLoginPostRequest, ApiAuthLoginPostRequestBuilder> {
  _$ApiAuthLoginPostRequest? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  ApiAuthLoginPostRequestBuilder() {
    ApiAuthLoginPostRequest._defaults(this);
  }

  ApiAuthLoginPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiAuthLoginPostRequest other) {
    _$v = other as _$ApiAuthLoginPostRequest;
  }

  @override
  void update(void Function(ApiAuthLoginPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiAuthLoginPostRequest build() => _build();

  _$ApiAuthLoginPostRequest _build() {
    final _$result =
        _$v ??
        _$ApiAuthLoginPostRequest._(
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'ApiAuthLoginPostRequest',
            'userId',
          ),
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'ApiAuthLoginPostRequest',
            'password',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
