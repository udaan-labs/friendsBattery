import 'package:dio/dio.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

class SharedInventoryItemModel {
  final String productGroup;
  final String category;
  final String productModel;
  final String productName;
  final int quantity;
  final double minPrice;
  final int minStock; // Assuming we have this or default to 10

  SharedInventoryItemModel({
    required this.productGroup,
    required this.category,
    required this.productModel,
    required this.productName,
    required this.quantity,
    required this.minPrice,
    this.minStock = 10, // Default threshold if API doesn't provide it
  });

  factory SharedInventoryItemModel.fromJson(Map<String, dynamic> json) {
    return SharedInventoryItemModel(
      productGroup: json['product_group']?.toString() ?? 'N/A',
      category: json['category']?.toString() ?? 'N/A',
      productModel: json['product_model']?.toString() ?? 'N/A',
      productName: json['product_name']?.toString() ?? 'N/A',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      minPrice: (json['min_price'] as num?)?.toDouble() ?? 0.0,
      minStock: (json['min_stock'] as num?)?.toInt() ?? 5, // Defaulting to 5 for stock threshold demo
    );
  }
}

class PaginatedInventoryResponse {
  final List<SharedInventoryItemModel> items;
  final int total;

  PaginatedInventoryResponse({required this.items, required this.total});
}

class SharedInventoryRepository {
  final InventoryApi api;
  final Dio dio;

  SharedInventoryRepository({required this.api, required this.dio});

  Future<PaginatedInventoryResponse> getInventory({
    String? search,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      // Using Dio directly because the generated API returns Response<void> and we need raw data
      final response = await dio.get(
        '/api/inventory', // the base path might need to be prefixed with baseUrl, but dio usually handles it if configured
        queryParameters: {
          if (search != null && search.isNotEmpty) 'search': search,
          'page': page,
          'limit': limit,
        },
      );

      final data = response.data;
      
      if (data is Map<String, dynamic>) {
        final itemsData = data['data'] as List<dynamic>? ?? [];
        final total = data['total'] as int? ?? itemsData.length;
        
        final items = itemsData.map((e) => SharedInventoryItemModel.fromJson(e as Map<String, dynamic>)).toList();
        return PaginatedInventoryResponse(items: items, total: total);
      } else if (data is List) {
        // Fallback if the API returns a direct list
        final items = data.map((e) => SharedInventoryItemModel.fromJson(e as Map<String, dynamic>)).toList();
        return PaginatedInventoryResponse(items: items, total: items.length);
      }

      return PaginatedInventoryResponse(items: [], total: 0);
    } catch (e) {
      throw Exception('Failed to fetch inventory: $e');
    }
  }
}
