//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/activity_item.dart';
import 'package:friends_battery_api/src/model/activity_history_pagination.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'activity_history_response.g.dart';

/// ActivityHistoryResponse
///
/// Properties:
/// * [success] 
/// * [data] 
/// * [pagination] 
@BuiltValue()
abstract class ActivityHistoryResponse implements Built<ActivityHistoryResponse, ActivityHistoryResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'data')
  BuiltList<ActivityItem>? get data;

  @BuiltValueField(wireName: r'pagination')
  ActivityHistoryPagination? get pagination;

  ActivityHistoryResponse._();

  factory ActivityHistoryResponse([void updates(ActivityHistoryResponseBuilder b)]) = _$ActivityHistoryResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ActivityHistoryResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ActivityHistoryResponse> get serializer => _$ActivityHistoryResponseSerializer();
}

class _$ActivityHistoryResponseSerializer implements PrimitiveSerializer<ActivityHistoryResponse> {
  @override
  final Iterable<Type> types = const [ActivityHistoryResponse, _$ActivityHistoryResponse];

  @override
  final String wireName = r'ActivityHistoryResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ActivityHistoryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.success != null) {
      yield r'success';
      yield serializers.serialize(
        object.success,
        specifiedType: const FullType(bool),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(BuiltList, [FullType(ActivityItem)]),
      );
    }
    if (object.pagination != null) {
      yield r'pagination';
      yield serializers.serialize(
        object.pagination,
        specifiedType: const FullType(ActivityHistoryPagination),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ActivityHistoryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ActivityHistoryResponseBuilder result,
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
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ActivityItem)]),
          ) as BuiltList<ActivityItem>;
          result.data.replace(valueDes);
          break;
        case r'pagination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ActivityHistoryPagination),
          ) as ActivityHistoryPagination;
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
  ActivityHistoryResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ActivityHistoryResponseBuilder();
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

