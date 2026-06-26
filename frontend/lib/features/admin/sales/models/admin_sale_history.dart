class AdminShipmentInfo {
  final int id;
  final String shipmentNumber;
  final DateTime? shipmentDate;
  final DateTime? arrivalDate;
  final String status;

  AdminShipmentInfo({
    required this.id,
    required this.shipmentNumber,
    this.shipmentDate,
    this.arrivalDate,
    required this.status,
  });

  factory AdminShipmentInfo.fromJson(Map<String, dynamic> json) {
    return AdminShipmentInfo(
      id: json['id'] ?? 0,
      shipmentNumber: json['shipment_number'] ?? '',
      shipmentDate: json['shipment_date'] != null
          ? DateTime.tryParse(json['shipment_date'])
          : null,
      arrivalDate: json['arrival_date'] != null
          ? DateTime.tryParse(json['arrival_date'])
          : null,
      status: json['status'] ?? '',
    );
  }
}

class AdminSaleHistory {
  final int id;
  final DateTime soldAt;
  final int quantity;
  final double sellPrice;
  final String serialNumber;
  final String? vehicleNumber;

  // Seller
  final int sellerId;
  final String userName;
  final String shopName;

  // Customer
  final String? customerName;
  final String? customerPhone;

  // Product
  final String? productGroup;
  final String category;
  final String productModel;
  final String productName;

  // Shipment (optional)
  final AdminShipmentInfo? shipment;

  AdminSaleHistory({
    required this.id,
    required this.soldAt,
    required this.quantity,
    required this.sellPrice,
    required this.serialNumber,
    this.vehicleNumber,
    required this.sellerId,
    required this.userName,
    required this.shopName,
    this.customerName,
    this.customerPhone,
    this.productGroup,
    required this.category,
    required this.productModel,
    required this.productName,
    this.shipment,
  });

  factory AdminSaleHistory.fromJson(Map<String, dynamic> json) {
    final seller = json['seller'] as Map<String, dynamic>? ?? {};
    final customer = json['customer'] as Map<String, dynamic>? ?? {};
    final product = json['product'] as Map<String, dynamic>? ?? {};
    final shipmentJson = json['shipment'] as Map<String, dynamic>?;

    return AdminSaleHistory(
      id: json['id'] ?? 0,
      soldAt: DateTime.tryParse(json['sold_at'] ?? '') ?? DateTime.now(),
      quantity: json['quantity'] ?? 1,
      sellPrice:
          double.tryParse(json['sell_price']?.toString() ?? '0') ?? 0.0,
      serialNumber: json['serial_number'] ?? 'N/A',
      vehicleNumber: json['vehicle_number'],
      sellerId: seller['id'] ?? 0,
      userName: seller['user_name'] ?? 'Unknown',
      shopName: seller['shop_name'] ?? 'Unknown',
      customerName: customer['name'],
      customerPhone: customer['phone'],
      productGroup: product['group'],
      category: product['category'] ?? 'Unknown',
      productModel: product['product_model'] ?? 'Unknown',
      productName: product['product_name'] ?? 'Unknown',
      shipment: shipmentJson != null
          ? AdminShipmentInfo.fromJson(shipmentJson)
          : null,
    );
  }
}

class AdminSalesHistoryPage {
  final List<AdminSaleHistory> data;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  AdminSalesHistoryPage({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory AdminSalesHistoryPage.fromJson(Map<String, dynamic> json) {
    final rawList = json['data'] as List<dynamic>? ?? [];
    return AdminSalesHistoryPage(
      data: rawList
          .whereType<Map<String, dynamic>>()
          .map(AdminSaleHistory.fromJson)
          .toList(),
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      totalPages: json['total_pages'] ?? 1,
    );
  }
}
