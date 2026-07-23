//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/inventory_item_detail.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'inventory_item_detail_response.g.dart';

/// InventoryItemDetailResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class InventoryItemDetailResponse implements Built<InventoryItemDetailResponse, InventoryItemDetailResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  InventoryItemDetail? get data;

  InventoryItemDetailResponse._();

  factory InventoryItemDetailResponse([void updates(InventoryItemDetailResponseBuilder b)]) = _$InventoryItemDetailResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InventoryItemDetailResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InventoryItemDetailResponse> get serializer => _$InventoryItemDetailResponseSerializer();
}

class _$InventoryItemDetailResponseSerializer implements PrimitiveSerializer<InventoryItemDetailResponse> {
  @override
  final Iterable<Type> types = const [InventoryItemDetailResponse, _$InventoryItemDetailResponse];

  @override
  final String wireName = r'InventoryItemDetailResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InventoryItemDetailResponse object, {
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
        specifiedType: const FullType(InventoryItemDetail),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    InventoryItemDetailResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InventoryItemDetailResponseBuilder result,
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
            specifiedType: const FullType(InventoryItemDetail),
          ) as InventoryItemDetail;
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
  InventoryItemDetailResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InventoryItemDetailResponseBuilder();
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

