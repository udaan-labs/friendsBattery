import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../providers/inventory_provider.dart';
import '../widgets/inventory_product_card.dart';

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
    final String location = GoRouterState.of(context).uri.toString();
    final bool isSeller = location.startsWith('/seller');

    return PopScope(
      canPop: context.canPop(),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (isSeller) {
          context.go('/seller/dashboard');
        } else {
          context.go('/admin/dashboard');
        }
      },
      child: Scaffold(
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
            padding: EdgeInsets.all(ResponsiveHelper.responsiveHorizontalMargin(context)),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: ResponsiveHelper.isSmallPhone(context)
                    ? "Search inventory..."
                    : "Search by product group, category, model or product name...",
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
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: data.items.length,
                          itemBuilder: (context, index) {
                            final item = data.items[index];
                            final serialNumber = ((queryState.page - 1) * queryState.limit) + index + 1;
                            return InventoryProductCard(
                              item: item,
                              index: serialNumber,
                            );
                          },
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
    ));
  }

  Widget _buildPagination(int total, int currentPage, int limit) {
    final totalPages = (total / limit).ceil();
    if (totalPages <= 1) return const SizedBox.shrink();

    final start = ((currentPage - 1) * limit) + 1;
    final end = (start + limit - 1).clamp(0, total);

    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.responsiveHorizontalMargin(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 400) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Showing $start to $end of $total entries',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                    textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: currentPage > 1 ? () => _onPageChanged(currentPage - 1) : null,
                      child: const Text('Previous'),
                    ),
                    const SizedBox(width: 8),
                    Text('$currentPage / $totalPages', style: const TextStyle(fontSize: 13)),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: currentPage < totalPages ? () => _onPageChanged(currentPage + 1) : null,
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ],
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('Showing $start to $end of $total entries',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    overflow: TextOverflow.ellipsis),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: currentPage > 1 ? () => _onPageChanged(currentPage - 1) : null,
                    child: const Text('Previous'),
                  ),
                  Text('$currentPage / $totalPages', style: const TextStyle(fontSize: 13)),
                  TextButton(
                    onPressed: currentPage < totalPages ? () => _onPageChanged(currentPage + 1) : null,
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
