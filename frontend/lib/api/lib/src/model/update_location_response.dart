//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/location_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_location_response.g.dart';

/// UpdateLocationResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class UpdateLocationResponse implements Built<UpdateLocationResponse, UpdateLocationResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  LocationItem? get data;

  UpdateLocationResponse._();

  factory UpdateLocationResponse([void updates(UpdateLocationResponseBuilder b)]) = _$UpdateLocationResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateLocationResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateLocationResponse> get serializer => _$UpdateLocationResponseSerializer();
}

class _$UpdateLocationResponseSerializer implements PrimitiveSerializer<UpdateLocationResponse> {
  @override
  final Iterable<Type> types = const [UpdateLocationResponse, _$UpdateLocationResponse];

  @override
  final String wireName = r'UpdateLocationResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateLocationResponse object, {
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
        specifiedType: const FullType(LocationItem),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateLocationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateLocationResponseBuilder result,
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
            specifiedType: const FullType(LocationItem),
          ) as LocationItem;
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
  UpdateLocationResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateLocationResponseBuilder();
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

