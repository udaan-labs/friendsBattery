//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/shop_staff_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'shop_staff_response.g.dart';

/// ShopStaffResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ShopStaffResponse implements Built<ShopStaffResponse, ShopStaffResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  ShopStaffData? get data;

  ShopStaffResponse._();

  factory ShopStaffResponse([void updates(ShopStaffResponseBuilder b)]) = _$ShopStaffResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ShopStaffResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ShopStaffResponse> get serializer => _$ShopStaffResponseSerializer();
}

class _$ShopStaffResponseSerializer implements PrimitiveSerializer<ShopStaffResponse> {
  @override
  final Iterable<Type> types = const [ShopStaffResponse, _$ShopStaffResponse];

  @override
  final String wireName = r'ShopStaffResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ShopStaffResponse object, {
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
        specifiedType: const FullType(ShopStaffData),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ShopStaffResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ShopStaffResponseBuilder result,
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
            specifiedType: const FullType(ShopStaffData),
          ) as ShopStaffData;
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
  ShopStaffResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ShopStaffResponseBuilder();
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

