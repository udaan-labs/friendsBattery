import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';

class SellerDetailsData {
  final Map<String, dynamic> rawData;

  SellerDetailsData(this.rawData);

  String get shopName => rawData['shop_name']?.toString() ?? 'Unknown Shop';
  String get userName => rawData['user_name']?.toString() ?? 'Unknown User';
  String get userNumber => rawData['user_number']?.toString() ?? 'N/A';
  bool get isActive => rawData['is_active'] == true || rawData['is_active'] == 1;
  bool get isVerified => rawData['is_verified'] == true || rawData['is_verified'] == 1;

  Map<String, dynamic> get statistics => rawData['statistics'] ?? {};
  int get stock => statistics['stock'] ?? 0;
  int get products => statistics['products'] ?? 0;
  int get sales => statistics['sales'] ?? 0;
  int get returns => statistics['returns'] ?? 0;

  List<dynamic> get inventory => rawData['inventory'] ?? [];
}

final sellerDetailsProvider = FutureProvider.family<SellerDetailsData, ({int sellerId, bool includeOutOfStock})>((ref, params) async {
  final dio = ref.watch(apiClientProvider).dio;
  final response = await dio.get(
    '/api/shops/sellers/${params.sellerId}',
    queryParameters: {'includeOutOfStock': params.includeOutOfStock},
  );
  
  final dynamic data = response.data;
  
  if (data is Map<String, dynamic> && data.containsKey('data')) {
    return SellerDetailsData(data['data']);
  } else if (data is Map<String, dynamic>) {
    return SellerDetailsData(data);
  }
  
  throw Exception('Invalid data format received from API');
});
