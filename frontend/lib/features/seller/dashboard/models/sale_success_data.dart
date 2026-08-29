/// Local navigation payload for the post-sale invoice screen (not an API DTO).
class SaleSuccessData {
  final String customerName;
  final String customerNumber;
  final String productName;
  final String serialNumber;
  final double sellPrice;
  final String invoiceNumber;
  final DateTime saleDate;
  final String sellerName;
  final String paymentMode;
  final double? amountPaid;

  const SaleSuccessData({
    required this.customerName,
    required this.customerNumber,
    required this.productName,
    required this.serialNumber,
    required this.sellPrice,
    required this.invoiceNumber,
    required this.saleDate,
    required this.sellerName,
    this.paymentMode = 'CASH',
    this.amountPaid,
  });

  bool get isCredit => paymentMode.toUpperCase() == 'CREDIT';
  double get paid => amountPaid ?? (isCredit ? 0 : sellPrice);
  double get due => isCredit ? (sellPrice - paid).clamp(0, sellPrice) : 0;
}
