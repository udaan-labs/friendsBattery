//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/verify_product_info.dart';
import 'package:friends_battery_api/src/model/verify_product_unit.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verify_product_payload.g.dart';

/// VerifyProductPayload
///
/// Properties:
/// * [productUnit] 
/// * [product] 
@BuiltValue()
abstract class VerifyProductPayload implements Built<VerifyProductPayload, VerifyProductPayloadBuilder> {
  @BuiltValueField(wireName: r'productUnit')
  VerifyProductUnit? get productUnit;

  @BuiltValueField(wireName: r'product')
  VerifyProductInfo? get product;

  VerifyProductPayload._();

  factory VerifyProductPayload([void updates(VerifyProductPayloadBuilder b)]) = _$VerifyProductPayload;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VerifyProductPayloadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VerifyProductPayload> get serializer => _$VerifyProductPayloadSerializer();
}

class _$VerifyProductPayloadSerializer implements PrimitiveSerializer<VerifyProductPayload> {
  @override
  final Iterable<Type> types = const [VerifyProductPayload, _$VerifyProductPayload];

  @override
  final String wireName = r'VerifyProductPayload';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VerifyProductPayload object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productUnit != null) {
      yield r'productUnit';
      yield serializers.serialize(
        object.productUnit,
        specifiedType: const FullType(VerifyProductUnit),
      );
    }
    if (object.product != null) {
      yield r'product';
      yield serializers.serialize(
        object.product,
        specifiedType: const FullType(VerifyProductInfo),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    VerifyProductPayload object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VerifyProductPayloadBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'productUnit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(VerifyProductUnit),
          ) as VerifyProductUnit;
          result.productUnit.replace(valueDes);
          break;
        case r'product':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(VerifyProductInfo),
          ) as VerifyProductInfo;
          result.product.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  VerifyProductPayload deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VerifyProductPayloadBuilder();
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

