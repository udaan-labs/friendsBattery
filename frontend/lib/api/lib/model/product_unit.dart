//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductUnit {
  /// Returns a new [ProductUnit] instance.
  ProductUnit({
    this.id,
    this.productId,
    this.ownerId,
    this.serialNumber,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? productId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? ownerId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? serialNumber;

  ProductUnitStatusEnum? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductUnit &&
    other.id == id &&
    other.productId == productId &&
    other.ownerId == ownerId &&
    other.serialNumber == serialNumber &&
    other.status == status &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (productId == null ? 0 : productId!.hashCode) +
    (ownerId == null ? 0 : ownerId!.hashCode) +
    (serialNumber == null ? 0 : serialNumber!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode);

  @override
  String toString() => 'ProductUnit[id=$id, productId=$productId, ownerId=$ownerId, serialNumber=$serialNumber, status=$status, createdAt=$createdAt, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.productId != null) {
      json[r'productId'] = this.productId;
    } else {
      json[r'productId'] = null;
    }
    if (this.ownerId != null) {
      json[r'ownerId'] = this.ownerId;
    } else {
      json[r'ownerId'] = null;
    }
    if (this.serialNumber != null) {
      json[r'serialNumber'] = this.serialNumber;
    } else {
      json[r'serialNumber'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt!.toUtc().toIso8601String();
    } else {
      json[r'updatedAt'] = null;
    }
    return json;
  }

  /// Returns a new [ProductUnit] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductUnit? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return ProductUnit(
        id: mapValueOfType<String>(json, r'id'),
        productId: mapValueOfType<String>(json, r'productId'),
        ownerId: mapValueOfType<String>(json, r'ownerId'),
        serialNumber: mapValueOfType<String>(json, r'serialNumber'),
        status: ProductUnitStatusEnum.fromJson(json[r'status']),
        createdAt: mapDateTime(json, r'createdAt', r''),
        updatedAt: mapDateTime(json, r'updatedAt', r''),
      );
    }
    return null;
  }

  static List<ProductUnit> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductUnit>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductUnit.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductUnit> mapFromJson(dynamic json) {
    final map = <String, ProductUnit>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductUnit.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductUnit-objects as value to a dart map
  static Map<String, List<ProductUnit>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductUnit>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductUnit.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class ProductUnitStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const ProductUnitStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const IN_STOCK = ProductUnitStatusEnum._(r'IN_STOCK');
  static const IN_TRANSIT = ProductUnitStatusEnum._(r'IN_TRANSIT');
  static const SOLD = ProductUnitStatusEnum._(r'SOLD');
  static const RETURNED = ProductUnitStatusEnum._(r'RETURNED');
  static const DEFECTIVE = ProductUnitStatusEnum._(r'DEFECTIVE');

  /// List of all possible values in this [enum][ProductUnitStatusEnum].
  static const values = <ProductUnitStatusEnum>[
    IN_STOCK,
    IN_TRANSIT,
    SOLD,
    RETURNED,
    DEFECTIVE,
  ];

  static ProductUnitStatusEnum? fromJson(dynamic value) => ProductUnitStatusEnumTypeTransformer().decode(value);

  static List<ProductUnitStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductUnitStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductUnitStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductUnitStatusEnum] to String,
/// and [decode] dynamic data back to [ProductUnitStatusEnum].
class ProductUnitStatusEnumTypeTransformer {
  factory ProductUnitStatusEnumTypeTransformer() => _instance ??= const ProductUnitStatusEnumTypeTransformer._();

  const ProductUnitStatusEnumTypeTransformer._();

  String encode(ProductUnitStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a ProductUnitStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductUnitStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'IN_STOCK': return ProductUnitStatusEnum.IN_STOCK;
        case r'IN_TRANSIT': return ProductUnitStatusEnum.IN_TRANSIT;
        case r'SOLD': return ProductUnitStatusEnum.SOLD;
        case r'RETURNED': return ProductUnitStatusEnum.RETURNED;
        case r'DEFECTIVE': return ProductUnitStatusEnum.DEFECTIVE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ProductUnitStatusEnumTypeTransformer] instance.
  static ProductUnitStatusEnumTypeTransformer? _instance;
}


