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
  @override
  final String? deviceId;
  @override
  final String? ipAddress;
  @override
  final String? appVersion;
  @override
  final String? firebaseToken;

  factory _$ApiAuthLoginPostRequest([
    void Function(ApiAuthLoginPostRequestBuilder)? updates,
  ]) => (ApiAuthLoginPostRequestBuilder()..update(updates))._build();

  _$ApiAuthLoginPostRequest._({
    required this.userId,
    required this.password,
    this.deviceId,
    this.ipAddress,
    this.appVersion,
    this.firebaseToken,
  }) : super._();
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
        password == other.password &&
        deviceId == other.deviceId &&
        ipAddress == other.ipAddress &&
        appVersion == other.appVersion &&
        firebaseToken == other.firebaseToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jc(_$hash, ipAddress.hashCode);
    _$hash = $jc(_$hash, appVersion.hashCode);
    _$hash = $jc(_$hash, firebaseToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiAuthLoginPostRequest')
          ..add('userId', userId)
          ..add('password', password)
          ..add('deviceId', deviceId)
          ..add('ipAddress', ipAddress)
          ..add('appVersion', appVersion)
          ..add('firebaseToken', firebaseToken))
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

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  String? _ipAddress;
  String? get ipAddress => _$this._ipAddress;
  set ipAddress(String? ipAddress) => _$this._ipAddress = ipAddress;

  String? _appVersion;
  String? get appVersion => _$this._appVersion;
  set appVersion(String? appVersion) => _$this._appVersion = appVersion;

  String? _firebaseToken;
  String? get firebaseToken => _$this._firebaseToken;
  set firebaseToken(String? firebaseToken) =>
      _$this._firebaseToken = firebaseToken;

  ApiAuthLoginPostRequestBuilder() {
    ApiAuthLoginPostRequest._defaults(this);
  }

  ApiAuthLoginPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _password = $v.password;
      _deviceId = $v.deviceId;
      _ipAddress = $v.ipAddress;
      _appVersion = $v.appVersion;
      _firebaseToken = $v.firebaseToken;
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
          deviceId: deviceId,
          ipAddress: ipAddress,
          appVersion: appVersion,
          firebaseToken: firebaseToken,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
