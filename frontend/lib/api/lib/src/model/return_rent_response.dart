//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/return_rent_result.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'return_rent_response.g.dart';

/// ReturnRentResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ReturnRentResponse implements Built<ReturnRentResponse, ReturnRentResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  ReturnRentResult? get data;

  ReturnRentResponse._();

  factory ReturnRentResponse([void updates(ReturnRentResponseBuilder b)]) = _$ReturnRentResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReturnRentResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReturnRentResponse> get serializer => _$ReturnRentResponseSerializer();
}

class _$ReturnRentResponseSerializer implements PrimitiveSerializer<ReturnRentResponse> {
  @override
  final Iterable<Type> types = const [ReturnRentResponse, _$ReturnRentResponse];

  @override
  final String wireName = r'ReturnRentResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReturnRentResponse object, {
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
        specifiedType: const FullType(ReturnRentResult),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReturnRentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReturnRentResponseBuilder result,
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
            specifiedType: const FullType(ReturnRentResult),
          ) as ReturnRentResult;
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
  ReturnRentResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReturnRentResponseBuilder();
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

