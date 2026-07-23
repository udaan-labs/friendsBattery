import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';

final productLookupProvider =
    StateNotifierProvider<ProductLookupNotifier, AsyncValue<Map<String, dynamic>?>>((ref) {
  return ProductLookupNotifier(ref.watch(apiClientProvider));
});

class ProductLookupNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>?>> {
  final FriendsBatteryApi _api;

  ProductLookupNotifier(this._api) : super(const AsyncValue.data(null));

  void clearResult() {
    state = const AsyncValue.data(null);
  }

  Future<void> lookupProduct(String identifier) async {
    state = const AsyncValue.loading();
    try {
      final body = VerifyProductRequest((b) => b.identifier = identifier);
      final response = await _api.getProductUnitsApi().apiProductUnitsVerifyPost(
            verifyProductRequest: body,
          );

      final data = response.data?.data;
      if (response.statusCode == 200 && data != null) {
        state = AsyncValue.data({
          'productUnit': {
            'serialNumber': data.productUnit?.serialNumber,
            'status': data.productUnit?.status,
            'qrCode': data.productUnit?.qrCode,
            'manufactureDate': data.productUnit?.manufactureDate?.toIso8601String(),
            'warrantyExpiry': data.productUnit?.warrantyExpiry?.toIso8601String(),
          },
          'product': {
            'name': data.product?.name,
            'group': data.product?.group,
            'subgroup': data.product?.subgroup,
            'model': data.product?.model,
          },
        });
      } else {
        state = AsyncValue.error(
          response.data?.message ?? 'Failed to verify product',
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
