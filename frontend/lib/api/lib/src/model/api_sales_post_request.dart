//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_sales_post_request.g.dart';

/// ApiSalesPostRequest
///
/// Properties:
/// * [productId] 
/// * [serialNumber] 
/// * [customerName] 
/// * [customerNumber] 
/// * [vehicleNumber] 
/// * [sellPrice] 
@BuiltValue()
abstract class ApiSalesPostRequest implements Built<ApiSalesPostRequest, ApiSalesPostRequestBuilder> {
  @BuiltValueField(wireName: r'product_id')
  int? get productId;

  @BuiltValueField(wireName: r'serial_number')
  String? get serialNumber;

  @BuiltValueField(wireName: r'customer_name')
  String? get customerName;

  @BuiltValueField(wireName: r'customer_number')
  String? get customerNumber;

  @BuiltValueField(wireName: r'vehicle_number')
  String? get vehicleNumber;

  @BuiltValueField(wireName: r'sell_price')
  num? get sellPrice;

  ApiSalesPostRequest._();

  factory ApiSalesPostRequest([void updates(ApiSalesPostRequestBuilder b)]) = _$ApiSalesPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApiSalesPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApiSalesPostRequest> get serializer => _$ApiSalesPostRequestSerializer();
}

class _$ApiSalesPostRequestSerializer implements PrimitiveSerializer<ApiSalesPostRequest> {
  @override
  final Iterable<Type> types = const [ApiSalesPostRequest, _$ApiSalesPostRequest];

  @override
  final String wireName = r'ApiSalesPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApiSalesPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productId != null) {
      yield r'product_id';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType(int),
      );
    }
    if (object.serialNumber != null) {
      yield r'serial_number';
      yield serializers.serialize(
        object.serialNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.customerName != null) {
      yield r'customer_name';
      yield serializers.serialize(
        object.customerName,
        specifiedType: const FullType(String),
      );
    }
    if (object.customerNumber != null) {
      yield r'customer_number';
      yield serializers.serialize(
        object.customerNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.vehicleNumber != null) {
      yield r'vehicle_number';
      yield serializers.serialize(
        object.vehicleNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.sellPrice != null) {
      yield r'sell_price';
      yield serializers.serialize(
        object.sellPrice,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApiSalesPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApiSalesPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productId = valueDes;
          break;
        case r'serial_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.serialNumber = valueDes;
          break;
        case r'customer_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerName = valueDes;
          break;
        case r'customer_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerNumber = valueDes;
          break;
        case r'vehicle_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.vehicleNumber = valueDes;
          break;
        case r'sell_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.sellPrice = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApiSalesPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApiSalesPostRequestBuilder();
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

