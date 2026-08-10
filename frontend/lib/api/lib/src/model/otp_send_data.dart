//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'otp_send_data.g.dart';

/// OtpSendData
///
/// Properties:
/// * [challengeId] 
/// * [expiresIn] 
/// * [otp] 
@BuiltValue()
abstract class OtpSendData implements Built<OtpSendData, OtpSendDataBuilder> {
  @BuiltValueField(wireName: r'challenge_id')
  String? get challengeId;

  @BuiltValueField(wireName: r'expires_in')
  int? get expiresIn;

  @BuiltValueField(wireName: r'otp')
  String? get otp;

  OtpSendData._();

  factory OtpSendData([void updates(OtpSendDataBuilder b)]) = _$OtpSendData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OtpSendDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OtpSendData> get serializer => _$OtpSendDataSerializer();
}

class _$OtpSendDataSerializer implements PrimitiveSerializer<OtpSendData> {
  @override
  final Iterable<Type> types = const [OtpSendData, _$OtpSendData];

  @override
  final String wireName = r'OtpSendData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OtpSendData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.challengeId != null) {
      yield r'challenge_id';
      yield serializers.serialize(
        object.challengeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.expiresIn != null) {
      yield r'expires_in';
      yield serializers.serialize(
        object.expiresIn,
        specifiedType: const FullType(int),
      );
    }
    if (object.otp != null) {
      yield r'otp';
      yield serializers.serialize(
        object.otp,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OtpSendData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OtpSendDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'challenge_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.challengeId = valueDes;
          break;
        case r'expires_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.expiresIn = valueDes;
          break;
        case r'otp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.otp = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OtpSendData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OtpSendDataBuilder();
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

