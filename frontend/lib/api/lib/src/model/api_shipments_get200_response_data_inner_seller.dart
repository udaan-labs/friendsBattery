//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_shipments_get200_response_data_inner_seller.g.dart';

/// ApiShipmentsGet200ResponseDataInnerSeller
///
/// Properties:
/// * [id] 
/// * [userName] 
/// * [shopName] 
@BuiltValue()
abstract class ApiShipmentsGet200ResponseDataInnerSeller implements Built<ApiShipmentsGet200ResponseDataInnerSeller, ApiShipmentsGet200ResponseDataInnerSellerBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'userName')
  String? get userName;

  @BuiltValueField(wireName: r'shopName')
  String? get shopName;

  ApiShipmentsGet200ResponseDataInnerSeller._();

  factory ApiShipmentsGet200ResponseDataInnerSeller([void updates(ApiShipmentsGet200ResponseDataInnerSellerBuilder b)]) = _$ApiShipmentsGet200ResponseDataInnerSeller;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiShipmentsGet200ResponseDataInnerSellerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiShipmentsGet200ResponseDataInnerSeller> get serializer => _$ApiShipmentsGet200ResponseDataInnerSellerSerializer();
}

class _$ApiShipmentsGet200ResponseDataInnerSellerSerializer implements PrimitiveSerializer<ApiShipmentsGet200ResponseDataInnerSeller> {
  @override
  final Iterable<Type> types = const [ApiShipmentsGet200ResponseDataInnerSeller, _$ApiShipmentsGet200ResponseDataInnerSeller];

  @override
  final String wireName = r'ApiShipmentsGet200ResponseDataInnerSeller';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiShipmentsGet200ResponseDataInnerSeller object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userName != null) {
      yield r'userName';
      yield serializers.serialize(
        object.userName,
        specifiedType: const FullType(String),
      );
    }
    if (object.shopName != null) {
      yield r'shopName';
      yield serializers.serialize(
        object.shopName,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiShipmentsGet200ResponseDataInnerSeller object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiShipmentsGet200ResponseDataInnerSellerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'userName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userName = valueDes;
          break;
        case r'shopName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.shopName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiShipmentsGet200ResponseDataInnerSeller deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiShipmentsGet200ResponseDataInnerSellerBuilder();
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

