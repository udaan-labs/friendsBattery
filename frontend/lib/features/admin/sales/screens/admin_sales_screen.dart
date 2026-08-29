import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../../../../shared/widgets/sales_view_toggle.dart';
import '../../../../shared/widgets/snackbar_helper.dart';
import '../../../seller/sales/widgets/pay_credit_sheet.dart';
import '../models/admin_sale_history.dart';
import '../providers/admin_sales_history_provider.dart';
import '../widgets/admin_sale_history_card.dart';
import '../widgets/admin_sale_history_list_tile.dart';
import '../widgets/admin_sales_filter_bar.dart';
import '../widgets/admin_sales_pdf_preview.dart';
import '../widgets/admin_sales_pdf_sheet.dart';

class AdminSalesScreen extends ConsumerStatefulWidget {
  const AdminSalesScreen({super.key});

  @override
  ConsumerState<AdminSalesScreen> createState() => _AdminSalesScreenState();
}

class _AdminSalesScreenState extends ConsumerState<AdminSalesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _exporting = false;
  bool _cardView = true;

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

  Future<void> _collect(AdminSaleHistory sale) async {
    final paid = await showPayCreditSheet(context, amountDue: sale.amountDue);
    if (paid == null || !mounted) return;
    try {
      await ref.read(adminSalesHistoryProvider.notifier).collectCredit(
            saleId: sale.id,
            amount: paid,
          );
      if (mounted) context.showSuccessSnackBar('Payment recorded');
    } catch (e) {
      if (mounted) context.showErrorSnackBar('$e');
    }
  }

  Future<void> _exportPdf() async {
    if (_exporting) return;
    final choice = await showAdminSalesPdfSheet(context);
    if (choice == null || !mounted) return;
    setState(() => _exporting = true);
    try {
      final range = ref.read(adminSalesHistoryProvider.notifier).dateRangeFor(choice.period);
      final page = await ref.read(adminSalesRepositoryProvider).getAdminSalesHistory(
            page: 1,
            limit: 2000,
            locationId: choice.locationId,
            saleType: choice.saleType,
            paymentMode: choice.paymentMode,
            fromDate: range.from,
            toDate: range.to,
          );
      if (!mounted) return;
      if (page.data.isEmpty) {
        context.showErrorSnackBar('No sales to export');
        return;
      }
      final filters =
          '${choice.saleType ?? 'All types'} · ${choice.paymentMode ?? 'All pay'} · ${choice.locationId == null ? 'All shops' : page.data.first.shopName}';
      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AdminSalesPdfPreview(
            sales: page.data,
            period: choice.period.label(null),
            total: page.total,
            filters: filters,
          ),
        ),
      );
    } catch (e) {
      if (mounted) context.showErrorSnackBar(e.toString());
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
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
              if (!state.isLoading)
                Text(
                  '${state.total} total${state.sales.isEmpty ? '' : ' · ₹${state.totalRevenue.toStringAsFixed(0)} (shown)'}',
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
          foregroundColor: const Color(0xFF0F172A),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF0F172A)),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                context.go('/admin/dashboard');
              }
            },
          ),
          actions: [
            SalesViewToggle(
              cardView: _cardView,
              onChanged: (v) => setState(() => _cardView = v),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              AdminSalesFilterBar(
                searchController: _searchController,
                onSearch: _onSearchChanged,
                exporting: _exporting,
                onExport: _exportPdf,
              ),
              const Divider(height: 1, thickness: 1, color: Color(0xFFE2E8F0)),

              // ── List body ───────────────────────────────────────────────
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: AppTheme.primary,
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
                      decoration: const BoxDecoration(
                        color: Color(0xFFFEF3C7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.wifi_off_rounded,
                        size: 38,
                        color: Color(0xFFD97706),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Unable to load sales history',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A)),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Please check your network connection and try again.',
                      style: TextStyle(
                          color: Color(0xFF64748B), fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton.icon(
                      onPressed: () => ref
                          .read(adminSalesHistoryProvider.notifier)
                          .fetchSales(),
                      icon: const Icon(Icons.refresh_rounded, size: 16),
                      label: const Text('Try Again'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primary,
                        side: const BorderSide(color: AppTheme.primary),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
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
                    child: const Icon(Icons.receipt_long_rounded,
                        size: 52, color: Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No Sales Found',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _searchController.text.isNotEmpty
                        ? 'No results match your search.'
                        : state.period == AdminSalesPeriod.custom
                            ? 'No sales on this date.'
                            : 'No sales have been recorded yet.',
                    style: const TextStyle(
                        color: Color(0xFF64748B), fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: _cardView
          ? const EdgeInsets.fromLTRB(16, 12, 16, 20)
          : const EdgeInsets.only(bottom: 20),
      itemCount: state.sales.length + (state.isLoadingMore ? 1 : 0),
      separatorBuilder: (_, index) {
        if (_cardView || index >= state.sales.length - 1) {
          return const SizedBox.shrink();
        }
        return const Divider(height: 1, color: Color(0xFFE2E8F0));
      },
      itemBuilder: (context, index) {
        if (index == state.sales.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppTheme.primary,
                ),
              ),
            ),
          );
        }
        final sale = state.sales[index];
        final onPay = sale.hasCreditDue ? () => _collect(sale) : null;
        void openBill() => context.push(
              '/admin/sales/${sale.id}',
              extra: sale.toSellerSale(),
            );
        if (_cardView) {
          return AdminSaleHistoryCard(
            key: ValueKey(sale.billNumber),
            sale: sale,
            onPay: onPay,
            onOpen: openBill,
          );
        }
        return AdminSaleHistoryListTile(
          key: ValueKey(sale.billNumber),
          sale: sale,
          onPay: onPay,
          onOpen: openBill,
        );
      },
    );
  }
}

// ─── Shimmer skeleton card ─────────────────────────────────────────────────

class _ShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDF2F7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _box(width: 140, height: 16),
              _box(width: 60, height: 20),
            ],
          ),
          const SizedBox(height: 6),
          _box(width: 100, height: 12),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _box(width: 80, height: 14)),
                    const SizedBox(width: 8),
                    Expanded(child: _box(width: 80, height: 14)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _box(width: 80, height: 14)),
                    const SizedBox(width: 8),
                    Expanded(child: _box(width: 80, height: 14)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _box(width: 120, height: 12),
              _box(width: 70, height: 18, radius: 10),
            ],
          ),
        ],
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

