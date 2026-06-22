//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_seller_dashboard_pending_shipments_get200_response_data.g.dart';

/// ApiSellerDashboardPendingShipmentsGet200ResponseData
///
/// Properties:
/// * [pendingShipments] 
@BuiltValue()
abstract class ApiSellerDashboardPendingShipmentsGet200ResponseData implements Built<ApiSellerDashboardPendingShipmentsGet200ResponseData, ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'pendingShipments')
  int? get pendingShipments;

  ApiSellerDashboardPendingShipmentsGet200ResponseData._();

  factory ApiSellerDashboardPendingShipmentsGet200ResponseData([void updates(ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder b)]) = _$ApiSellerDashboardPendingShipmentsGet200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiSellerDashboardPendingShipmentsGet200ResponseData> get serializer => _$ApiSellerDashboardPendingShipmentsGet200ResponseDataSerializer();
}

class _$ApiSellerDashboardPendingShipmentsGet200ResponseDataSerializer implements PrimitiveSerializer<ApiSellerDashboardPendingShipmentsGet200ResponseData> {
  @override
  final Iterable<Type> types = const [ApiSellerDashboardPendingShipmentsGet200ResponseData, _$ApiSellerDashboardPendingShipmentsGet200ResponseData];

  @override
  final String wireName = r'ApiSellerDashboardPendingShipmentsGet200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiSellerDashboardPendingShipmentsGet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    ApiSellerDashboardPendingShipmentsGet200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  ApiSellerDashboardPendingShipmentsGet200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiSellerDashboardPendingShipmentsGet200ResponseDataBuilder();
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

