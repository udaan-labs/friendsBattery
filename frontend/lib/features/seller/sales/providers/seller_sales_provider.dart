import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';
import '../models/seller_sale.dart';
import '../repositories/seller_sales_repository.dart';

final sellerSalesRepositoryProvider = Provider<SellerSalesRepository>((ref) {
  final dio = ref.watch(apiClientProvider).dio;
  return SellerSalesRepository(dio);
});

class SellerSalesState {
  final List<SellerSale> sales;
  final bool isLoading;
  final String? error;
  final String searchQuery; // Combines customer or serial search based on what user types

  SellerSalesState({
    this.sales = const [],
    this.isLoading = true,
    this.error,
    this.searchQuery = '',
  });

  SellerSalesState copyWith({
    List<SellerSale>? sales,
    bool? isLoading,
    String? error,
    String? searchQuery,
  }) {
    return SellerSalesState(
      sales: sales ?? this.sales,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class SellerSalesNotifier extends StateNotifier<SellerSalesState> {
  final SellerSalesRepository _repository;

  SellerSalesNotifier(this._repository) : super(SellerSalesState()) {
    fetchSales();
  }

  Future<void> fetchSales({bool isRefresh = false}) async {
    if (!isRefresh) {
      state = state.copyWith(isLoading: true, error: null);
    }
    
    try {
      // The search query can act as both searchCustomer or searchSerial for now.
      // We pass it to both or let the backend handle it if it supports generic search.
      // To be safe, we will pass it to searchCustomer if it contains letters,
      // or to both. We'll pass it to both.
      final sales = await _repository.getSalesHistory(
        searchCustomer: state.searchQuery,
        searchSerial: state.searchQuery,
      );
      state = state.copyWith(sales: sales, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
    fetchSales();
  }
}

final sellerSalesProvider = StateNotifierProvider<SellerSalesNotifier, SellerSalesState>((ref) {
  final repository = ref.watch(sellerSalesRepositoryProvider);
  return SellerSalesNotifier(repository);
});

final sellerSaleDetailsProvider = FutureProvider.family<SellerSale, int>((ref, id) async {
  final repository = ref.watch(sellerSalesRepositoryProvider);
  return await repository.getSaleById(id);
});
