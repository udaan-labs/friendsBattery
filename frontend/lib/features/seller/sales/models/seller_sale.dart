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

  factory SellerSale.fromJson(Map<String, dynamic> json) {
    return SellerSale(
      id: json['id'] ?? 0,
      productName: json['product']?['product_name'] ?? json['product_name'] ?? json['productName'] ?? 'Unknown Product',
      productModel: json['product']?['product_model'] ?? json['product_model'] ?? json['productModel'] ?? 'Unknown Model',
      serialNumber: json['serial_number'] ?? json['serialNumber'] ?? 'N/A',
      quantity: json['quantity'] ?? 1,
      sellPrice: double.tryParse(json['sell_price']?.toString() ?? json['sellPrice']?.toString() ?? '0') ?? 0.0,
      soldAt: DateTime.tryParse(json['sold_at'] ?? json['soldAt'] ?? '') ?? DateTime.now(),
      customerName: json['customer']?['name'] ?? json['customer_name'] ?? json['customerName'],
      customerPhone: json['customer']?['phone'] ?? json['customer']?['phone_number'] ?? json['customer_number'] ?? json['customer_phone'] ?? json['customerPhone'],
    );
  }
}
