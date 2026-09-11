//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_shipment_request.g.dart';

/// CreateShipmentRequest
///
/// Properties:
/// * [sellerId] 
/// * [serialNumbers] - Serials of AVAILABLE units owned by the admin. Product is resolved from each unit.
@BuiltValue()
abstract class CreateShipmentRequest implements Built<CreateShipmentRequest, CreateShipmentRequestBuilder> {
  @BuiltValueField(wireName: r'sellerId')
  int get sellerId;

  /// Serials of AVAILABLE units owned by the admin. Product is resolved from each unit.
  @BuiltValueField(wireName: r'serial_numbers')
  BuiltList<String> get serialNumbers;

  CreateShipmentRequest._();

  factory CreateShipmentRequest([void updates(CreateShipmentRequestBuilder b)]) = _$CreateShipmentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateShipmentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateShipmentRequest> get serializer => _$CreateShipmentRequestSerializer();
}

class _$CreateShipmentRequestSerializer implements PrimitiveSerializer<CreateShipmentRequest> {
  @override
  final Iterable<Type> types = const [CreateShipmentRequest, _$CreateShipmentRequest];

  @override
  final String wireName = r'CreateShipmentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateShipmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'sellerId';
    yield serializers.serialize(
      object.sellerId,
      specifiedType: const FullType(int),
    );
    yield r'serial_numbers';
    yield serializers.serialize(
      object.serialNumbers,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateShipmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateShipmentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sellerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sellerId = valueDes;
          break;
        case r'serial_numbers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.serialNumbers.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateShipmentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateShipmentRequestBuilder();
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

