//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/api_seller_dashboard_pending_shipments_get200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_seller_dashboard_pending_shipments_get200_response.g.dart';

/// ApiSellerDashboardPendingShipmentsGet200Response
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ApiSellerDashboardPendingShipmentsGet200Response implements Built<ApiSellerDashboardPendingShipmentsGet200Response, ApiSellerDashboardPendingShipmentsGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  ApiSellerDashboardPendingShipmentsGet200ResponseData? get data;

  ApiSellerDashboardPendingShipmentsGet200Response._();

  factory ApiSellerDashboardPendingShipmentsGet200Response([void updates(ApiSellerDashboardPendingShipmentsGet200ResponseBuilder b)]) = _$ApiSellerDashboardPendingShipmentsGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiSellerDashboardPendingShipmentsGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiSellerDashboardPendingShipmentsGet200Response> get serializer => _$ApiSellerDashboardPendingShipmentsGet200ResponseSerializer();
}

class _$ApiSellerDashboardPendingShipmentsGet200ResponseSerializer implements PrimitiveSerializer<ApiSellerDashboardPendingShipmentsGet200Response> {
  @override
  final Iterable<Type> types = const [ApiSellerDashboardPendingShipmentsGet200Response, _$ApiSellerDashboardPendingShipmentsGet200Response];

  @override
  final String wireName = r'ApiSellerDashboardPendingShipmentsGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiSellerDashboardPendingShipmentsGet200Response object, {
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
        specifiedType: const FullType(ApiSellerDashboardPendingShipmentsGet200ResponseData),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiSellerDashboardPendingShipmentsGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiSellerDashboardPendingShipmentsGet200ResponseBuilder result,
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
            specifiedType: const FullType(ApiSellerDashboardPendingShipmentsGet200ResponseData),
          ) as ApiSellerDashboardPendingShipmentsGet200ResponseData;
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
  ApiSellerDashboardPendingShipmentsGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiSellerDashboardPendingShipmentsGet200ResponseBuilder();
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

