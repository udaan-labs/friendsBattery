//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/adjust_inventory_result.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'adjust_inventory_response.g.dart';

/// AdjustInventoryResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class AdjustInventoryResponse implements Built<AdjustInventoryResponse, AdjustInventoryResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  AdjustInventoryResult? get data;

  AdjustInventoryResponse._();

  factory AdjustInventoryResponse([void updates(AdjustInventoryResponseBuilder b)]) = _$AdjustInventoryResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdjustInventoryResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdjustInventoryResponse> get serializer => _$AdjustInventoryResponseSerializer();
}

class _$AdjustInventoryResponseSerializer implements PrimitiveSerializer<AdjustInventoryResponse> {
  @override
  final Iterable<Type> types = const [AdjustInventoryResponse, _$AdjustInventoryResponse];

  @override
  final String wireName = r'AdjustInventoryResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdjustInventoryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.success != null) {
      yield r'success';
      yield serializers.serialize(
        object.success,
        specifiedType: const FullType(bool),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(AdjustInventoryResult),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdjustInventoryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdjustInventoryResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.success = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdjustInventoryResult),
          ) as AdjustInventoryResult;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdjustInventoryResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdjustInventoryResponseBuilder();
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

