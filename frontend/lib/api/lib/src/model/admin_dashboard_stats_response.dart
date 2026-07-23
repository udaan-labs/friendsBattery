//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/admin_dashboard_stats.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_dashboard_stats_response.g.dart';

/// AdminDashboardStatsResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class AdminDashboardStatsResponse implements Built<AdminDashboardStatsResponse, AdminDashboardStatsResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  AdminDashboardStats? get data;

  AdminDashboardStatsResponse._();

  factory AdminDashboardStatsResponse([void updates(AdminDashboardStatsResponseBuilder b)]) = _$AdminDashboardStatsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminDashboardStatsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminDashboardStatsResponse> get serializer => _$AdminDashboardStatsResponseSerializer();
}

class _$AdminDashboardStatsResponseSerializer implements PrimitiveSerializer<AdminDashboardStatsResponse> {
  @override
  final Iterable<Type> types = const [AdminDashboardStatsResponse, _$AdminDashboardStatsResponse];

  @override
  final String wireName = r'AdminDashboardStatsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminDashboardStatsResponse object, {
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
        specifiedType: const FullType(AdminDashboardStats),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminDashboardStatsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminDashboardStatsResponseBuilder result,
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
            specifiedType: const FullType(AdminDashboardStats),
          ) as AdminDashboardStats;
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
  AdminDashboardStatsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminDashboardStatsResponseBuilder();
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

