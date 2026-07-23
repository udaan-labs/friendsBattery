//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/inventory_pagination.dart';
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/inventory_list_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'inventory_list_payload.g.dart';

/// InventoryListPayload
///
/// Properties:
/// * [data] 
/// * [pagination] 
@BuiltValue()
abstract class InventoryListPayload implements Built<InventoryListPayload, InventoryListPayloadBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<InventoryListItem>? get data;

  @BuiltValueField(wireName: r'pagination')
  InventoryPagination? get pagination;

  InventoryListPayload._();

  factory InventoryListPayload([void updates(InventoryListPayloadBuilder b)]) = _$InventoryListPayload;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InventoryListPayloadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InventoryListPayload> get serializer => _$InventoryListPayloadSerializer();
}

class _$InventoryListPayloadSerializer implements PrimitiveSerializer<InventoryListPayload> {
  @override
  final Iterable<Type> types = const [InventoryListPayload, _$InventoryListPayload];

  @override
  final String wireName = r'InventoryListPayload';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InventoryListPayload object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(BuiltList, [FullType(InventoryListItem)]),
      );
    }
    if (object.pagination != null) {
      yield r'pagination';
      yield serializers.serialize(
        object.pagination,
        specifiedType: const FullType(InventoryPagination),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    InventoryListPayload object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InventoryListPayloadBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(InventoryListItem)]),
          ) as BuiltList<InventoryListItem>;
          result.data.replace(valueDes);
          break;
        case r'pagination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(InventoryPagination),
          ) as InventoryPagination;
          result.pagination.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InventoryListPayload deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InventoryListPayloadBuilder();
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

