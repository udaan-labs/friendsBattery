//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_dashboard_stats_get200_response_data.g.dart';

/// ApiDashboardStatsGet200ResponseData
///
/// Properties:
/// * [totalStock] 
/// * [todaySales] 
/// * [pendingRequests] 
/// * [totalSellers] 
@BuiltValue()
abstract class ApiDashboardStatsGet200ResponseData implements Built<ApiDashboardStatsGet200ResponseData, ApiDashboardStatsGet200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'totalStock')
  int? get totalStock;

  @BuiltValueField(wireName: r'todaySales')
  int? get todaySales;

  @BuiltValueField(wireName: r'pendingRequests')
  int? get pendingRequests;

  @BuiltValueField(wireName: r'totalSellers')
  int? get totalSellers;

  ApiDashboardStatsGet200ResponseData._();

  factory ApiDashboardStatsGet200ResponseData([void updates(ApiDashboardStatsGet200ResponseDataBuilder b)]) = _$ApiDashboardStatsGet200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiDashboardStatsGet200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiDashboardStatsGet200ResponseData> get serializer => _$ApiDashboardStatsGet200ResponseDataSerializer();
}

class _$ApiDashboardStatsGet200ResponseDataSerializer implements PrimitiveSerializer<ApiDashboardStatsGet200ResponseData> {
  @override
  final Iterable<Type> types = const [ApiDashboardStatsGet200ResponseData, _$ApiDashboardStatsGet200ResponseData];

  @override
  final String wireName = r'ApiDashboardStatsGet200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiDashboardStatsGet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.totalStock != null) {
      yield r'totalStock';
      yield serializers.serialize(
        object.totalStock,
        specifiedType: const FullType(int),
      );
    }
    if (object.todaySales != null) {
      yield r'todaySales';
      yield serializers.serialize(
        object.todaySales,
        specifiedType: const FullType(int),
      );
    }
    if (object.pendingRequests != null) {
      yield r'pendingRequests';
      yield serializers.serialize(
        object.pendingRequests,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalSellers != null) {
      yield r'totalSellers';
      yield serializers.serialize(
        object.totalSellers,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiDashboardStatsGet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiDashboardStatsGet200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'totalStock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalStock = valueDes;
          break;
        case r'todaySales':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.todaySales = valueDes;
          break;
        case r'pendingRequests':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pendingRequests = valueDes;
          break;
        case r'totalSellers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalSellers = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiDashboardStatsGet200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiDashboardStatsGet200ResponseDataBuilder();
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

