import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';

final productLookupProvider = StateNotifierProvider<ProductLookupNotifier, AsyncValue<Map<String, dynamic>?>>((ref) {
  final dio = ref.watch(apiClientProvider).dio;
  return ProductLookupNotifier(dio);
});

class ProductLookupNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>?>> {
  final Dio _dio;

  ProductLookupNotifier(this._dio) : super(const AsyncValue.data(null));

  void clearResult() {
    state = const AsyncValue.data(null);
  }

  Future<void> lookupProduct(String identifier) async {
    state = const AsyncValue.loading();
    try {
      final response = await _dio.post(
        '/api/product-units/verify',
        data: {'identifier': identifier},
      );
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        state = AsyncValue.data(response.data['data']);
      } else {
        state = AsyncValue.error(
          response.data['message'] ?? 'Failed to verify product',
          StackTrace.current,
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Network error occurred';
      if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['message'] ?? 'Product not found or access denied';
      }
      state = AsyncValue.error(errorMessage, StackTrace.current);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}
