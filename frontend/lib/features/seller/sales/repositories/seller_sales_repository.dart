import 'package:dio/dio.dart';
import '../models/seller_sale.dart';

class SellerSalesRepository {
  final Dio _dio;

  SellerSalesRepository(this._dio);

  Future<List<SellerSale>> getSalesHistory({
    String? searchCustomer,
    String? searchSerial,
    String filter = 'today',
    String? date,
    int page = 1,
    int limit = 50,
  }) async {
    final queryParameters = <String, dynamic>{
      'page': page,
      'limit': limit,
      'filter': filter,
    };

    if (date != null && date.isNotEmpty) {
      queryParameters['date'] = date;
    }
    if (searchCustomer != null && searchCustomer.isNotEmpty) {
      queryParameters['searchCustomer'] = searchCustomer;
    }
    if (searchSerial != null && searchSerial.isNotEmpty) {
      queryParameters['searchSerial'] = searchSerial;
    }

    final response = await _dio.get('/api/sales/history', queryParameters: queryParameters);
    final body = response.data;

    // Response shape: { success, data: { data: [...], total, page, ... } }
    List<dynamic> rawList = [];
    if (body is Map) {
      final outer = body['data'];
      if (outer is Map && outer['data'] is List) {
        rawList = outer['data']; // double-nested: { data: { data: [] } }
      } else if (outer is List) {
        rawList = outer; // single-nested: { data: [] }
      }
    } else if (body is List) {
      rawList = body;
    }

    return rawList.whereType<Map<String, dynamic>>().map((e) => SellerSale.fromJson(e)).toList();
  }

  Future<SellerSale> getSaleById(int id) async {
    final response = await _dio.get('/api/sales/$id');
    final body = response.data;
    if (body is Map && body['success'] == true) {
      return SellerSale.fromJson(body['data']);
    }
    throw Exception(body['message'] ?? 'Failed to fetch sale details');
  }
}
