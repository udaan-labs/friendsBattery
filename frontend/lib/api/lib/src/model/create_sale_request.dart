//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_sale_request.g.dart';

/// CreateSaleRequest
///
/// Properties:
/// * [productNameId] 
/// * [productModelId] 
/// * [serialNumber] 
/// * [customerName] 
/// * [customerNumber] 
/// * [vehicleNumber] 
/// * [sellPrice] 
@BuiltValue()
abstract class CreateSaleRequest implements Built<CreateSaleRequest, CreateSaleRequestBuilder> {
  @BuiltValueField(wireName: r'product_name_id')
  int get productNameId;

  @BuiltValueField(wireName: r'product_model_id')
  int get productModelId;

  @BuiltValueField(wireName: r'serial_number')
  String get serialNumber;

  @BuiltValueField(wireName: r'customer_name')
  String get customerName;

  @BuiltValueField(wireName: r'customer_number')
  String get customerNumber;

  @BuiltValueField(wireName: r'vehicle_number')
  String? get vehicleNumber;

  @BuiltValueField(wireName: r'sell_price')
  num get sellPrice;

  CreateSaleRequest._();

  factory CreateSaleRequest([void updates(CreateSaleRequestBuilder b)]) = _$CreateSaleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateSaleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateSaleRequest> get serializer => _$CreateSaleRequestSerializer();
}

class _$CreateSaleRequestSerializer implements PrimitiveSerializer<CreateSaleRequest> {
  @override
  final Iterable<Type> types = const [CreateSaleRequest, _$CreateSaleRequest];

  @override
  final String wireName = r'CreateSaleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateSaleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'product_name_id';
    yield serializers.serialize(
      object.productNameId,
      specifiedType: const FullType(int),
    );
    yield r'product_model_id';
    yield serializers.serialize(
      object.productModelId,
      specifiedType: const FullType(int),
    );
    yield r'serial_number';
    yield serializers.serialize(
      object.serialNumber,
      specifiedType: const FullType(String),
    );
    yield r'customer_name';
    yield serializers.serialize(
      object.customerName,
      specifiedType: const FullType(String),
    );
    yield r'customer_number';
    yield serializers.serialize(
      object.customerNumber,
      specifiedType: const FullType(String),
    );
    if (object.vehicleNumber != null) {
      yield r'vehicle_number';
      yield serializers.serialize(
        object.vehicleNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'sell_price';
    yield serializers.serialize(
      object.sellPrice,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateSaleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateSaleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_name_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productNameId = valueDes;
          break;
        case r'product_model_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productModelId = valueDes;
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
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
  CreateSaleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateSaleRequestBuilder();
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

