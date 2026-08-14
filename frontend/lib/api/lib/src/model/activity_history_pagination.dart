//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'activity_history_pagination.g.dart';

/// ActivityHistoryPagination
///
/// Properties:
/// * [limit] 
/// * [nextCursor] 
/// * [hasNextPage] 
@BuiltValue()
abstract class ActivityHistoryPagination implements Built<ActivityHistoryPagination, ActivityHistoryPaginationBuilder> {
  @BuiltValueField(wireName: r'limit')
  int? get limit;

  @BuiltValueField(wireName: r'nextCursor')
  String? get nextCursor;

  @BuiltValueField(wireName: r'hasNextPage')
  bool? get hasNextPage;

  ActivityHistoryPagination._();

  factory ActivityHistoryPagination([void updates(ActivityHistoryPaginationBuilder b)]) = _$ActivityHistoryPagination;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ActivityHistoryPaginationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ActivityHistoryPagination> get serializer => _$ActivityHistoryPaginationSerializer();
}

class _$ActivityHistoryPaginationSerializer implements PrimitiveSerializer<ActivityHistoryPagination> {
  @override
  final Iterable<Type> types = const [ActivityHistoryPagination, _$ActivityHistoryPagination];

  @override
  final String wireName = r'ActivityHistoryPagination';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ActivityHistoryPagination object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.limit != null) {
      yield r'limit';
      yield serializers.serialize(
        object.limit,
        specifiedType: const FullType(int),
      );
    }
    if (object.nextCursor != null) {
      yield r'nextCursor';
      yield serializers.serialize(
        object.nextCursor,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.hasNextPage != null) {
      yield r'hasNextPage';
      yield serializers.serialize(
        object.hasNextPage,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ActivityHistoryPagination object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ActivityHistoryPaginationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'limit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.limit = valueDes;
          break;
        case r'nextCursor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nextCursor = valueDes;
          break;
        case r'hasNextPage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasNextPage = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ActivityHistoryPagination deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ActivityHistoryPaginationBuilder();
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

