import 'package:dio/dio.dart';

class SharedInventoryItemModel {
  final int productId;
  final int productNameId;
  final int productModelId;
  final String productModel;
  final String productName;
  final int quantity;
  final double minPrice;
  final int minUnitCountAdmin;
  final int minUnitCountSeller;
  final bool onSale;
  final bool isLowStock;

  SharedInventoryItemModel({
    required this.productId,
    required this.productNameId,
    required this.productModelId,
    required this.productModel,
    required this.productName,
    required this.quantity,
    required this.minPrice,
    this.minUnitCountAdmin = 0,
    this.minUnitCountSeller = 0,
    this.onSale = false,
    this.isLowStock = false,
  });

  factory SharedInventoryItemModel.fromJson(Map<String, dynamic> json) {
    final brandName = json['brand']?.toString() ?? 'N/A';
    return SharedInventoryItemModel(
      productId: (json['product_id'] as num?)?.toInt() ?? 0,
      productNameId: (json['product_name_id'] as num?)?.toInt() ?? 0,
      productModelId: (json['product_model_id'] as num?)?.toInt() ?? 0,
      productModel: json['model']?.toString() ?? 'N/A',
      productName: brandName,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      minPrice: (json['min_price'] as num?)?.toDouble() ?? 0.0,
      minUnitCountAdmin: (json['min_unit_count_admin'] as num?)?.toInt() ?? 0,
      minUnitCountSeller: (json['min_unit_count_seller'] as num?)?.toInt() ?? 0,
      onSale: json['on_sale'] == true || json['on_sale'] == 1,
      isLowStock: json['is_low_stock'] == true,
    );
  }
}

class InventoryProductDetailModel {
  final int productId;
  final String productModel;
  final String productName;
  final int quantity;
  final double minPrice;
  final bool isLowStock;
  final List<String> serialNumbers;

  InventoryProductDetailModel({
    required this.productId,
    required this.productModel,
    required this.productName,
    required this.quantity,
    required this.minPrice,
    required this.isLowStock,
    required this.serialNumbers,
  });

  factory InventoryProductDetailModel.fromJson(Map<String, dynamic> json) {
    final brandName = json['brand']?.toString() ?? 'N/A';
    final serials = json['serial_numbers'] as List<dynamic>?;
    
    return InventoryProductDetailModel(
      productId: (json['product_id'] as num?)?.toInt() ?? 0,
      productModel: json['model']?.toString() ?? 'N/A',
      productName: brandName,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      minPrice: (json['min_price'] as num?)?.toDouble() ?? 0.0,
      isLowStock: json['is_low_stock'] == true,
      serialNumbers: serials?.map((e) => e.toString()).toList() ?? [],
    );
  }
}

class PaginatedInventoryResponse {
  final List<SharedInventoryItemModel> items;
  final int total;

  PaginatedInventoryResponse({required this.items, required this.total});
}

class SharedInventoryRepository {
  final Dio dio;

  SharedInventoryRepository({required this.dio});

  Future<PaginatedInventoryResponse> getInventory({
    String? search,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      // Using Dio directly because the generated API returns Response<void> and we need raw data
      final response = await dio.get(
        '/api/inventory',
        queryParameters: {
          if (search != null && search.isNotEmpty) 'search': search,
          'page': page,
          'limit': limit,
        },
      );

      final data = response.data;
      
      if (data is Map<String, dynamic>) {
        final innerData = data['data'];
        
        if (innerData is Map<String, dynamic>) {
          final itemsData = innerData['data'] as List<dynamic>? ?? [];
          final pagination = innerData['pagination'];
          final total = (pagination is Map<String, dynamic> ? pagination['total'] as int? : null) ?? itemsData.length;
          
          final items = itemsData.map((e) => SharedInventoryItemModel.fromJson(e as Map<String, dynamic>)).toList();
          return PaginatedInventoryResponse(items: items, total: total);
        } else if (innerData is List<dynamic>) {
          final itemsData = innerData;
          final total = itemsData.length;
          final items = itemsData.map((e) => SharedInventoryItemModel.fromJson(e as Map<String, dynamic>)).toList();
          return PaginatedInventoryResponse(items: items, total: total);
        }
      } else if (data is List) {
        final items = data.map((e) => SharedInventoryItemModel.fromJson(e as Map<String, dynamic>)).toList();
        return PaginatedInventoryResponse(items: items, total: items.length);
      }

      return PaginatedInventoryResponse(items: [], total: 0);
    } catch (e) {
      throw Exception('Failed to fetch inventory: $e');
    }
  }

  Future<InventoryProductDetailModel> getProductDetail(int productId) async {
    try {
      final response = await dio.get('/api/inventory/$productId');
      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] != null) {
        return InventoryProductDetailModel.fromJson(data['data']);
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Failed to fetch product detail: $e');
    }
  }
}
