//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:friends_battery_api/src/model/api_seller_shipments_get200_response_data_inner_items_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_seller_shipments_get200_response_data_inner.g.dart';

/// ApiSellerShipmentsGet200ResponseDataInner
///
/// Properties:
/// * [shipmentId] 
/// * [shipmentNumber] 
/// * [status] 
/// * [createdAt] 
/// * [items] 
@BuiltValue()
abstract class ApiSellerShipmentsGet200ResponseDataInner implements Built<ApiSellerShipmentsGet200ResponseDataInner, ApiSellerShipmentsGet200ResponseDataInnerBuilder> {
  @BuiltValueField(wireName: r'shipmentId')
  int? get shipmentId;

  @BuiltValueField(wireName: r'shipmentNumber')
  String? get shipmentNumber;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'createdAt')
  String? get createdAt;

  @BuiltValueField(wireName: r'items')
  BuiltList<ApiSellerShipmentsGet200ResponseDataInnerItemsInner>? get items;

  ApiSellerShipmentsGet200ResponseDataInner._();

  factory ApiSellerShipmentsGet200ResponseDataInner([void updates(ApiSellerShipmentsGet200ResponseDataInnerBuilder b)]) = _$ApiSellerShipmentsGet200ResponseDataInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiSellerShipmentsGet200ResponseDataInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiSellerShipmentsGet200ResponseDataInner> get serializer => _$ApiSellerShipmentsGet200ResponseDataInnerSerializer();
}

class _$ApiSellerShipmentsGet200ResponseDataInnerSerializer implements PrimitiveSerializer<ApiSellerShipmentsGet200ResponseDataInner> {
  @override
  final Iterable<Type> types = const [ApiSellerShipmentsGet200ResponseDataInner, _$ApiSellerShipmentsGet200ResponseDataInner];

  @override
  final String wireName = r'ApiSellerShipmentsGet200ResponseDataInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiSellerShipmentsGet200ResponseDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.shipmentId != null) {
      yield r'shipmentId';
      yield serializers.serialize(
        object.shipmentId,
        specifiedType: const FullType(int),
      );
    }
    if (object.shipmentNumber != null) {
      yield r'shipmentNumber';
      yield serializers.serialize(
        object.shipmentNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(String),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(ApiSellerShipmentsGet200ResponseDataInnerItemsInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiSellerShipmentsGet200ResponseDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiSellerShipmentsGet200ResponseDataInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'shipmentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.shipmentId = valueDes;
          break;
        case r'shipmentNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.shipmentNumber = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createdAt = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ApiSellerShipmentsGet200ResponseDataInnerItemsInner)]),
          ) as BuiltList<ApiSellerShipmentsGet200ResponseDataInnerItemsInner>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiSellerShipmentsGet200ResponseDataInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiSellerShipmentsGet200ResponseDataInnerBuilder();
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

