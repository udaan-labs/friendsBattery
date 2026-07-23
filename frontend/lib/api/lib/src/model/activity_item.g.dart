// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ActivityItem extends ActivityItem {
  @override
  final String? title;
  @override
  final String? subtitle;
  @override
  final DateTime? time;
  @override
  final String? icon;

  factory _$ActivityItem([void Function(ActivityItemBuilder)? updates]) =>
      (ActivityItemBuilder()..update(updates))._build();

  _$ActivityItem._({this.title, this.subtitle, this.time, this.icon})
    : super._();
  @override
  ActivityItem rebuild(void Function(ActivityItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActivityItemBuilder toBuilder() => ActivityItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActivityItem &&
        title == other.title &&
        subtitle == other.subtitle &&
        time == other.time &&
        icon == other.icon;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, subtitle.hashCode);
    _$hash = $jc(_$hash, time.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ActivityItem')
          ..add('title', title)
          ..add('subtitle', subtitle)
          ..add('time', time)
          ..add('icon', icon))
        .toString();
  }
}

class ActivityItemBuilder
    implements Builder<ActivityItem, ActivityItemBuilder> {
  _$ActivityItem? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _subtitle;
  String? get subtitle => _$this._subtitle;
  set subtitle(String? subtitle) => _$this._subtitle = subtitle;

  DateTime? _time;
  DateTime? get time => _$this._time;
  set time(DateTime? time) => _$this._time = time;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  ActivityItemBuilder() {
    ActivityItem._defaults(this);
  }

  ActivityItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _subtitle = $v.subtitle;
      _time = $v.time;
      _icon = $v.icon;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActivityItem other) {
    _$v = other as _$ActivityItem;
  }

  @override
  void update(void Function(ActivityItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ActivityItem build() => _build();

  _$ActivityItem _build() {
    final _$result =
        _$v ??
        _$ActivityItem._(
          title: title,
          subtitle: subtitle,
          time: time,
          icon: icon,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
