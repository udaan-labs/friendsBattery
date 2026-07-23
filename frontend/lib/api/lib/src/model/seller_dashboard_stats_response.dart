//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/seller_dashboard_stats.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'seller_dashboard_stats_response.g.dart';

/// SellerDashboardStatsResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class SellerDashboardStatsResponse implements Built<SellerDashboardStatsResponse, SellerDashboardStatsResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  SellerDashboardStats? get data;

  SellerDashboardStatsResponse._();

  factory SellerDashboardStatsResponse([void updates(SellerDashboardStatsResponseBuilder b)]) = _$SellerDashboardStatsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SellerDashboardStatsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SellerDashboardStatsResponse> get serializer => _$SellerDashboardStatsResponseSerializer();
}

class _$SellerDashboardStatsResponseSerializer implements PrimitiveSerializer<SellerDashboardStatsResponse> {
  @override
  final Iterable<Type> types = const [SellerDashboardStatsResponse, _$SellerDashboardStatsResponse];

  @override
  final String wireName = r'SellerDashboardStatsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SellerDashboardStatsResponse object, {
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
        specifiedType: const FullType(SellerDashboardStats),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SellerDashboardStatsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SellerDashboardStatsResponseBuilder result,
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
            specifiedType: const FullType(SellerDashboardStats),
          ) as SellerDashboardStats;
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
  SellerDashboardStatsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SellerDashboardStatsResponseBuilder();
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

