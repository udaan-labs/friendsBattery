//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_service_bill_request.g.dart';

/// CreateServiceBillRequest
///
/// Properties:
/// * [serviceType] 
/// * [amount] 
/// * [customerName] 
/// * [customerNumber] 
/// * [vehicleNumber] 
/// * [place] - Required when service_type is JUMPSTART
@BuiltValue()
abstract class CreateServiceBillRequest implements Built<CreateServiceBillRequest, CreateServiceBillRequestBuilder> {
  @BuiltValueField(wireName: r'service_type')
  CreateServiceBillRequestServiceTypeEnum get serviceType;
  // enum serviceTypeEnum {  BATTERY_CHECK_2W,  BATTERY_CHECK_4W,  BATTERY_CHARGING,  JUMPSTART,  INVERTER_SERVICE,  };

  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'customer_name')
  String get customerName;

  @BuiltValueField(wireName: r'customer_number')
  String get customerNumber;

  @BuiltValueField(wireName: r'vehicle_number')
  String? get vehicleNumber;

  /// Required when service_type is JUMPSTART
  @BuiltValueField(wireName: r'place')
  String? get place;

  CreateServiceBillRequest._();

  factory CreateServiceBillRequest([void updates(CreateServiceBillRequestBuilder b)]) = _$CreateServiceBillRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateServiceBillRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateServiceBillRequest> get serializer => _$CreateServiceBillRequestSerializer();
}

class _$CreateServiceBillRequestSerializer implements PrimitiveSerializer<CreateServiceBillRequest> {
  @override
  final Iterable<Type> types = const [CreateServiceBillRequest, _$CreateServiceBillRequest];

  @override
  final String wireName = r'CreateServiceBillRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateServiceBillRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'service_type';
    yield serializers.serialize(
      object.serviceType,
      specifiedType: const FullType(CreateServiceBillRequestServiceTypeEnum),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
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
    if (object.place != null) {
      yield r'place';
      yield serializers.serialize(
        object.place,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateServiceBillRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateServiceBillRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'service_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateServiceBillRequestServiceTypeEnum),
          ) as CreateServiceBillRequestServiceTypeEnum;
          result.serviceType = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
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
        case r'place':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.place = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateServiceBillRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateServiceBillRequestBuilder();
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

class CreateServiceBillRequestServiceTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BATTERY_CHECK_2W')
  static const CreateServiceBillRequestServiceTypeEnum BATTERY_CHECK_2W = _$createServiceBillRequestServiceTypeEnum_BATTERY_CHECK_2W;
  @BuiltValueEnumConst(wireName: r'BATTERY_CHECK_4W')
  static const CreateServiceBillRequestServiceTypeEnum BATTERY_CHECK_4W = _$createServiceBillRequestServiceTypeEnum_BATTERY_CHECK_4W;
  @BuiltValueEnumConst(wireName: r'BATTERY_CHARGING')
  static const CreateServiceBillRequestServiceTypeEnum BATTERY_CHARGING = _$createServiceBillRequestServiceTypeEnum_BATTERY_CHARGING;
  @BuiltValueEnumConst(wireName: r'JUMPSTART')
  static const CreateServiceBillRequestServiceTypeEnum JUMPSTART = _$createServiceBillRequestServiceTypeEnum_JUMPSTART;
  @BuiltValueEnumConst(wireName: r'INVERTER_SERVICE')
  static const CreateServiceBillRequestServiceTypeEnum INVERTER_SERVICE = _$createServiceBillRequestServiceTypeEnum_INVERTER_SERVICE;

  static Serializer<CreateServiceBillRequestServiceTypeEnum> get serializer => _$createServiceBillRequestServiceTypeEnumSerializer;

  const CreateServiceBillRequestServiceTypeEnum._(String name): super(name);

  static BuiltSet<CreateServiceBillRequestServiceTypeEnum> get values => _$createServiceBillRequestServiceTypeEnumValues;
  static CreateServiceBillRequestServiceTypeEnum valueOf(String name) => _$createServiceBillRequestServiceTypeEnumValueOf(name);
}

