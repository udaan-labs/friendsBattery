import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/inventory_provider.dart';
import '../repository/shared_inventory_repository.dart';

class CurrentInventoryScreen extends ConsumerStatefulWidget {
  const CurrentInventoryScreen({super.key});

  @override
  ConsumerState<CurrentInventoryScreen> createState() => _CurrentInventoryScreenState();
}

class _CurrentInventoryScreenState extends ConsumerState<CurrentInventoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(sharedInventoryQueryProvider.notifier).update(
            (state) => InventoryQuery(
              search: _searchController.text,
              page: 1,
              limit: state.limit,
            ),
          );
    });
  }

  void _onPageChanged(int newPage) {
    ref.read(sharedInventoryQueryProvider.notifier).update(
          (state) => InventoryQuery(
            search: state.search,
            page: newPage,
            limit: state.limit,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final inventoryState = ref.watch(sharedInventoryProvider);
    final queryState = ref.watch(sharedInventoryQueryProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current Inventory', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('View your current inventory and stock details.', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by product group, category, model or product name...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(sharedInventoryProvider);
                await ref.read(sharedInventoryProvider.future);
              },
              child: inventoryState.when(
                data: (data) {
                  if (data.items.isEmpty) {
                    return ListView(
                      children: const [
                        SizedBox(height: 100),
                        Center(child: Text('No inventory found.', style: TextStyle(color: Colors.grey))),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                  border: Border.all(color: Colors.grey.shade200),
                                ),
                                child: DataTable(
                                  headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
                                  dataRowColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                    return null; // alternate row colors can be added if we track index
                                  }),
                                  columns: const [
                                    DataColumn(label: Text('#', style: TextStyle(fontWeight: FontWeight.bold))),
                                    DataColumn(label: Text('Product Group', style: TextStyle(fontWeight: FontWeight.bold))),
                                    DataColumn(label: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))),
                                    DataColumn(label: Text('Product Model', style: TextStyle(fontWeight: FontWeight.bold))),
                                    DataColumn(label: Text('Product Name', style: TextStyle(fontWeight: FontWeight.bold))),
                                    DataColumn(label: Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold))),
                                    DataColumn(label: Text('Min Price', style: TextStyle(fontWeight: FontWeight.bold))),
                                    DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                                  ],
                                  rows: List.generate(data.items.length, (index) {
                                    final item = data.items[index];
                                    final serialNumber = ((queryState.page - 1) * queryState.limit) + index + 1;
                                    return DataRow(
                                      color: MaterialStateProperty.all(index % 2 == 0 ? Colors.white : Colors.grey.shade50),
                                      cells: [
                                        DataCell(Text('$serialNumber')),
                                        DataCell(Text(item.productGroup)),
                                        DataCell(Text(item.category)),
                                        DataCell(Text(item.productModel)),
                                        DataCell(Text(item.productName)),
                                        DataCell(Text('${item.quantity}')),
                                        DataCell(Text('₹${item.minPrice.toStringAsFixed(2)}')),
                                        DataCell(_buildStatusBadge(item.quantity, item.minStock)),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      _buildPagination(data.total, queryState.page, queryState.limit),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      const Text('Failed to load inventory.'),
                      TextButton(
                        onPressed: () => ref.invalidate(sharedInventoryProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(int quantity, int minStock) {
    Color color;
    String text;

    if (quantity == 0) {
      color = Colors.red;
      text = 'Out of Stock';
    } else if (quantity <= minStock) {
      color = Colors.orange;
      text = 'Low Stock';
    } else {
      color = Colors.green;
      text = 'In Stock';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildPagination(int total, int currentPage, int limit) {
    final totalPages = (total / limit).ceil();
    if (totalPages <= 1) return const SizedBox.shrink();

    final start = ((currentPage - 1) * limit) + 1;
    final end = (start + limit - 1).clamp(0, total);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Showing $start to $end of $total entries', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
          Row(
            children: [
              TextButton(
                onPressed: currentPage > 1 ? () => _onPageChanged(currentPage - 1) : null,
                child: const Text('Previous'),
              ),
              Text('$currentPage / $totalPages'),
              TextButton(
                onPressed: currentPage < totalPages ? () => _onPageChanged(currentPage + 1) : null,
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
