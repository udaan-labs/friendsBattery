//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SalesTransaction {
  /// Returns a new [SalesTransaction] instance.
  SalesTransaction({
    this.id,
    this.productId,
    this.customerId,
    this.sellerId,
    this.sellPrice,
    this.serialNumber,
    this.productReplacedId,
    this.soldAt,
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

  String? customerId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? sellerId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? sellPrice;

  String? serialNumber;

  String? productReplacedId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? soldAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SalesTransaction &&
    other.id == id &&
    other.productId == productId &&
    other.customerId == customerId &&
    other.sellerId == sellerId &&
    other.sellPrice == sellPrice &&
    other.serialNumber == serialNumber &&
    other.productReplacedId == productReplacedId &&
    other.soldAt == soldAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (productId == null ? 0 : productId!.hashCode) +
    (customerId == null ? 0 : customerId!.hashCode) +
    (sellerId == null ? 0 : sellerId!.hashCode) +
    (sellPrice == null ? 0 : sellPrice!.hashCode) +
    (serialNumber == null ? 0 : serialNumber!.hashCode) +
    (productReplacedId == null ? 0 : productReplacedId!.hashCode) +
    (soldAt == null ? 0 : soldAt!.hashCode);

  @override
  String toString() => 'SalesTransaction[id=$id, productId=$productId, customerId=$customerId, sellerId=$sellerId, sellPrice=$sellPrice, serialNumber=$serialNumber, productReplacedId=$productReplacedId, soldAt=$soldAt]';

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
    if (this.customerId != null) {
      json[r'customerId'] = this.customerId;
    } else {
      json[r'customerId'] = null;
    }
    if (this.sellerId != null) {
      json[r'sellerId'] = this.sellerId;
    } else {
      json[r'sellerId'] = null;
    }
    if (this.sellPrice != null) {
      json[r'sellPrice'] = this.sellPrice;
    } else {
      json[r'sellPrice'] = null;
    }
    if (this.serialNumber != null) {
      json[r'serialNumber'] = this.serialNumber;
    } else {
      json[r'serialNumber'] = null;
    }
    if (this.productReplacedId != null) {
      json[r'productReplacedId'] = this.productReplacedId;
    } else {
      json[r'productReplacedId'] = null;
    }
    if (this.soldAt != null) {
      json[r'soldAt'] = this.soldAt!.toUtc().toIso8601String();
    } else {
      json[r'soldAt'] = null;
    }
    return json;
  }

  /// Returns a new [SalesTransaction] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SalesTransaction? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return SalesTransaction(
        id: mapValueOfType<String>(json, r'id'),
        productId: mapValueOfType<String>(json, r'productId'),
        customerId: mapValueOfType<String>(json, r'customerId'),
        sellerId: mapValueOfType<String>(json, r'sellerId'),
        sellPrice: mapValueOfType<double>(json, r'sellPrice'),
        serialNumber: mapValueOfType<String>(json, r'serialNumber'),
        productReplacedId: mapValueOfType<String>(json, r'productReplacedId'),
        soldAt: mapDateTime(json, r'soldAt', r''),
      );
    }
    return null;
  }

  static List<SalesTransaction> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SalesTransaction>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SalesTransaction.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SalesTransaction> mapFromJson(dynamic json) {
    final map = <String, SalesTransaction>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SalesTransaction.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SalesTransaction-objects as value to a dart map
  static Map<String, List<SalesTransaction>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SalesTransaction>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SalesTransaction.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

