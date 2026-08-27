//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/seller_recent_sale.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'seller_dashboard_stats.g.dart';

/// SellerDashboardStats
///
/// Properties:
/// * [totalStock] 
/// * [todaySales] 
/// * [todaySalesAmount] 
/// * [pendingShipments] 
/// * [recentSales] 
@BuiltValue()
abstract class SellerDashboardStats implements Built<SellerDashboardStats, SellerDashboardStatsBuilder> {
  @BuiltValueField(wireName: r'totalStock')
  int? get totalStock;

  @BuiltValueField(wireName: r'todaySales')
  int? get todaySales;

  @BuiltValueField(wireName: r'todaySalesAmount')
  num? get todaySalesAmount;

  @BuiltValueField(wireName: r'pendingShipments')
  int? get pendingShipments;

  @BuiltValueField(wireName: r'recentSales')
  BuiltList<SellerRecentSale>? get recentSales;

  SellerDashboardStats._();

  factory SellerDashboardStats([void updates(SellerDashboardStatsBuilder b)]) = _$SellerDashboardStats;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SellerDashboardStatsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SellerDashboardStats> get serializer => _$SellerDashboardStatsSerializer();
}

class _$SellerDashboardStatsSerializer implements PrimitiveSerializer<SellerDashboardStats> {
  @override
  final Iterable<Type> types = const [SellerDashboardStats, _$SellerDashboardStats];

  @override
  final String wireName = r'SellerDashboardStats';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SellerDashboardStats object, {
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
    if (object.todaySalesAmount != null) {
      yield r'todaySalesAmount';
      yield serializers.serialize(
        object.todaySalesAmount,
        specifiedType: const FullType(num),
      );
    }
    if (object.pendingShipments != null) {
      yield r'pendingShipments';
      yield serializers.serialize(
        object.pendingShipments,
        specifiedType: const FullType(int),
      );
    }
    if (object.recentSales != null) {
      yield r'recentSales';
      yield serializers.serialize(
        object.recentSales,
        specifiedType: const FullType(BuiltList, [FullType(SellerRecentSale)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SellerDashboardStats object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SellerDashboardStatsBuilder result,
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
        case r'todaySalesAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.todaySalesAmount = valueDes;
          break;
        case r'pendingShipments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pendingShipments = valueDes;
          break;
        case r'recentSales':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(SellerRecentSale)]),
          ) as BuiltList<SellerRecentSale>;
          result.recentSales.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SellerDashboardStats deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SellerDashboardStatsBuilder();
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

