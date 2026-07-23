//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_inventory_count.g.dart';

/// TransferInventoryCount
///
/// Properties:
/// * [productId] 
/// * [productName] 
/// * [productModel] 
/// * [transferred] 
/// * [adminAvailable] 
/// * [sellerAvailable] 
@BuiltValue()
abstract class TransferInventoryCount implements Built<TransferInventoryCount, TransferInventoryCountBuilder> {
  @BuiltValueField(wireName: r'productId')
  int? get productId;

  @BuiltValueField(wireName: r'productName')
  String? get productName;

  @BuiltValueField(wireName: r'productModel')
  String? get productModel;

  @BuiltValueField(wireName: r'transferred')
  int? get transferred;

  @BuiltValueField(wireName: r'adminAvailable')
  int? get adminAvailable;

  @BuiltValueField(wireName: r'sellerAvailable')
  int? get sellerAvailable;

  TransferInventoryCount._();

  factory TransferInventoryCount([void updates(TransferInventoryCountBuilder b)]) = _$TransferInventoryCount;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransferInventoryCountBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransferInventoryCount> get serializer => _$TransferInventoryCountSerializer();
}

class _$TransferInventoryCountSerializer implements PrimitiveSerializer<TransferInventoryCount> {
  @override
  final Iterable<Type> types = const [TransferInventoryCount, _$TransferInventoryCount];

  @override
  final String wireName = r'TransferInventoryCount';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransferInventoryCount object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productId != null) {
      yield r'productId';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType(int),
      );
    }
    if (object.productName != null) {
      yield r'productName';
      yield serializers.serialize(
        object.productName,
        specifiedType: const FullType(String),
      );
    }
    if (object.productModel != null) {
      yield r'productModel';
      yield serializers.serialize(
        object.productModel,
        specifiedType: const FullType(String),
      );
    }
    if (object.transferred != null) {
      yield r'transferred';
      yield serializers.serialize(
        object.transferred,
        specifiedType: const FullType(int),
      );
    }
    if (object.adminAvailable != null) {
      yield r'adminAvailable';
      yield serializers.serialize(
        object.adminAvailable,
        specifiedType: const FullType(int),
      );
    }
    if (object.sellerAvailable != null) {
      yield r'sellerAvailable';
      yield serializers.serialize(
        object.sellerAvailable,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TransferInventoryCount object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransferInventoryCountBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'productId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productId = valueDes;
          break;
        case r'productName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productName = valueDes;
          break;
        case r'productModel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productModel = valueDes;
          break;
        case r'transferred':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.transferred = valueDes;
          break;
        case r'adminAvailable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.adminAvailable = valueDes;
          break;
        case r'sellerAvailable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sellerAvailable = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransferInventoryCount deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransferInventoryCountBuilder();
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

