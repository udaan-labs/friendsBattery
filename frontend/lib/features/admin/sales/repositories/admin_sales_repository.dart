import 'package:dio/dio.dart';
import '../models/admin_sale_history.dart';

class AdminSalesRepository {
  final Dio _dio;

  AdminSalesRepository(this._dio);

  Future<AdminSalesHistoryPage> getAdminSalesHistory({
    int page = 1,
    int limit = 10,
    String? search,
    int? sellerId,
    String? fromDate,
    String? toDate,
    String? shipmentStatus,
  }) async {
    final queryParameters = <String, dynamic>{
      'page': page,
      'limit': limit,
    };

    if (search != null && search.isNotEmpty) {
      queryParameters['search'] = search;
    }
    if (sellerId != null) {
      queryParameters['sellerId'] = sellerId;
    }
    if (fromDate != null && fromDate.isNotEmpty) {
      queryParameters['fromDate'] = fromDate;
    }
    if (toDate != null && toDate.isNotEmpty) {
      queryParameters['toDate'] = toDate;
    }
    if (shipmentStatus != null && shipmentStatus.isNotEmpty) {
      queryParameters['shipmentStatus'] = shipmentStatus;
    }

    final response = await _dio.get(
      '/api/sales/admin/history',
      queryParameters: queryParameters,
    );

    final body = response.data;

    // Response shape: { success, message, data: { data: [...], total, page, ... } }
    Map<String, dynamic> pageData = {};
    if (body is Map) {
      final outer = body['data'];
      if (outer is Map<String, dynamic>) {
        pageData = outer;
      }
    }

    return AdminSalesHistoryPage.fromJson(pageData);
  }
}
