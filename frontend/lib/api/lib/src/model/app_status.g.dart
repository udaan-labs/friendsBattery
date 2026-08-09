// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppStatus extends AppStatus {
  @override
  final String? latestVersion;
  @override
  final bool? maintenance;
  @override
  final String? message;
  @override
  final String? androidUpdateUrl;

  factory _$AppStatus([void Function(AppStatusBuilder)? updates]) =>
      (AppStatusBuilder()..update(updates))._build();

  _$AppStatus._({
    this.latestVersion,
    this.maintenance,
    this.message,
    this.androidUpdateUrl,
  }) : super._();
  @override
  AppStatus rebuild(void Function(AppStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStatusBuilder toBuilder() => AppStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppStatus &&
        latestVersion == other.latestVersion &&
        maintenance == other.maintenance &&
        message == other.message &&
        androidUpdateUrl == other.androidUpdateUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, latestVersion.hashCode);
    _$hash = $jc(_$hash, maintenance.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, androidUpdateUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppStatus')
          ..add('latestVersion', latestVersion)
          ..add('maintenance', maintenance)
          ..add('message', message)
          ..add('androidUpdateUrl', androidUpdateUrl))
        .toString();
  }
}

class AppStatusBuilder implements Builder<AppStatus, AppStatusBuilder> {
  _$AppStatus? _$v;

  String? _latestVersion;
  String? get latestVersion => _$this._latestVersion;
  set latestVersion(String? latestVersion) =>
      _$this._latestVersion = latestVersion;

  bool? _maintenance;
  bool? get maintenance => _$this._maintenance;
  set maintenance(bool? maintenance) => _$this._maintenance = maintenance;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _androidUpdateUrl;
  String? get androidUpdateUrl => _$this._androidUpdateUrl;
  set androidUpdateUrl(String? androidUpdateUrl) =>
      _$this._androidUpdateUrl = androidUpdateUrl;

  AppStatusBuilder() {
    AppStatus._defaults(this);
  }

  AppStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _latestVersion = $v.latestVersion;
      _maintenance = $v.maintenance;
      _message = $v.message;
      _androidUpdateUrl = $v.androidUpdateUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppStatus other) {
    _$v = other as _$AppStatus;
  }

  @override
  void update(void Function(AppStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppStatus build() => _build();

  _$AppStatus _build() {
    final _$result =
        _$v ??
        _$AppStatus._(
          latestVersion: latestVersion,
          maintenance: maintenance,
          message: message,
          androidUpdateUrl: androidUpdateUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
