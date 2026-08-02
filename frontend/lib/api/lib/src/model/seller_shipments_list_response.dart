//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/seller_shipment_list_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'seller_shipments_list_response.g.dart';

/// SellerShipmentsListResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class SellerShipmentsListResponse implements Built<SellerShipmentsListResponse, SellerShipmentsListResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<SellerShipmentListItem>? get data;

  SellerShipmentsListResponse._();

  factory SellerShipmentsListResponse([void updates(SellerShipmentsListResponseBuilder b)]) = _$SellerShipmentsListResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SellerShipmentsListResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SellerShipmentsListResponse> get serializer => _$SellerShipmentsListResponseSerializer();
}

class _$SellerShipmentsListResponseSerializer implements PrimitiveSerializer<SellerShipmentsListResponse> {
  @override
  final Iterable<Type> types = const [SellerShipmentsListResponse, _$SellerShipmentsListResponse];

  @override
  final String wireName = r'SellerShipmentsListResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SellerShipmentsListResponse object, {
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
        specifiedType: const FullType(BuiltList, [FullType(SellerShipmentListItem)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SellerShipmentsListResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SellerShipmentsListResponseBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(SellerShipmentListItem)]),
          ) as BuiltList<SellerShipmentListItem>;
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
  SellerShipmentsListResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SellerShipmentsListResponseBuilder();
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

