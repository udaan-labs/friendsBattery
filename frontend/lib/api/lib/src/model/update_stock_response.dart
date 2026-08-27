//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/update_stock_result.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_stock_response.g.dart';

/// UpdateStockResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class UpdateStockResponse implements Built<UpdateStockResponse, UpdateStockResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  UpdateStockResult? get data;

  UpdateStockResponse._();

  factory UpdateStockResponse([void updates(UpdateStockResponseBuilder b)]) = _$UpdateStockResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateStockResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateStockResponse> get serializer => _$UpdateStockResponseSerializer();
}

class _$UpdateStockResponseSerializer implements PrimitiveSerializer<UpdateStockResponse> {
  @override
  final Iterable<Type> types = const [UpdateStockResponse, _$UpdateStockResponse];

  @override
  final String wireName = r'UpdateStockResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateStockResponse object, {
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
        specifiedType: const FullType(UpdateStockResult),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateStockResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateStockResponseBuilder result,
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
            specifiedType: const FullType(UpdateStockResult),
          ) as UpdateStockResult;
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
  UpdateStockResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateStockResponseBuilder();
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

