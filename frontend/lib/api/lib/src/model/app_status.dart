//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_status.g.dart';

/// AppStatus
///
/// Properties:
/// * [latestVersion] - Expected client app version (semver, e.g. 1.1.3)
/// * [maintenance] - When true, clients must show maintenance screen
/// * [message] - Optional message for update or maintenance UI
/// * [androidUpdateUrl] - Play Store / APK URL for force-update button
@BuiltValue()
abstract class AppStatus implements Built<AppStatus, AppStatusBuilder> {
  /// Expected client app version (semver, e.g. 1.1.3)
  @BuiltValueField(wireName: r'latest_version')
  String? get latestVersion;

  /// When true, clients must show maintenance screen
  @BuiltValueField(wireName: r'maintenance')
  bool? get maintenance;

  /// Optional message for update or maintenance UI
  @BuiltValueField(wireName: r'message')
  String? get message;

  /// Play Store / APK URL for force-update button
  @BuiltValueField(wireName: r'android_update_url')
  String? get androidUpdateUrl;

  AppStatus._();

  factory AppStatus([void updates(AppStatusBuilder b)]) = _$AppStatus;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AppStatusBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AppStatus> get serializer => _$AppStatusSerializer();
}

class _$AppStatusSerializer implements PrimitiveSerializer<AppStatus> {
  @override
  final Iterable<Type> types = const [AppStatus, _$AppStatus];

  @override
  final String wireName = r'AppStatus';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AppStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.latestVersion != null) {
      yield r'latest_version';
      yield serializers.serialize(
        object.latestVersion,
        specifiedType: const FullType(String),
      );
    }
    if (object.maintenance != null) {
      yield r'maintenance';
      yield serializers.serialize(
        object.maintenance,
        specifiedType: const FullType(bool),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.androidUpdateUrl != null) {
      yield r'android_update_url';
      yield serializers.serialize(
        object.androidUpdateUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AppStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AppStatusBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'latest_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.latestVersion = valueDes;
          break;
        case r'maintenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.maintenance = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.message = valueDes;
          break;
        case r'android_update_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.androidUpdateUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AppStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AppStatusBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

