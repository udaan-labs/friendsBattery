/// UI presentation models for admin sales history.
///
/// Populated only by mapping OpenAPI [AdminSaleRecord] in [AdminSalesRepository].
/// Do not add JSON/fromJson parsing here — API DTOs live in `friends_battery_api`.
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

  final String saleType;
  final String? scrapSerial;
  final String? serviceType;
  final String? rentStatus;
  final double? deposit;
  final String? place;

  // Shipment (optional)
  final AdminShipmentInfo? shipment;

  AdminSaleHistory({
    required this.id,
    required this.soldAt,
    required this.quantity,
    required this.sellPrice,
    required this.serialNumber,
    this.vehicleNumber,
    this.saleType = 'NORMAL',
    this.scrapSerial,
    this.serviceType,
    this.rentStatus,
    this.deposit,
    this.place,
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
}
