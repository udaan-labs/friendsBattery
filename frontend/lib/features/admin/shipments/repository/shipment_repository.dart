import 'package:dio/dio.dart';

// ─── Seller Model ────────────────────────────────────────────────────────────

class SellerModel {
  final int id;
  final String userName;
  final String shopName;
  final String userNumber;

  SellerModel({
    required this.id,
    required this.userName,
    required this.shopName,
    required this.userNumber,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) {
    return SellerModel(
      id: _parseInt(json['id']),
      userName: json['user_name'] as String? ?? json['userName'] as String? ?? '',
      shopName: json['shop_name'] as String? ?? json['shopName'] as String? ?? '',
      userNumber: json['user_number'] as String? ?? json['userNumber'] as String? ?? '',
    );
  }

  static int _parseInt(dynamic v) {
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? 0;
    if (v is double) return v.toInt();
    return 0;
  }
}

// ─── Shipment Summary Model (Admin list) ─────────────────────────────────────

class ShipmentSummaryModel {
  final int shipmentId;
  final String shipmentNumber;
  final String sellerName;
  final String shopName;
  final String status;
  final int totalProducts;
  final int totalQuantity;
  final DateTime createdAt;
  final DateTime? acceptedAt;

  ShipmentSummaryModel({
    required this.shipmentId,
    required this.shipmentNumber,
    required this.sellerName,
    required this.shopName,
    required this.status,
    required this.totalProducts,
    required this.totalQuantity,
    required this.createdAt,
    this.acceptedAt,
  });

  factory ShipmentSummaryModel.fromJson(Map<String, dynamic> json) {
    final seller = json['seller'] as Map<String, dynamic>? ?? {};
    return ShipmentSummaryModel(
      shipmentId: _parseInt(json['shipmentId']),
      shipmentNumber: json['shipmentNumber'] as String? ?? '',
      sellerName: seller['userName'] as String? ?? '',
      shopName: seller['shopName'] as String? ?? '',
      status: json['status'] as String? ?? '',
      totalProducts: _parseInt(json['totalProducts']),
      totalQuantity: _parseInt(json['totalQuantity']),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
      acceptedAt: json['acceptedAt'] != null
          ? DateTime.tryParse(json['acceptedAt'] as String)
          : null,
    );
  }

  static int _parseInt(dynamic v) {
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? 0;
    if (v is double) return v.toInt();
    return 0;
  }
}

// ─── Shipment Item Detail Model ───────────────────────────────────────────────

class ShipmentItemDetailModel {
  final int id;
  final String category;
  final String productGroup;
  final String productName;
  final String productModel;
  final int quantity;
  final String? serialNumber;

  ShipmentItemDetailModel({
    required this.id,
    required this.category,
    required this.productGroup,
    required this.productName,
    required this.productModel,
    required this.quantity,
    this.serialNumber,
  });

  factory ShipmentItemDetailModel.fromJson(Map<String, dynamic> json) {
    return ShipmentItemDetailModel(
      id: _parseInt(json['id']),
      category: json['category'] as String? ?? '',
      productGroup: json['productGroup'] as String? ?? '',
      productName: json['productName'] as String? ?? '',
      productModel: json['productModel'] as String? ?? '',
      quantity: _parseInt(json['quantity']),
      serialNumber: json['serialNumber'] as String?,
    );
  }

  static int _parseInt(dynamic v) {
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? 0;
    if (v is double) return v.toInt();
    return 0;
  }
}

// ─── Shipment Detail Model ────────────────────────────────────────────────────

class ShipmentDetailModel {
  final int shipmentId;
  final String shipmentNumber;
  final String status;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final int sellerId;
  final String sellerUserName;
  final String sellerShopName;
  final String? sellerPhone;
  final int totalProducts;
  final int totalQuantity;
  final List<ShipmentItemDetailModel> items;

  ShipmentDetailModel({
    required this.shipmentId,
    required this.shipmentNumber,
    required this.status,
    required this.createdAt,
    this.acceptedAt,
    required this.sellerId,
    required this.sellerUserName,
    required this.sellerShopName,
    this.sellerPhone,
    required this.totalProducts,
    required this.totalQuantity,
    required this.items,
  });

  factory ShipmentDetailModel.fromJson(Map<String, dynamic> json) {
    final seller = json['seller'] as Map<String, dynamic>? ?? {};
    final rawItems = json['items'] as List<dynamic>? ?? [];
    return ShipmentDetailModel(
      shipmentId: _parseInt(json['shipmentId']),
      shipmentNumber: json['shipmentNumber'] as String? ?? '',
      status: json['status'] as String? ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
      acceptedAt: json['acceptedAt'] != null
          ? DateTime.tryParse(json['acceptedAt'] as String)
          : null,
      sellerId: _parseInt(seller['id']),
      sellerUserName: seller['userName'] as String? ?? '',
      sellerShopName: seller['shopName'] as String? ?? '',
      sellerPhone: seller['userNumber'] as String?,
      totalProducts: _parseInt(json['totalProducts']),
      totalQuantity: _parseInt(json['totalQuantity']),
      items: rawItems
          .whereType<Map<String, dynamic>>()
          .map(ShipmentItemDetailModel.fromJson)
          .toList(),
    );
  }

  static int _parseInt(dynamic v) {
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? 0;
    if (v is double) return v.toInt();
    return 0;
  }
}

// ─── Repository ───────────────────────────────────────────────────────────────

class ShipmentRepository {
  final Dio _dio;

  ShipmentRepository({required Dio dio}) : _dio = dio;

  Future<List<ShipmentSummaryModel>> getShipments() async {
    final response = await _dio.get('/api/shipments');
    final body = response.data;
    final data = (body is Map && body['data'] != null) ? body['data'] : [];
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(ShipmentSummaryModel.fromJson)
          .toList();
    }
    return [];
  }

  Future<ShipmentDetailModel> getShipmentById(int id) async {
    final response = await _dio.get('/api/shipments/$id');
    final body = response.data;
    final data = (body is Map && body['data'] != null)
        ? body['data'] as Map<String, dynamic>
        : body as Map<String, dynamic>;
    return ShipmentDetailModel.fromJson(data);
  }

  Future<List<SellerModel>> getSellers() async {
    final response = await _dio.get('/api/shops/sellers');
    final body = response.data;
    if (body is Map && body['data'] is List) {
      final list = body['data'] as List;
      final List<SellerModel> sellers = [];
      for (var item in list) {
        if (item is Map<String, dynamic>) {
          sellers.add(SellerModel.fromJson(item));
        } else if (item is Map) {
          sellers.add(SellerModel.fromJson(Map<String, dynamic>.from(item)));
        }
      }
      return sellers;
    }
    return [];
  }

  /// Create a new shipment (Admin only).
  /// [items] each item must have: productCategoryId, productNameId,
  /// productModelId, productId, productItemId, quantity.
  Future<void> createShipment({
    required int sellerId,
    required List<Map<String, dynamic>> items,
  }) async {
    await _dio.post('/api/shipments', data: {
      'sellerId': sellerId,
      'items': items,
    });
  }
}
