//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:friends_battery_api/src/model/scan_for_sale_result.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'scan_for_sale_response.g.dart';

/// ScanForSaleResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ScanForSaleResponse implements Built<ScanForSaleResponse, ScanForSaleResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'data')
  ScanForSaleResult? get data;

  ScanForSaleResponse._();

  factory ScanForSaleResponse([void updates(ScanForSaleResponseBuilder b)]) = _$ScanForSaleResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScanForSaleResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScanForSaleResponse> get serializer => _$ScanForSaleResponseSerializer();
}

class _$ScanForSaleResponseSerializer implements PrimitiveSerializer<ScanForSaleResponse> {
  @override
  final Iterable<Type> types = const [ScanForSaleResponse, _$ScanForSaleResponse];

  @override
  final String wireName = r'ScanForSaleResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScanForSaleResponse object, {
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
        specifiedType: const FullType(ScanForSaleResult),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ScanForSaleResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScanForSaleResponseBuilder result,
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
            specifiedType: const FullType(ScanForSaleResult),
          ) as ScanForSaleResult;
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
  ScanForSaleResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScanForSaleResponseBuilder();
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

