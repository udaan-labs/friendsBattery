//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'adjust_inventory_result.g.dart';

/// AdjustInventoryResult
///
/// Properties:
/// * [adjusted] 
/// * [adjustmentQuantity] 
@BuiltValue()
abstract class AdjustInventoryResult implements Built<AdjustInventoryResult, AdjustInventoryResultBuilder> {
  @BuiltValueField(wireName: r'adjusted')
  bool? get adjusted;

  @BuiltValueField(wireName: r'adjustment_quantity')
  int? get adjustmentQuantity;

  AdjustInventoryResult._();

  factory AdjustInventoryResult([void updates(AdjustInventoryResultBuilder b)]) = _$AdjustInventoryResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdjustInventoryResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdjustInventoryResult> get serializer => _$AdjustInventoryResultSerializer();
}

class _$AdjustInventoryResultSerializer implements PrimitiveSerializer<AdjustInventoryResult> {
  @override
  final Iterable<Type> types = const [AdjustInventoryResult, _$AdjustInventoryResult];

  @override
  final String wireName = r'AdjustInventoryResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdjustInventoryResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.adjusted != null) {
      yield r'adjusted';
      yield serializers.serialize(
        object.adjusted,
        specifiedType: const FullType(bool),
      );
    }
    if (object.adjustmentQuantity != null) {
      yield r'adjustment_quantity';
      yield serializers.serialize(
        object.adjustmentQuantity,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdjustInventoryResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdjustInventoryResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'adjusted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.adjusted = valueDes;
          break;
        case r'adjustment_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.adjustmentQuantity = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdjustInventoryResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdjustInventoryResultBuilder();
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

