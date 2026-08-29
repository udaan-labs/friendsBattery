import '../../../../shared/utils/bill_display.dart';

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
  final String saleType;
  final String paymentMode;
  final double amountPaid;
  final double amountDue;
  final String? rentStatus;
  final String? scrapSerial;

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
    this.saleType = 'NORMAL',
    this.paymentMode = 'CASH',
    this.amountPaid = 0,
    this.amountDue = 0,
    this.rentStatus,
    this.scrapSerial,
  });

  String get billNumber =>
      billNumberFor(id: id, saleType: saleType, rentStatus: rentStatus);

  bool get hasUnitSerial => billHasUnitSerial(saleType);

  bool get hasCreditDue => billHasCreditDue(
        paymentMode: paymentMode,
        saleType: saleType,
        amountDue: amountDue,
      );

  String get paymentLabel => billPaymentLabel(
        paymentMode: paymentMode,
        hasCreditDue: hasCreditDue,
        amountDue: amountDue,
      );
}
