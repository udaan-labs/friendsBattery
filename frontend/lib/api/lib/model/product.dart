//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Product {
  /// Returns a new [Product] instance.
  Product({
    this.id,
    this.categoryId,
    this.productNameId,
    this.productModelId,
    this.minPrice,
    this.onSale,
    this.offerPrice,
    this.minQuantity,
    this.createdAt,
    this.category,
    this.productName,
    this.productModel,
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
  String? categoryId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? productNameId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? productModelId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? minPrice;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? onSale;

  double? offerPrice;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? minQuantity;

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
  Category? category;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ProductName? productName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ProductModel? productModel;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Product &&
    other.id == id &&
    other.categoryId == categoryId &&
    other.productNameId == productNameId &&
    other.productModelId == productModelId &&
    other.minPrice == minPrice &&
    other.onSale == onSale &&
    other.offerPrice == offerPrice &&
    other.minQuantity == minQuantity &&
    other.createdAt == createdAt &&
    other.category == category &&
    other.productName == productName &&
    other.productModel == productModel;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (categoryId == null ? 0 : categoryId!.hashCode) +
    (productNameId == null ? 0 : productNameId!.hashCode) +
    (productModelId == null ? 0 : productModelId!.hashCode) +
    (minPrice == null ? 0 : minPrice!.hashCode) +
    (onSale == null ? 0 : onSale!.hashCode) +
    (offerPrice == null ? 0 : offerPrice!.hashCode) +
    (minQuantity == null ? 0 : minQuantity!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (category == null ? 0 : category!.hashCode) +
    (productName == null ? 0 : productName!.hashCode) +
    (productModel == null ? 0 : productModel!.hashCode);

  @override
  String toString() => 'Product[id=$id, categoryId=$categoryId, productNameId=$productNameId, productModelId=$productModelId, minPrice=$minPrice, onSale=$onSale, offerPrice=$offerPrice, minQuantity=$minQuantity, createdAt=$createdAt, category=$category, productName=$productName, productModel=$productModel]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.categoryId != null) {
      json[r'categoryId'] = this.categoryId;
    } else {
      json[r'categoryId'] = null;
    }
    if (this.productNameId != null) {
      json[r'productNameId'] = this.productNameId;
    } else {
      json[r'productNameId'] = null;
    }
    if (this.productModelId != null) {
      json[r'productModelId'] = this.productModelId;
    } else {
      json[r'productModelId'] = null;
    }
    if (this.minPrice != null) {
      json[r'minPrice'] = this.minPrice;
    } else {
      json[r'minPrice'] = null;
    }
    if (this.onSale != null) {
      json[r'onSale'] = this.onSale;
    } else {
      json[r'onSale'] = null;
    }
    if (this.offerPrice != null) {
      json[r'offerPrice'] = this.offerPrice;
    } else {
      json[r'offerPrice'] = null;
    }
    if (this.minQuantity != null) {
      json[r'minQuantity'] = this.minQuantity;
    } else {
      json[r'minQuantity'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    if (this.category != null) {
      json[r'category'] = this.category;
    } else {
      json[r'category'] = null;
    }
    if (this.productName != null) {
      json[r'productName'] = this.productName;
    } else {
      json[r'productName'] = null;
    }
    if (this.productModel != null) {
      json[r'productModel'] = this.productModel;
    } else {
      json[r'productModel'] = null;
    }
    return json;
  }

  /// Returns a new [Product] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Product? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return Product(
        id: mapValueOfType<String>(json, r'id'),
        categoryId: mapValueOfType<String>(json, r'categoryId'),
        productNameId: mapValueOfType<String>(json, r'productNameId'),
        productModelId: mapValueOfType<String>(json, r'productModelId'),
        minPrice: mapValueOfType<double>(json, r'minPrice'),
        onSale: mapValueOfType<bool>(json, r'onSale'),
        offerPrice: mapValueOfType<double>(json, r'offerPrice'),
        minQuantity: mapValueOfType<int>(json, r'minQuantity'),
        createdAt: mapDateTime(json, r'createdAt', r''),
        category: Category.fromJson(json[r'category']),
        productName: ProductName.fromJson(json[r'productName']),
        productModel: ProductModel.fromJson(json[r'productModel']),
      );
    }
    return null;
  }

  static List<Product> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Product>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Product.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Product> mapFromJson(dynamic json) {
    final map = <String, Product>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Product.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Product-objects as value to a dart map
  static Map<String, List<Product>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Product>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Product.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

