//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReturnProduct {
  /// Returns a new [ReturnProduct] instance.
  ReturnProduct({
    this.id,
    this.transactionId,
    this.productId,
    this.serialNumber,
    this.reason,
    this.returnType,
    this.returnById,
    this.returnToId,
    this.createdAt,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  String? transactionId;

  String? productId;

  String? serialNumber;

  String? reason;

  String? returnType;

  String? returnById;

  String? returnToId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReturnProduct &&
    other.id == id &&
    other.transactionId == transactionId &&
    other.productId == productId &&
    other.serialNumber == serialNumber &&
    other.reason == reason &&
    other.returnType == returnType &&
    other.returnById == returnById &&
    other.returnToId == returnToId &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (transactionId == null ? 0 : transactionId!.hashCode) +
    (productId == null ? 0 : productId!.hashCode) +
    (serialNumber == null ? 0 : serialNumber!.hashCode) +
    (reason == null ? 0 : reason!.hashCode) +
    (returnType == null ? 0 : returnType!.hashCode) +
    (returnById == null ? 0 : returnById!.hashCode) +
    (returnToId == null ? 0 : returnToId!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'ReturnProduct[id=$id, transactionId=$transactionId, productId=$productId, serialNumber=$serialNumber, reason=$reason, returnType=$returnType, returnById=$returnById, returnToId=$returnToId, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.transactionId != null) {
      json[r'transactionId'] = this.transactionId;
    } else {
      json[r'transactionId'] = null;
    }
    if (this.productId != null) {
      json[r'productId'] = this.productId;
    } else {
      json[r'productId'] = null;
    }
    if (this.serialNumber != null) {
      json[r'serialNumber'] = this.serialNumber;
    } else {
      json[r'serialNumber'] = null;
    }
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    } else {
      json[r'reason'] = null;
    }
    if (this.returnType != null) {
      json[r'returnType'] = this.returnType;
    } else {
      json[r'returnType'] = null;
    }
    if (this.returnById != null) {
      json[r'returnById'] = this.returnById;
    } else {
      json[r'returnById'] = null;
    }
    if (this.returnToId != null) {
      json[r'returnToId'] = this.returnToId;
    } else {
      json[r'returnToId'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    return json;
  }

  /// Returns a new [ReturnProduct] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReturnProduct? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return ReturnProduct(
        id: mapValueOfType<String>(json, r'id'),
        transactionId: mapValueOfType<String>(json, r'transactionId'),
        productId: mapValueOfType<String>(json, r'productId'),
        serialNumber: mapValueOfType<String>(json, r'serialNumber'),
        reason: mapValueOfType<String>(json, r'reason'),
        returnType: mapValueOfType<String>(json, r'returnType'),
        returnById: mapValueOfType<String>(json, r'returnById'),
        returnToId: mapValueOfType<String>(json, r'returnToId'),
        createdAt: mapDateTime(json, r'createdAt', r''),
      );
    }
    return null;
  }

  static List<ReturnProduct> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReturnProduct>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReturnProduct.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReturnProduct> mapFromJson(dynamic json) {
    final map = <String, ReturnProduct>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReturnProduct.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReturnProduct-objects as value to a dart map
  static Map<String, List<ReturnProduct>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReturnProduct>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReturnProduct.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

