//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StockRequestItem {
  /// Returns a new [StockRequestItem] instance.
  StockRequestItem({
    this.id,
    this.stockRequestId,
    this.productId,
    this.requestedQuantity,
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
  String? stockRequestId;

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
  int? requestedQuantity;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StockRequestItem &&
    other.id == id &&
    other.stockRequestId == stockRequestId &&
    other.productId == productId &&
    other.requestedQuantity == requestedQuantity;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (stockRequestId == null ? 0 : stockRequestId!.hashCode) +
    (productId == null ? 0 : productId!.hashCode) +
    (requestedQuantity == null ? 0 : requestedQuantity!.hashCode);

  @override
  String toString() => 'StockRequestItem[id=$id, stockRequestId=$stockRequestId, productId=$productId, requestedQuantity=$requestedQuantity]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.stockRequestId != null) {
      json[r'stockRequestId'] = this.stockRequestId;
    } else {
      json[r'stockRequestId'] = null;
    }
    if (this.productId != null) {
      json[r'productId'] = this.productId;
    } else {
      json[r'productId'] = null;
    }
    if (this.requestedQuantity != null) {
      json[r'requestedQuantity'] = this.requestedQuantity;
    } else {
      json[r'requestedQuantity'] = null;
    }
    return json;
  }

  /// Returns a new [StockRequestItem] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StockRequestItem? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return StockRequestItem(
        id: mapValueOfType<String>(json, r'id'),
        stockRequestId: mapValueOfType<String>(json, r'stockRequestId'),
        productId: mapValueOfType<String>(json, r'productId'),
        requestedQuantity: mapValueOfType<int>(json, r'requestedQuantity'),
      );
    }
    return null;
  }

  static List<StockRequestItem> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StockRequestItem>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StockRequestItem.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StockRequestItem> mapFromJson(dynamic json) {
    final map = <String, StockRequestItem>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StockRequestItem.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StockRequestItem-objects as value to a dart map
  static Map<String, List<StockRequestItem>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StockRequestItem>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StockRequestItem.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

