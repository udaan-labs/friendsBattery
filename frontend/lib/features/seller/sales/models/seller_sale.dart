/// UI presentation model for seller sales history.
///
/// Populated only by mapping OpenAPI [SaleRecord] in [SellerSalesRepository].
/// Do not add JSON/fromJson parsing here — API DTOs live in `friends_battery_api`.
class SellerSale {
  final int id;
  final String productName;
  final String productModel;
  final String serialNumber;
  final int quantity;
  final double sellPrice;
  final DateTime soldAt;
  final String? customerName;
  final String? customerPhone;

  SellerSale({
    required this.id,
    required this.productName,
    required this.productModel,
    required this.serialNumber,
    required this.quantity,
    required this.sellPrice,
    required this.soldAt,
    this.customerName,
    this.customerPhone,
  });
}
