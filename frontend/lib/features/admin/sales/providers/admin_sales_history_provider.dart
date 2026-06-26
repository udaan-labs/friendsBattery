import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';
import '../models/admin_sale_history.dart';
import '../repositories/admin_sales_repository.dart';

// ─── Repository provider ───────────────────────────────────────────────────

final adminSalesRepositoryProvider = Provider<AdminSalesRepository>((ref) {
  final dio = ref.watch(apiClientProvider).dio;
  return AdminSalesRepository(dio);
});

// ─── State ─────────────────────────────────────────────────────────────────

class AdminSalesHistoryState {
  final List<AdminSaleHistory> sales;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final String searchQuery;
  final int currentPage;
  final int totalPages;
  final int total;

  const AdminSalesHistoryState({
    this.sales = const [],
    this.isLoading = true,
    this.isLoadingMore = false,
    this.error,
    this.searchQuery = '',
    this.currentPage = 1,
    this.totalPages = 1,
    this.total = 0,
  });

  bool get hasMore => currentPage < totalPages;

  AdminSalesHistoryState copyWith({
    List<AdminSaleHistory>? sales,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool clearError = false,
    String? searchQuery,
    int? currentPage,
    int? totalPages,
    int? total,
  }) {
    return AdminSalesHistoryState(
      sales: sales ?? this.sales,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: clearError ? null : error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      total: total ?? this.total,
    );
  }
}

// ─── Notifier ──────────────────────────────────────────────────────────────

class AdminSalesHistoryNotifier
    extends StateNotifier<AdminSalesHistoryState> {
  final AdminSalesRepository _repository;

  AdminSalesHistoryNotifier(this._repository)
      : super(const AdminSalesHistoryState()) {
    fetchSales();
  }

  static const int _pageSize = 10;

  Future<void> fetchSales({bool isRefresh = false}) async {
    if (isRefresh || state.isLoading) {
      state = state.copyWith(
        isLoading: true,
        clearError: true,
        currentPage: 1,
        sales: isRefresh ? [] : state.sales,
      );
    }

    try {
      final result = await _repository.getAdminSalesHistory(
        page: 1,
        limit: _pageSize,
        search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
      );

      state = state.copyWith(
        sales: result.data,
        isLoading: false,
        clearError: true,
        currentPage: result.page,
        totalPages: result.totalPages,
        total: result.total,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);
    final nextPage = state.currentPage + 1;

    try {
      final result = await _repository.getAdminSalesHistory(
        page: nextPage,
        limit: _pageSize,
        search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
      );

      state = state.copyWith(
        sales: [...state.sales, ...result.data],
        isLoadingMore: false,
        currentPage: result.page,
        totalPages: result.totalPages,
        total: result.total,
      );
    } catch (e) {
      // On load-more failure, silently stop loading so the list stays intact
      state = state.copyWith(isLoadingMore: false);
    }
  }

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
    fetchSales();
  }
}

// ─── Provider ──────────────────────────────────────────────────────────────

final adminSalesHistoryProvider = StateNotifierProvider<
    AdminSalesHistoryNotifier, AdminSalesHistoryState>((ref) {
  final repository = ref.watch(adminSalesRepositoryProvider);
  return AdminSalesHistoryNotifier(repository);
});
