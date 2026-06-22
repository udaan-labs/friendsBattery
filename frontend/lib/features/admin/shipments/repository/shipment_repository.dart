import 'package:friends_battery_api/friends_battery_api.dart';

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
      id: json['id'] as int,
      userName: json['user_name'] as String? ?? '',
      shopName: json['shop_name'] as String? ?? '',
      userNumber: json['user_number'] as String? ?? '',
    );
  }
}

class ShipmentSummaryModel {
  final int shipmentId;
  final String sellerName;
  final String shopName;
  final String status;
  final int totalProducts;
  final double totalAmount;
  final DateTime createdAt;

  ShipmentSummaryModel({
    required this.shipmentId,
    required this.sellerName,
    required this.shopName,
    required this.status,
    required this.totalProducts,
    required this.totalAmount,
    required this.createdAt,
  });

  factory ShipmentSummaryModel.fromJson(Map<String, dynamic> json) {
    final amountVal = json['total_amount'];
    double parsedAmount = 0.0;
    if (amountVal is num) {
      parsedAmount = amountVal.toDouble();
    } else if (amountVal is String) {
      parsedAmount = double.tryParse(amountVal) ?? 0.0;
    }

    return ShipmentSummaryModel(
      shipmentId: json['shipment_id'] as int,
      sellerName: json['seller_name'] as String? ?? '',
      shopName: json['shop_name'] as String? ?? '',
      status: json['status'] as String? ?? '',
      totalProducts: json['total_products'] as int? ?? 0,
      totalAmount: parsedAmount,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

class ShipmentRepository {
  final ShopsApi _shopsApi;
  final TransfersApi _transfersApi;

  ShipmentRepository({
    required ShopsApi shopsApi,
    required TransfersApi transfersApi,
  })  : _shopsApi = shopsApi,
        _transfersApi = transfersApi;

  Future<List<SellerModel>> getSellers() async {
    final response = await _shopsApi.apiShopsSellersGet();
    final data = (response as dynamic).data;
    if (data is Map<String, dynamic> && data['data'] is List) {
      final list = data['data'] as List;
      return list.map((item) => SellerModel.fromJson(item as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<List<ShipmentSummaryModel>> getShipments() async {
    final response = await _transfersApi.apiTransfersGet();
    final data = (response as dynamic).data;
    if (data is Map<String, dynamic> && data['data'] is List) {
      final list = data['data'] as List;
      return list.map((item) => ShipmentSummaryModel.fromJson(item as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<void> createShipment({
    required int sellerId,
    required List<Map<String, dynamic>> items,
  }) async {
    final itemsList = items.map((item) {
      return ApiTransfersPostRequestItemsInner((b) => b
        ..productId = item['product_id'] as int
        ..quantity = item['quantity'] as int
        ..pricePerPiece = item['price_per_piece'] as num
      );
    }).toList();

    final request = ApiTransfersPostRequest((b) => b
      ..sellerId = sellerId
      ..items.addAll(itemsList)
    );

    await _transfersApi.apiTransfersPost(
      apiTransfersPostRequest: request,
    );
  }
}
