//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiAuthRegisterPostRequest {
  /// Returns a new [ApiAuthRegisterPostRequest] instance.
  ApiAuthRegisterPostRequest({
    required this.userId,
    required this.username,
    required this.userNumber,
    required this.shopName,
    required this.password,
  });

  String userId;

  String username;

  String userNumber;

  String shopName;

  String password;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ApiAuthRegisterPostRequest &&
    other.userId == userId &&
    other.username == username &&
    other.userNumber == userNumber &&
    other.shopName == shopName &&
    other.password == password;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (userId.hashCode) +
    (username.hashCode) +
    (userNumber.hashCode) +
    (shopName.hashCode) +
    (password.hashCode);

  @override
  String toString() => 'ApiAuthRegisterPostRequest[userId=$userId, username=$username, userNumber=$userNumber, shopName=$shopName, password=$password]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'user_id'] = this.userId;
      json[r'username'] = this.username;
      json[r'user_number'] = this.userNumber;
      json[r'shop_name'] = this.shopName;
      json[r'password'] = this.password;
    return json;
  }

  /// Returns a new [ApiAuthRegisterPostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApiAuthRegisterPostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'user_id'), 'Required key "ApiAuthRegisterPostRequest[user_id]" is missing from JSON.');
        assert(json[r'user_id'] != null, 'Required key "ApiAuthRegisterPostRequest[user_id]" has a null value in JSON.');
        assert(json.containsKey(r'username'), 'Required key "ApiAuthRegisterPostRequest[username]" is missing from JSON.');
        assert(json[r'username'] != null, 'Required key "ApiAuthRegisterPostRequest[username]" has a null value in JSON.');
        assert(json.containsKey(r'user_number'), 'Required key "ApiAuthRegisterPostRequest[user_number]" is missing from JSON.');
        assert(json[r'user_number'] != null, 'Required key "ApiAuthRegisterPostRequest[user_number]" has a null value in JSON.');
        assert(json.containsKey(r'shop_name'), 'Required key "ApiAuthRegisterPostRequest[shop_name]" is missing from JSON.');
        assert(json[r'shop_name'] != null, 'Required key "ApiAuthRegisterPostRequest[shop_name]" has a null value in JSON.');
        assert(json.containsKey(r'password'), 'Required key "ApiAuthRegisterPostRequest[password]" is missing from JSON.');
        assert(json[r'password'] != null, 'Required key "ApiAuthRegisterPostRequest[password]" has a null value in JSON.');
        return true;
      }());

      return ApiAuthRegisterPostRequest(
        userId: mapValueOfType<String>(json, r'user_id')!,
        username: mapValueOfType<String>(json, r'username')!,
        userNumber: mapValueOfType<String>(json, r'user_number')!,
        shopName: mapValueOfType<String>(json, r'shop_name')!,
        password: mapValueOfType<String>(json, r'password')!,
      );
    }
    return null;
  }

  static List<ApiAuthRegisterPostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApiAuthRegisterPostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiAuthRegisterPostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApiAuthRegisterPostRequest> mapFromJson(dynamic json) {
    final map = <String, ApiAuthRegisterPostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApiAuthRegisterPostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApiAuthRegisterPostRequest-objects as value to a dart map
  static Map<String, List<ApiAuthRegisterPostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ApiAuthRegisterPostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApiAuthRegisterPostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'user_id',
    'username',
    'user_number',
    'shop_name',
    'password',
  };
}

