//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_dashboard_stats.g.dart';

/// AdminDashboardStats
///
/// Properties:
/// * [totalStock] 
/// * [todaySales] 
/// * [todaySalesAmount] 
/// * [pendingRequests] 
/// * [totalSellers] 
/// * [pendingShipments] 
@BuiltValue()
abstract class AdminDashboardStats implements Built<AdminDashboardStats, AdminDashboardStatsBuilder> {
  @BuiltValueField(wireName: r'totalStock')
  int? get totalStock;

  @BuiltValueField(wireName: r'todaySales')
  int? get todaySales;

  @BuiltValueField(wireName: r'todaySalesAmount')
  num? get todaySalesAmount;

  @BuiltValueField(wireName: r'pendingRequests')
  int? get pendingRequests;

  @BuiltValueField(wireName: r'totalSellers')
  int? get totalSellers;

  @BuiltValueField(wireName: r'pendingShipments')
  int? get pendingShipments;

  AdminDashboardStats._();

  factory AdminDashboardStats([void updates(AdminDashboardStatsBuilder b)]) = _$AdminDashboardStats;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminDashboardStatsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminDashboardStats> get serializer => _$AdminDashboardStatsSerializer();
}

class _$AdminDashboardStatsSerializer implements PrimitiveSerializer<AdminDashboardStats> {
  @override
  final Iterable<Type> types = const [AdminDashboardStats, _$AdminDashboardStats];

  @override
  final String wireName = r'AdminDashboardStats';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminDashboardStats object, {
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
    AdminDashboardStats object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminDashboardStatsBuilder result,
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
  AdminDashboardStats deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminDashboardStatsBuilder();
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

