//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/next_employee_user_id_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'next_employee_user_id_response.g.dart';

/// NextEmployeeUserIdResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class NextEmployeeUserIdResponse implements Built<NextEmployeeUserIdResponse, NextEmployeeUserIdResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  NextEmployeeUserIdData? get data;

  NextEmployeeUserIdResponse._();

  factory NextEmployeeUserIdResponse([void updates(NextEmployeeUserIdResponseBuilder b)]) = _$NextEmployeeUserIdResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NextEmployeeUserIdResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NextEmployeeUserIdResponse> get serializer => _$NextEmployeeUserIdResponseSerializer();
}

class _$NextEmployeeUserIdResponseSerializer implements PrimitiveSerializer<NextEmployeeUserIdResponse> {
  @override
  final Iterable<Type> types = const [NextEmployeeUserIdResponse, _$NextEmployeeUserIdResponse];

  @override
  final String wireName = r'NextEmployeeUserIdResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NextEmployeeUserIdResponse object, {
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
        specifiedType: const FullType(NextEmployeeUserIdData),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    NextEmployeeUserIdResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NextEmployeeUserIdResponseBuilder result,
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
            specifiedType: const FullType(NextEmployeeUserIdData),
          ) as NextEmployeeUserIdData;
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
  NextEmployeeUserIdResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NextEmployeeUserIdResponseBuilder();
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

