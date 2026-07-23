//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verify_product_unit.g.dart';

/// VerifyProductUnit
///
/// Properties:
/// * [serialNumber] 
/// * [status] 
/// * [qrCode] 
/// * [manufactureDate] 
/// * [warrantyExpiry] 
@BuiltValue()
abstract class VerifyProductUnit implements Built<VerifyProductUnit, VerifyProductUnitBuilder> {
  @BuiltValueField(wireName: r'serialNumber')
  String? get serialNumber;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'qrCode')
  String? get qrCode;

  @BuiltValueField(wireName: r'manufactureDate')
  DateTime? get manufactureDate;

  @BuiltValueField(wireName: r'warrantyExpiry')
  DateTime? get warrantyExpiry;

  VerifyProductUnit._();

  factory VerifyProductUnit([void updates(VerifyProductUnitBuilder b)]) = _$VerifyProductUnit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VerifyProductUnitBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VerifyProductUnit> get serializer => _$VerifyProductUnitSerializer();
}

class _$VerifyProductUnitSerializer implements PrimitiveSerializer<VerifyProductUnit> {
  @override
  final Iterable<Type> types = const [VerifyProductUnit, _$VerifyProductUnit];

  @override
  final String wireName = r'VerifyProductUnit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VerifyProductUnit object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.serialNumber != null) {
      yield r'serialNumber';
      yield serializers.serialize(
        object.serialNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.qrCode != null) {
      yield r'qrCode';
      yield serializers.serialize(
        object.qrCode,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.manufactureDate != null) {
      yield r'manufactureDate';
      yield serializers.serialize(
        object.manufactureDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.warrantyExpiry != null) {
      yield r'warrantyExpiry';
      yield serializers.serialize(
        object.warrantyExpiry,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    VerifyProductUnit object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VerifyProductUnitBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'serialNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.serialNumber = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'qrCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.qrCode = valueDes;
          break;
        case r'manufactureDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.manufactureDate = valueDes;
          break;
        case r'warrantyExpiry':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.warrantyExpiry = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  VerifyProductUnit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VerifyProductUnitBuilder();
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

