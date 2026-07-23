import 'package:friends_battery_api/friends_battery_api.dart';
import '../models/admin_sale_history.dart';

class AdminSalesRepository {
  final FriendsBatteryApi _api;

  AdminSalesRepository({required FriendsBatteryApi api}) : _api = api;

  SalesApi get _sales => _api.getSalesApi();

  AdminSaleHistory _mapAdminSale(AdminSaleRecord s) {
    final shipment = s.shipment;
    return AdminSaleHistory(
      id: s.id ?? 0,
      soldAt: s.soldAt ?? DateTime.now(),
      quantity: s.quantity ?? 1,
      sellPrice: (s.sellPrice ?? 0).toDouble(),
      serialNumber: s.serialNumber ?? 'N/A',
      vehicleNumber: s.vehicleNumber,
      sellerId: s.seller?.id ?? 0,
      userName: s.seller?.userName ?? 'Unknown',
      shopName: s.seller?.shopName ?? 'Unknown',
      customerName: s.customer?.name,
      customerPhone: s.customer?.phone,
      productGroup: null,
      category: 'Unknown',
      productModel: s.product?.productModel ?? 'Unknown',
      productName: s.product?.productName ?? 'Unknown',
      shipment: shipment == null
          ? null
          : AdminShipmentInfo(
              id: shipment.id ?? 0,
              shipmentNumber: shipment.shipmentNumber ?? '',
              shipmentDate: shipment.shipmentDate,
              arrivalDate: shipment.arrivalDate,
              status: shipment.status ?? '',
            ),
    );
  }

  Future<AdminSalesHistoryPage> getAdminSalesHistory({
    int page = 1,
    int limit = 10,
    String? search,
    int? sellerId,
    String? fromDate,
    String? toDate,
    String? shipmentStatus,
  }) async {
    final response = await _sales.apiSalesAdminHistoryGet(
      page: page,
      limit: limit,
      search: (search != null && search.isNotEmpty) ? search : null,
      sellerId: sellerId,
      fromDate: (fromDate != null && fromDate.isNotEmpty)
          ? DateTime.tryParse(fromDate)
          : null,
      toDate: (toDate != null && toDate.isNotEmpty) ? DateTime.tryParse(toDate) : null,
      shipmentStatus:
          (shipmentStatus != null && shipmentStatus.isNotEmpty) ? shipmentStatus : null,
    );

    final pageData = response.data?.data;
    final rows = pageData?.data?.toList() ?? [];
    return AdminSalesHistoryPage(
      data: rows.map(_mapAdminSale).toList(),
      total: pageData?.total ?? 0,
      page: pageData?.page ?? page,
      limit: pageData?.limit ?? limit,
      totalPages: pageData?.totalPages ?? 1,
    );
  }
}
