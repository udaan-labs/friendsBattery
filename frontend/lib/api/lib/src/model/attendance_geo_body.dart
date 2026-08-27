//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'attendance_geo_body.g.dart';

/// AttendanceGeoBody
///
/// Properties:
/// * [latitude] - Device GPS latitude (WGS84)
/// * [longitude] - Device GPS longitude (WGS84)
/// * [lat] - Alias for latitude
/// * [lng] - Alias for longitude
/// * [accuracy] - GPS accuracy in meters
/// * [timestamp] - Client capture time (ISO-8601)
/// * [address] 
@BuiltValue()
abstract class AttendanceGeoBody implements Built<AttendanceGeoBody, AttendanceGeoBodyBuilder> {
  /// Device GPS latitude (WGS84)
  @BuiltValueField(wireName: r'latitude')
  num get latitude;

  /// Device GPS longitude (WGS84)
  @BuiltValueField(wireName: r'longitude')
  num get longitude;

  /// Alias for latitude
  @BuiltValueField(wireName: r'lat')
  num? get lat;

  /// Alias for longitude
  @BuiltValueField(wireName: r'lng')
  num? get lng;

  /// GPS accuracy in meters
  @BuiltValueField(wireName: r'accuracy')
  num? get accuracy;

  /// Client capture time (ISO-8601)
  @BuiltValueField(wireName: r'timestamp')
  String? get timestamp;

  @BuiltValueField(wireName: r'address')
  String? get address;

  AttendanceGeoBody._();

  factory AttendanceGeoBody([void updates(AttendanceGeoBodyBuilder b)]) = _$AttendanceGeoBody;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AttendanceGeoBodyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AttendanceGeoBody> get serializer => _$AttendanceGeoBodySerializer();
}

class _$AttendanceGeoBodySerializer implements PrimitiveSerializer<AttendanceGeoBody> {
  @override
  final Iterable<Type> types = const [AttendanceGeoBody, _$AttendanceGeoBody];

  @override
  final String wireName = r'AttendanceGeoBody';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AttendanceGeoBody object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'latitude';
    yield serializers.serialize(
      object.latitude,
      specifiedType: const FullType(num),
    );
    yield r'longitude';
    yield serializers.serialize(
      object.longitude,
      specifiedType: const FullType(num),
    );
    if (object.lat != null) {
      yield r'lat';
      yield serializers.serialize(
        object.lat,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.lng != null) {
      yield r'lng';
      yield serializers.serialize(
        object.lng,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.accuracy != null) {
      yield r'accuracy';
      yield serializers.serialize(
        object.accuracy,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.timestamp != null) {
      yield r'timestamp';
      yield serializers.serialize(
        object.timestamp,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AttendanceGeoBody object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AttendanceGeoBodyBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'latitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.latitude = valueDes;
          break;
        case r'longitude':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.longitude = valueDes;
          break;
        case r'lat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.lat = valueDes;
          break;
        case r'lng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.lng = valueDes;
          break;
        case r'accuracy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.accuracy = valueDes;
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.timestamp = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.address = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AttendanceGeoBody deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AttendanceGeoBodyBuilder();
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

