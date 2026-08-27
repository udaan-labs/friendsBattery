//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sale_seller.g.dart';

/// SaleSeller
///
/// Properties:
/// * [id] 
/// * [userName] 
/// * [shopName] 
@BuiltValue()
abstract class SaleSeller implements Built<SaleSeller, SaleSellerBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'user_name')
  String? get userName;

  @BuiltValueField(wireName: r'shop_name')
  String? get shopName;

  SaleSeller._();

  factory SaleSeller([void updates(SaleSellerBuilder b)]) = _$SaleSeller;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SaleSellerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SaleSeller> get serializer => _$SaleSellerSerializer();
}

class _$SaleSellerSerializer implements PrimitiveSerializer<SaleSeller> {
  @override
  final Iterable<Type> types = const [SaleSeller, _$SaleSeller];

  @override
  final String wireName = r'SaleSeller';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SaleSeller object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userName != null) {
      yield r'user_name';
      yield serializers.serialize(
        object.userName,
        specifiedType: const FullType(String),
      );
    }
    if (object.shopName != null) {
      yield r'shop_name';
      yield serializers.serialize(
        object.shopName,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SaleSeller object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SaleSellerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'user_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userName = valueDes;
          break;
        case r'shop_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.shopName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SaleSeller deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SaleSellerBuilder();
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

