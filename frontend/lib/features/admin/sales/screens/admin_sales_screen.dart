import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../theme/app_theme.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../providers/admin_sales_history_provider.dart';
import '../widgets/admin_sale_history_card.dart';

class AdminSalesScreen extends ConsumerStatefulWidget {
  const AdminSalesScreen({super.key});

  @override
  ConsumerState<AdminSalesScreen> createState() => _AdminSalesScreenState();
}

class _AdminSalesScreenState extends ConsumerState<AdminSalesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(adminSalesHistoryProvider.notifier).loadMore();
    }
  }

  void _onSearchChanged(String value) {
    ref.read(adminSalesHistoryProvider.notifier).updateSearch(value);
  }

  Future<void> _onRefresh() {
    return ref
        .read(adminSalesHistoryProvider.notifier)
        .fetchSales(isRefresh: true);
  }

  String _periodLabel(AdminSalesPeriod p) {
    switch (p) {
      case AdminSalesPeriod.all:
        return 'All';
      case AdminSalesPeriod.today:
        return 'Today';
      case AdminSalesPeriod.week:
        return 'This week';
      case AdminSalesPeriod.month:
        return 'This month';
    }
  }

  Future<void> _shareReport(AdminSalesHistoryState state) async {
    final period = _periodLabel(state.period);
    final buf = StringBuffer()
      ..writeln('Friends Battery — Sales report ($period)')
      ..writeln('Total sales: ${state.total}')
      ..writeln(
          'Revenue (loaded page sample): ₹${state.totalRevenue.toStringAsFixed(0)}')
      ..writeln('---');
    for (final s in state.sales.take(50)) {
      buf.writeln(
        '${s.soldAt.toIso8601String().substring(0, 10)} · ${s.shopName} · '
        '${s.productName} ${s.productModel} · ₹${s.sellPrice.toStringAsFixed(0)} · ${s.serialNumber}',
      );
    }
    if (state.total > state.sales.length) {
      buf.writeln('… and ${state.total - state.sales.length} more (not listed)');
    }
    await Share.share(buf.toString(), subject: 'Sales report — $period');
    if (mounted) context.showSuccessSnackBar('Report shared');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminSalesHistoryProvider);

    return PopScope(
      canPop: Navigator.of(context).canPop(),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          context.go('/admin/dashboard');
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FB),
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sales History',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              if (!state.isLoading && state.total > 0)
                Text(
                  '${state.total} total · ₹${state.totalRevenue.toStringAsFixed(0)} (shown)',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF586377),
                  ),
                ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: const Color(0xFF191C1E),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF3E4A3D)),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                context.go('/admin/dashboard');
              }
            },
          ),
          actions: [
            IconButton(
              tooltip: 'Share report',
              icon: const Icon(Icons.ios_share_rounded),
              onPressed: state.isLoading || state.sales.isEmpty
                  ? null
                  : () => _shareReport(state),
            ),
          ],
        ),
        body: SafeArea(
        child: Column(
          children: [
          // ── Period chips (today / week / month / all) ───────────────
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final p in AdminSalesPeriod.values) ...[
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(_periodLabel(p)),
                        selected: state.period == p,
                        onSelected: (_) => ref
                            .read(adminSalesHistoryProvider.notifier)
                            .setPeriod(p),
                        selectedColor: const Color(0xFFE8F5E9),
                        labelStyle: TextStyle(
                          color: state.period == p
                              ? AppTheme.primary
                              : const Color(0xFF586377),
                          fontWeight: state.period == p
                              ? FontWeight.w600
                              : FontWeight.normal,
                          fontSize: 13,
                        ),
                        side: BorderSide(
                          color: state.period == p
                              ? AppTheme.primary
                              : const Color(0xFFECEEF0),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // ── Search bar ──────────────────────────────────────────────
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: ResponsiveHelper.isSmallPhone(context)
                    ? 'Search sales...'
                    : 'Search by customer, seller, shop, product, serial...',
                hintStyle:
                    TextStyle(color: Colors.grey.shade400, fontSize: 13),
                prefixIcon: const Icon(Icons.search_rounded,
                    color: Color(0xFF586377), size: 20),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded,
                            color: Color(0xFF586377), size: 18),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFFF7F9FB),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      color: Color(0xFF16A34A), width: 1.5),
                ),
              ),
            ),
          ),

          const Divider(height: 1, thickness: 1, color: Color(0xFFEEF0F2)),

          // ── List body ───────────────────────────────────────────────
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              color: const Color(0xFF16A34A),
              backgroundColor: Colors.white,
              child: _buildBody(state),
            ),
          ),
        ],
      ),
    ),
    ),
    );
  }

  Widget _buildBody(AdminSalesHistoryState state) {
    // Initial loading shimmer
    if (state.isLoading) {
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        itemCount: 5,
        itemBuilder: (_, __) => _ShimmerCard(),
      );
    }

    // Error state
    if (state.error != null && state.sales.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.error.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.cloud_off_rounded,
                          size: 48, color: AppTheme.error),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Something went wrong',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF191C1E)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Could not load sales history. Pull down to retry.',
                      style: TextStyle(
                          color: Colors.grey.shade500, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => ref
                          .read(adminSalesHistoryProvider.notifier)
                          .fetchSales(),
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF16A34A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Empty state
    if (state.sales.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.receipt_long_rounded,
                        size: 52, color: Colors.grey.shade400),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No Sales Found',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF191C1E)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _searchController.text.isEmpty
                        ? 'No sales have been recorded yet.'
                        : 'No results match your search.',
                    style: TextStyle(
                        color: Colors.grey.shade500, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    // Sales list with pagination
    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      itemCount: state.sales.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.sales.length) {
          // Pagination loader at the bottom
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF16A34A),
                ),
              ),
            ),
          );
        }
        return AdminSaleHistoryCard(sale: state.sales[index]);
      },
    );
  }
}

// ─── Shimmer skeleton card ─────────────────────────────────────────────────

class _ShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Accent strip shimmer
            Container(height: 4, color: Colors.grey.shade200),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _box(width: 140, height: 18),
                      _box(width: 70, height: 22),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _box(width: 100, height: 13),
                  const SizedBox(height: 16),
                  _box(width: double.infinity, height: 1),
                  const SizedBox(height: 16),
                  Row(children: [
                    _box(width: 30, height: 30, radius: 8),
                    const SizedBox(width: 10),
                    _box(width: 120, height: 14),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    _box(width: 30, height: 30, radius: 8),
                    const SizedBox(width: 10),
                    _box(width: 150, height: 14),
                  ]),
                  const SizedBox(height: 16),
                  _box(width: double.infinity, height: 1),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _box(width: 60, height: 32)),
                      const SizedBox(width: 8),
                      Expanded(child: _box(width: 60, height: 32)),
                      const SizedBox(width: 8),
                      Expanded(child: _box(width: 60, height: 32)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _box(width: double.infinity, height: 1),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _box(width: 160, height: 14),
                      _box(width: 70, height: 24, radius: 12),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _box(
      {required double width,
      required double height,
      double radius = 4}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
