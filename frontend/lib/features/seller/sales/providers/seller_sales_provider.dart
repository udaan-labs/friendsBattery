import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';
import '../models/seller_sale.dart';
import '../repositories/seller_sales_repository.dart';

final sellerSalesRepositoryProvider = Provider<SellerSalesRepository>((ref) {
  return SellerSalesRepository(api: ref.watch(apiClientProvider));
});

class SellerSalesState {
  final List<SellerSale> sales;
  final bool isLoading;
  final String? error;
  final String searchQuery; // Combines customer or serial search based on what user types
  final String filter; // 'today', 'all', 'date'
  final DateTime? selectedDate;

  SellerSalesState({
    this.sales = const [],
    this.isLoading = true,
    this.error,
    this.searchQuery = '',
    this.filter = 'today',
    this.selectedDate,
  });

  SellerSalesState copyWith({
    List<SellerSale>? sales,
    bool? isLoading,
    String? error,
    String? searchQuery,
    String? filter,
    DateTime? selectedDate,
  }) {
    return SellerSalesState(
      sales: sales ?? this.sales,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
      filter: filter ?? this.filter,
      selectedDate: selectedDate ?? this.selectedDate,
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
        filter: state.filter,
        date: state.selectedDate?.toIso8601String(),
      );
      state = state.copyWith(sales: sales, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setFilter(String filter) {
    state = state.copyWith(filter: filter);
    fetchSales();
  }

  void setDate(DateTime date) {
    state = state.copyWith(filter: 'date', selectedDate: date);
    fetchSales();
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
