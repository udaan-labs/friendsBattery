import 'package:friends_battery_api/friends_battery_api.dart';
import '../models/seller_sale.dart';

class SellerSalesRepository {
  final FriendsBatteryApi _api;

  SellerSalesRepository({required FriendsBatteryApi api}) : _api = api;

  SalesApi get _sales => _api.getSalesApi();
  InventoryApi get _inventory => _api.getInventoryApi();

  SellerSale _mapSale(SaleRecord s) {
    return SellerSale(
      id: s.id ?? 0,
      productName: s.product?.productName ?? 'Unknown Product',
      productModel: s.product?.productModel ?? 'Unknown Model',
      serialNumber: s.serialNumber ?? 'N/A',
      quantity: s.quantity ?? 1,
      sellPrice: (s.sellPrice ?? 0).toDouble(),
      soldAt: s.soldAt ?? DateTime.now(),
      customerName: s.customer?.name,
      customerPhone: s.customer?.phone,
      saleType: s.saleType?.name ?? 'NORMAL',
      paymentMode: s.paymentMode?.name ?? 'CASH',
      amountPaid: (s.amountPaid ?? 0).toDouble(),
      amountDue: (s.amountDue ?? 0).toDouble(),
      rentStatus: s.rentStatus,
      scrapSerial: s.scrapSerial,
    );
  }

  Future<List<SellerSale>> getSalesHistory({
    String? searchCustomer,
    String? searchSerial,
    String filter = 'today',
    String? date,
    String? paymentMode,
    bool unpaid = false,
    int page = 1,
    int limit = 50,
  }) async {
    final response = await _sales.apiSalesHistoryGet(
      page: page,
      limit: limit,
      searchCustomer: (searchCustomer != null && searchCustomer.isNotEmpty)
          ? searchCustomer
          : null,
      searchSerial:
          (searchSerial != null && searchSerial.isNotEmpty) ? searchSerial : null,
      filter: filter,
      date: (date != null && date.isNotEmpty) ? date : null,
      paymentMode: paymentMode,
      unpaid: unpaid ? true : null,
    );

    final rows = response.data?.data?.data?.toList() ?? [];
    return rows.map(_mapSale).toList();
  }

  Future<SellerSale> getSaleById(int id) async {
    final response = await _sales.apiSalesTransactionIdGet(transactionId: id);
    final d = response.data?.data;
    if (d == null) {
      throw Exception(response.data?.message ?? 'Failed to fetch sale details');
    }
    return _mapSale(d);
  }

  Future<ScanForSaleResult> scanForSale(String serialNumber) async {
    final response = await _inventory.apiInventoryScanForSaleGet(
      serialNumber: serialNumber,
    );
    final d = response.data?.data;
    if (d == null) {
      throw Exception(response.data?.message ?? 'Product not found');
    }
    return d;
  }

  Future<int> createSale({
    required int productNameId,
    required int productModelId,
    required String serialNumber,
    required String customerName,
    required String customerNumber,
    String? vehicleNumber,
    required num sellPrice,
    String saleType = 'NORMAL',
    String paymentMode = 'CASH',
    num? amountPaid,
    String? scrapSerial,
  }) async {
    final body = CreateSaleRequest((b) {
      b.productNameId = productNameId;
      b.productModelId = productModelId;
      b.serialNumber = serialNumber;
      b.customerName = customerName;
      b.customerNumber = customerNumber;
      if (vehicleNumber != null && vehicleNumber.isNotEmpty) {
        b.vehicleNumber = vehicleNumber;
      }
      b.sellPrice = sellPrice;
      b.saleType = CreateSaleRequestSaleTypeEnum.valueOf(saleType);
      b.paymentMode = CreateSaleRequestPaymentModeEnum.valueOf(paymentMode);
      if (amountPaid != null) {
        b.amountPaid = amountPaid;
      }
      if (scrapSerial != null && scrapSerial.isNotEmpty) {
        b.scrapSerial = scrapSerial;
      }
    });

    final response = await _sales.apiSalesPost(createSaleRequest: body);
    return response.data?.data?.transactionId ?? 0;
  }

  Future<int> createServiceBill({
    required String serviceType,
    required num amount,
    required String customerName,
    required String customerNumber,
    String? vehicleNumber,
    String? place,
    String paymentMode = 'CASH',
  }) async {
    final body = CreateServiceBillRequest((b) {
      b.serviceType =
          CreateServiceBillRequestServiceTypeEnum.valueOf(serviceType);
      b.amount = amount;
      b.customerName = customerName;
      b.customerNumber = customerNumber;
      if (vehicleNumber != null && vehicleNumber.isNotEmpty) {
        b.vehicleNumber = vehicleNumber;
      }
      if (place != null && place.isNotEmpty) {
        b.place = place;
      }
      b.paymentMode = CreateServiceBillRequestPaymentModeEnum.valueOf(paymentMode);
    });

    final response =
        await _sales.apiSalesServicePost(createServiceBillRequest: body);
    return response.data?.data?.serviceBillId ?? 0;
  }

  Future<CreateRentResult> createRent({
    required String serialNumber,
    required String customerName,
    required String customerNumber,
    required num deposit,
    String paymentMode = 'CASH',
  }) async {
    final body = CreateRentRequest((b) {
      b.serialNumber = serialNumber;
      b.customerName = customerName;
      b.customerNumber = customerNumber;
      b.deposit = deposit;
      b.paymentMode = CreateRentRequestPaymentModeEnum.valueOf(paymentMode);
    });
    final response = await _sales.apiSalesRentPost(createRentRequest: body);
    final d = response.data?.data;
    if (d == null) {
      throw Exception(response.data?.message ?? 'Failed to rent battery');
    }
    return d;
  }

  Future<ReturnRentResult> returnRent({
    required String serialNumber,
    required num rentFee,
  }) async {
    final body = ReturnRentRequest((b) {
      b.serialNumber = serialNumber;
      b.rentFee = rentFee;
    });
    final response =
        await _sales.apiSalesRentReturnPost(returnRentRequest: body);
    final d = response.data?.data;
    if (d == null) {
      throw Exception(response.data?.message ?? 'Failed to return rent');
    }
    return d;
  }

  Future<SellerSale> payCredit({
    required int saleId,
    required num amount,
  }) async {
    final body = PayCreditRequest((b) {
      b.amount = amount;
    });
    final response = await _sales.apiSalesTransactionIdPayPost(
      transactionId: saleId,
      payCreditRequest: body,
    );
    final d = response.data?.data;
    if (d == null) {
      throw Exception(response.data?.message ?? 'Failed to record payment');
    }
    return _mapSale(d);
  }
}
