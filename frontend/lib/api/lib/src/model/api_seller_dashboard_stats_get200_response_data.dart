//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_seller_dashboard_stats_get200_response_data.g.dart';

/// ApiSellerDashboardStatsGet200ResponseData
///
/// Properties:
/// * [totalStock] 
/// * [todaySales] 
/// * [pendingShipments] 
@BuiltValue()
abstract class ApiSellerDashboardStatsGet200ResponseData implements Built<ApiSellerDashboardStatsGet200ResponseData, ApiSellerDashboardStatsGet200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'totalStock')
  int? get totalStock;

  @BuiltValueField(wireName: r'todaySales')
  int? get todaySales;

  @BuiltValueField(wireName: r'pendingShipments')
  int? get pendingShipments;

  ApiSellerDashboardStatsGet200ResponseData._();

  factory ApiSellerDashboardStatsGet200ResponseData([void updates(ApiSellerDashboardStatsGet200ResponseDataBuilder b)]) = _$ApiSellerDashboardStatsGet200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiSellerDashboardStatsGet200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiSellerDashboardStatsGet200ResponseData> get serializer => _$ApiSellerDashboardStatsGet200ResponseDataSerializer();
}

class _$ApiSellerDashboardStatsGet200ResponseDataSerializer implements PrimitiveSerializer<ApiSellerDashboardStatsGet200ResponseData> {
  @override
  final Iterable<Type> types = const [ApiSellerDashboardStatsGet200ResponseData, _$ApiSellerDashboardStatsGet200ResponseData];

  @override
  final String wireName = r'ApiSellerDashboardStatsGet200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiSellerDashboardStatsGet200ResponseData object, {
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
    if (object.pendingShipments != null) {
      yield r'pendingShipments';
      yield serializers.serialize(
        object.pendingShipments,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiSellerDashboardStatsGet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiSellerDashboardStatsGet200ResponseDataBuilder result,
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
        case r'pendingShipments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pendingShipments = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiSellerDashboardStatsGet200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiSellerDashboardStatsGet200ResponseDataBuilder();
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

