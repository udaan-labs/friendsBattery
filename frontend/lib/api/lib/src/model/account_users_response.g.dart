// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_users_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountUsersResponse extends AccountUsersResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final BuiltList<AccountUser>? data;

  factory _$AccountUsersResponse([
    void Function(AccountUsersResponseBuilder)? updates,
  ]) => (AccountUsersResponseBuilder()..update(updates))._build();

  _$AccountUsersResponse._({this.success, this.message, this.data}) : super._();
  @override
  AccountUsersResponse rebuild(
    void Function(AccountUsersResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountUsersResponseBuilder toBuilder() =>
      AccountUsersResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountUsersResponse &&
        success == other.success &&
        message == other.message &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountUsersResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class AccountUsersResponseBuilder
    implements Builder<AccountUsersResponse, AccountUsersResponseBuilder> {
  _$AccountUsersResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<AccountUser>? _data;
  ListBuilder<AccountUser> get data =>
      _$this._data ??= ListBuilder<AccountUser>();
  set data(ListBuilder<AccountUser>? data) => _$this._data = data;

  AccountUsersResponseBuilder() {
    AccountUsersResponse._defaults(this);
  }

  AccountUsersResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _message = $v.message;
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountUsersResponse other) {
    _$v = other as _$AccountUsersResponse;
  }

  @override
  void update(void Function(AccountUsersResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountUsersResponse build() => _build();

  _$AccountUsersResponse _build() {
    _$AccountUsersResponse _$result;
    try {
      _$result =
          _$v ??
          _$AccountUsersResponse._(
            success: success,
            message: message,
            data: _data?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountUsersResponse',
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
