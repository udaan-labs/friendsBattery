import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client_provider.dart';

class AdminStockQuery {
  final int page;
  final int limit;
  final String search;

  const AdminStockQuery({
    this.page = 1,
    this.limit = 10,
    this.search = '',
  });

  AdminStockQuery copyWith({int? page, int? limit, String? search}) {
    return AdminStockQuery(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      search: search ?? this.search,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminStockQuery &&
          page == other.page &&
          limit == other.limit &&
          search == other.search;

  @override
  int get hashCode => Object.hash(page, limit, search);
}

class AdminStockPage {
  final List<Map<String, dynamic>> items;
  final int totalPages;
  final int page;

  const AdminStockPage({
    required this.items,
    required this.totalPages,
    required this.page,
  });
}

final adminStockQueryProvider =
    StateProvider<AdminStockQuery>((ref) => const AdminStockQuery());

/// Admin dashboard "View Stock" table — shared source of truth (not local setState).
final adminStockDetailsProvider = FutureProvider<AdminStockPage>((ref) async {
  final query = ref.watch(adminStockQueryProvider);
  final api = ref.watch(apiClientProvider).getInventoryApi();
  final response = await api.apiInventoryDetailsGet(
    page: query.page,
    limit: query.limit,
    search: query.search.isNotEmpty ? query.search : null,
  );

  final details = response.data?.data;
  final pagination = details?.pagination;
  final totalPages = pagination?.totalPages ?? 1;

  final List<Map<String, dynamic>> items = [];
  final categories = details?.categories;
  if (categories != null) {
    for (final cat in categories) {
      final subcats = cat.subcategories;
      if (subcats == null) continue;
      for (final sub in subcats) {
        final prods = sub.products;
        if (prods == null) continue;
        for (final prod in prods) {
          items.add({
            'category': cat.categoryName ?? '',
            'subcategory': sub.subcategoryName ?? '',
            'productName': prod.productName ?? '',
            'total': prod.totalQuantity ?? 0,
            'sold': prod.soldQuantity ?? 0,
            'remaining': prod.remainingQuantity ?? 0,
          });
        }
      }
    }
  }

  return AdminStockPage(
    items: items,
    totalPages: totalPages,
    page: query.page,
  );
});
