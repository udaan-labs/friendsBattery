// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_employee_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminEmployeeDetailResponse extends AdminEmployeeDetailResponse {
  @override
  final bool? success;
  @override
  final String? message;
  @override
  final AdminEmployeeDetailData? data;

  factory _$AdminEmployeeDetailResponse([
    void Function(AdminEmployeeDetailResponseBuilder)? updates,
  ]) => (AdminEmployeeDetailResponseBuilder()..update(updates))._build();

  _$AdminEmployeeDetailResponse._({this.success, this.message, this.data})
    : super._();
  @override
  AdminEmployeeDetailResponse rebuild(
    void Function(AdminEmployeeDetailResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminEmployeeDetailResponseBuilder toBuilder() =>
      AdminEmployeeDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminEmployeeDetailResponse &&
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
    return (newBuiltValueToStringHelper(r'AdminEmployeeDetailResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class AdminEmployeeDetailResponseBuilder
    implements
        Builder<
          AdminEmployeeDetailResponse,
          AdminEmployeeDetailResponseBuilder
        > {
  _$AdminEmployeeDetailResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AdminEmployeeDetailDataBuilder? _data;
  AdminEmployeeDetailDataBuilder get data =>
      _$this._data ??= AdminEmployeeDetailDataBuilder();
  set data(AdminEmployeeDetailDataBuilder? data) => _$this._data = data;

  AdminEmployeeDetailResponseBuilder() {
    AdminEmployeeDetailResponse._defaults(this);
  }

  AdminEmployeeDetailResponseBuilder get _$this {
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
  void replace(AdminEmployeeDetailResponse other) {
    _$v = other as _$AdminEmployeeDetailResponse;
  }

  @override
  void update(void Function(AdminEmployeeDetailResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminEmployeeDetailResponse build() => _build();

  _$AdminEmployeeDetailResponse _build() {
    _$AdminEmployeeDetailResponse _$result;
    try {
      _$result =
          _$v ??
          _$AdminEmployeeDetailResponse._(
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
          r'AdminEmployeeDetailResponse',
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
