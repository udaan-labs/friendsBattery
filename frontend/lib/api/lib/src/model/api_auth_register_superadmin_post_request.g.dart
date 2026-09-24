// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_auth_register_superadmin_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiAuthRegisterSuperadminPostRequest
    extends ApiAuthRegisterSuperadminPostRequest {
  @override
  final String userId;
  @override
  final String username;
  @override
  final String userNumber;
  @override
  final String? shopName;
  @override
  final String password;

  factory _$ApiAuthRegisterSuperadminPostRequest([
    void Function(ApiAuthRegisterSuperadminPostRequestBuilder)? updates,
  ]) =>
      (ApiAuthRegisterSuperadminPostRequestBuilder()..update(updates))._build();

  _$ApiAuthRegisterSuperadminPostRequest._({
    required this.userId,
    required this.username,
    required this.userNumber,
    this.shopName,
    required this.password,
  }) : super._();
  @override
  ApiAuthRegisterSuperadminPostRequest rebuild(
    void Function(ApiAuthRegisterSuperadminPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApiAuthRegisterSuperadminPostRequestBuilder toBuilder() =>
      ApiAuthRegisterSuperadminPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiAuthRegisterSuperadminPostRequest &&
        userId == other.userId &&
        username == other.username &&
        userNumber == other.userNumber &&
        shopName == other.shopName &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, userNumber.hashCode);
    _$hash = $jc(_$hash, shopName.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiAuthRegisterSuperadminPostRequest')
          ..add('userId', userId)
          ..add('username', username)
          ..add('userNumber', userNumber)
          ..add('shopName', shopName)
          ..add('password', password))
        .toString();
  }
}

class ApiAuthRegisterSuperadminPostRequestBuilder
    implements
        Builder<
          ApiAuthRegisterSuperadminPostRequest,
          ApiAuthRegisterSuperadminPostRequestBuilder
        > {
  _$ApiAuthRegisterSuperadminPostRequest? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _userNumber;
  String? get userNumber => _$this._userNumber;
  set userNumber(String? userNumber) => _$this._userNumber = userNumber;

  String? _shopName;
  String? get shopName => _$this._shopName;
  set shopName(String? shopName) => _$this._shopName = shopName;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  ApiAuthRegisterSuperadminPostRequestBuilder() {
    ApiAuthRegisterSuperadminPostRequest._defaults(this);
  }

  ApiAuthRegisterSuperadminPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _username = $v.username;
      _userNumber = $v.userNumber;
      _shopName = $v.shopName;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiAuthRegisterSuperadminPostRequest other) {
    _$v = other as _$ApiAuthRegisterSuperadminPostRequest;
  }

  @override
  void update(
    void Function(ApiAuthRegisterSuperadminPostRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ApiAuthRegisterSuperadminPostRequest build() => _build();

  _$ApiAuthRegisterSuperadminPostRequest _build() {
    final _$result =
        _$v ??
        _$ApiAuthRegisterSuperadminPostRequest._(
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'ApiAuthRegisterSuperadminPostRequest',
            'userId',
          ),
          username: BuiltValueNullFieldError.checkNotNull(
            username,
            r'ApiAuthRegisterSuperadminPostRequest',
            'username',
          ),
          userNumber: BuiltValueNullFieldError.checkNotNull(
            userNumber,
            r'ApiAuthRegisterSuperadminPostRequest',
            'userNumber',
          ),
          shopName: shopName,
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'ApiAuthRegisterSuperadminPostRequest',
            'password',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
