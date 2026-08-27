// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginData extends LoginData {
  @override
  final String? authId;
  @override
  final String? authKey;
  @override
  final int? sessionId;
  @override
  final LoginUser? user;

  factory _$LoginData([void Function(LoginDataBuilder)? updates]) =>
      (LoginDataBuilder()..update(updates))._build();

  _$LoginData._({this.authId, this.authKey, this.sessionId, this.user})
    : super._();
  @override
  LoginData rebuild(void Function(LoginDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginDataBuilder toBuilder() => LoginDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginData &&
        authId == other.authId &&
        authKey == other.authKey &&
        sessionId == other.sessionId &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, authId.hashCode);
    _$hash = $jc(_$hash, authKey.hashCode);
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginData')
          ..add('authId', authId)
          ..add('authKey', authKey)
          ..add('sessionId', sessionId)
          ..add('user', user))
        .toString();
  }
}

class LoginDataBuilder implements Builder<LoginData, LoginDataBuilder> {
  _$LoginData? _$v;

  String? _authId;
  String? get authId => _$this._authId;
  set authId(String? authId) => _$this._authId = authId;

  String? _authKey;
  String? get authKey => _$this._authKey;
  set authKey(String? authKey) => _$this._authKey = authKey;

  int? _sessionId;
  int? get sessionId => _$this._sessionId;
  set sessionId(int? sessionId) => _$this._sessionId = sessionId;

  LoginUserBuilder? _user;
  LoginUserBuilder get user => _$this._user ??= LoginUserBuilder();
  set user(LoginUserBuilder? user) => _$this._user = user;

  LoginDataBuilder() {
    LoginData._defaults(this);
  }

  LoginDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _authId = $v.authId;
      _authKey = $v.authKey;
      _sessionId = $v.sessionId;
      _user = $v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginData other) {
    _$v = other as _$LoginData;
  }

  @override
  void update(void Function(LoginDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginData build() => _build();

  _$LoginData _build() {
    _$LoginData _$result;
    try {
      _$result =
          _$v ??
          _$LoginData._(
            authId: authId,
            authKey: authKey,
            sessionId: sessionId,
            user: _user?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LoginData',
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
