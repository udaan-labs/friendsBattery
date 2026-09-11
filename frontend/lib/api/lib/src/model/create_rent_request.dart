//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_rent_request.g.dart';

/// CreateRentRequest
///
/// Properties:
/// * [serialNumber] 
/// * [customerName] 
/// * [customerNumber] 
/// * [deposit] 
/// * [paymentMode] 
@BuiltValue()
abstract class CreateRentRequest implements Built<CreateRentRequest, CreateRentRequestBuilder> {
  @BuiltValueField(wireName: r'serial_number')
  String get serialNumber;

  @BuiltValueField(wireName: r'customer_name')
  String get customerName;

  @BuiltValueField(wireName: r'customer_number')
  String get customerNumber;

  @BuiltValueField(wireName: r'deposit')
  num get deposit;

  @BuiltValueField(wireName: r'payment_mode')
  CreateRentRequestPaymentModeEnum? get paymentMode;
  // enum paymentModeEnum {  CASH,  ONLINE,  CREDIT,  };

  CreateRentRequest._();

  factory CreateRentRequest([void updates(CreateRentRequestBuilder b)]) = _$CreateRentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateRentRequestBuilder b) => b
      ..paymentMode = CreateRentRequestPaymentModeEnum.valueOf('CASH');

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateRentRequest> get serializer => _$CreateRentRequestSerializer();
}

class _$CreateRentRequestSerializer implements PrimitiveSerializer<CreateRentRequest> {
  @override
  final Iterable<Type> types = const [CreateRentRequest, _$CreateRentRequest];

  @override
  final String wireName = r'CreateRentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateRentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    yield r'deposit';
    yield serializers.serialize(
      object.deposit,
      specifiedType: const FullType(num),
    );
    if (object.paymentMode != null) {
      yield r'payment_mode';
      yield serializers.serialize(
        object.paymentMode,
        specifiedType: const FullType(CreateRentRequestPaymentModeEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateRentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateRentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'deposit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.deposit = valueDes;
          break;
        case r'payment_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateRentRequestPaymentModeEnum),
          ) as CreateRentRequestPaymentModeEnum;
          result.paymentMode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateRentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateRentRequestBuilder();
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

class CreateRentRequestPaymentModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CASH')
  static const CreateRentRequestPaymentModeEnum CASH = _$createRentRequestPaymentModeEnum_CASH;
  @BuiltValueEnumConst(wireName: r'ONLINE')
  static const CreateRentRequestPaymentModeEnum ONLINE = _$createRentRequestPaymentModeEnum_ONLINE;
  @BuiltValueEnumConst(wireName: r'CREDIT')
  static const CreateRentRequestPaymentModeEnum CREDIT = _$createRentRequestPaymentModeEnum_CREDIT;

  static Serializer<CreateRentRequestPaymentModeEnum> get serializer => _$createRentRequestPaymentModeEnumSerializer;

  const CreateRentRequestPaymentModeEnum._(String name): super(name);

  static BuiltSet<CreateRentRequestPaymentModeEnum> get values => _$createRentRequestPaymentModeEnumValues;
  static CreateRentRequestPaymentModeEnum valueOf(String name) => _$createRentRequestPaymentModeEnumValueOf(name);
}

