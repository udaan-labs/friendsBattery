//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'otp_verify_data.g.dart';

/// OtpVerifyData
///
/// Properties:
/// * [purpose] 
/// * [verified] 
@BuiltValue()
abstract class OtpVerifyData implements Built<OtpVerifyData, OtpVerifyDataBuilder> {
  @BuiltValueField(wireName: r'purpose')
  String? get purpose;

  @BuiltValueField(wireName: r'verified')
  bool? get verified;

  OtpVerifyData._();

  factory OtpVerifyData([void updates(OtpVerifyDataBuilder b)]) = _$OtpVerifyData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OtpVerifyDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OtpVerifyData> get serializer => _$OtpVerifyDataSerializer();
}

class _$OtpVerifyDataSerializer implements PrimitiveSerializer<OtpVerifyData> {
  @override
  final Iterable<Type> types = const [OtpVerifyData, _$OtpVerifyData];

  @override
  final String wireName = r'OtpVerifyData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OtpVerifyData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.purpose != null) {
      yield r'purpose';
      yield serializers.serialize(
        object.purpose,
        specifiedType: const FullType(String),
      );
    }
    if (object.verified != null) {
      yield r'verified';
      yield serializers.serialize(
        object.verified,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OtpVerifyData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OtpVerifyDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'purpose':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.purpose = valueDes;
          break;
        case r'verified':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.verified = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OtpVerifyData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OtpVerifyDataBuilder();
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

