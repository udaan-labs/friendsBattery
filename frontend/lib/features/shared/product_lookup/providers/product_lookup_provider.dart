import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import '../../../../core/network/api_client_provider.dart';

final productLookupProvider =
    StateNotifierProvider<ProductLookupNotifier, AsyncValue<VerifyProductPayload?>>((ref) {
  return ProductLookupNotifier(ref.watch(apiClientProvider));
});

class ProductLookupNotifier extends StateNotifier<AsyncValue<VerifyProductPayload?>> {
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
        state = AsyncValue.data(data);
      } else {
        state = AsyncValue.error(
          response.data?.message ?? 'Failed to verify product',
          StackTrace.current,
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Network error occurred';
      if (e.response != null && e.response?.data != null) {
        final body = e.response?.data;
        if (body is Map && body['message'] != null) {
          errorMessage = body['message'].toString();
        } else {
          errorMessage = 'Product not found or access denied';
        }
      }
      state = AsyncValue.error(errorMessage, StackTrace.current);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}
