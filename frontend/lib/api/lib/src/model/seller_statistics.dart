//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'seller_statistics.g.dart';

/// SellerStatistics
///
/// Properties:
/// * [stock] 
/// * [products] 
/// * [sales] 
/// * [returns] 
@BuiltValue()
abstract class SellerStatistics implements Built<SellerStatistics, SellerStatisticsBuilder> {
  @BuiltValueField(wireName: r'stock')
  int? get stock;

  @BuiltValueField(wireName: r'products')
  int? get products;

  @BuiltValueField(wireName: r'sales')
  int? get sales;

  @BuiltValueField(wireName: r'returns')
  int? get returns;

  SellerStatistics._();

  factory SellerStatistics([void updates(SellerStatisticsBuilder b)]) = _$SellerStatistics;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SellerStatisticsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SellerStatistics> get serializer => _$SellerStatisticsSerializer();
}

class _$SellerStatisticsSerializer implements PrimitiveSerializer<SellerStatistics> {
  @override
  final Iterable<Type> types = const [SellerStatistics, _$SellerStatistics];

  @override
  final String wireName = r'SellerStatistics';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SellerStatistics object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.stock != null) {
      yield r'stock';
      yield serializers.serialize(
        object.stock,
        specifiedType: const FullType(int),
      );
    }
    if (object.products != null) {
      yield r'products';
      yield serializers.serialize(
        object.products,
        specifiedType: const FullType(int),
      );
    }
    if (object.sales != null) {
      yield r'sales';
      yield serializers.serialize(
        object.sales,
        specifiedType: const FullType(int),
      );
    }
    if (object.returns != null) {
      yield r'returns';
      yield serializers.serialize(
        object.returns,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SellerStatistics object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SellerStatisticsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'stock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.stock = valueDes;
          break;
        case r'products':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.products = valueDes;
          break;
        case r'sales':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sales = valueDes;
          break;
        case r'returns':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.returns = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SellerStatistics deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SellerStatisticsBuilder();
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

