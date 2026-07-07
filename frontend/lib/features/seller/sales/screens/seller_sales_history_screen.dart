import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../theme/app_theme.dart';
import 'package:intl/intl.dart';
import '../providers/seller_sales_provider.dart';
import '../widgets/seller_sale_card.dart';

class SellerSalesHistoryScreen extends ConsumerStatefulWidget {
  const SellerSalesHistoryScreen({super.key});

  @override
  ConsumerState<SellerSalesHistoryScreen> createState() => _SellerSalesHistoryScreenState();
}

class _SellerSalesHistoryScreenState extends ConsumerState<SellerSalesHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    ref.read(sellerSalesProvider.notifier).updateSearch(value);
  }

  Future<void> _onRefresh() {
    return ref.read(sellerSalesProvider.notifier).fetchSales(isRefresh: true);
  }

  Future<void> _selectDate(BuildContext context) async {
    final state = ref.read(sellerSalesProvider);
    final initialDate = state.selectedDate ?? DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF16A34A),
              onPrimary: Colors.white,
              onSurface: Color(0xFF191C1E),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      ref.read(sellerSalesProvider.notifier).setDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sellerSalesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text(
          'Sales History',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF191C1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF3E4A3D)),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/seller/dashboard');
            }
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(ResponsiveHelper.responsivePadding(context), 0, ResponsiveHelper.responsivePadding(context), 14),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search by customer name or serial number...',
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                  prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF586377), size: 20),
                  filled: true,
                  fillColor: const Color(0xFFF7F9FB),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                    borderSide: const BorderSide(color: Color(0xFF16A34A), width: 1.5),
                  ),
                ),
              ),
            ),

            // Filter Chips
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(ResponsiveHelper.responsivePadding(context), 0, ResponsiveHelper.responsivePadding(context), 12),
              child: Row(
                children: [
                  _buildFilterChip('Today', 'today', state),
                  const SizedBox(width: 8),
                  _buildFilterChip('All', 'all', state),
                  const SizedBox(width: 8),
                  _buildDateFilterChip(state),
                ],
              ),
            ),

            // Thin divider between search and list
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEF0F2)),

            // List content — always wrapped in a scrollable for RefreshIndicator
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                color: const Color(0xFF006B2C),
                backgroundColor: Colors.white,
                child: _buildBody(state),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String filterValue, SellerSalesState state) {
    final isSelected = state.filter == filterValue;
    return ActionChip(
      label: Text(label),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : const Color(0xFF545F73),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 13,
      ),
      backgroundColor: isSelected ? const Color(0xFF16A34A) : const Color(0xFFF7F9FB),
      side: BorderSide(
        color: isSelected ? const Color(0xFF16A34A) : const Color(0xFFEEF0F2),
      ),
      onPressed: () => ref.read(sellerSalesProvider.notifier).setFilter(filterValue),
    );
  }

  Widget _buildDateFilterChip(SellerSalesState state) {
    final isSelected = state.filter == 'date';
    String label = 'Date';
    if (isSelected && state.selectedDate != null) {
      label = DateFormat('MMM d, yyyy').format(state.selectedDate!);
    }

    return ActionChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: 14,
            color: isSelected ? Colors.white : const Color(0xFF545F73),
          ),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : const Color(0xFF545F73),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 13,
      ),
      backgroundColor: isSelected ? const Color(0xFF16A34A) : const Color(0xFFF7F9FB),
      side: BorderSide(
        color: isSelected ? const Color(0xFF16A34A) : const Color(0xFFEEF0F2),
      ),
      onPressed: () => _selectDate(context),
    );
  }

  Widget _buildBody(SellerSalesState state) {
    if (state.isLoading) {
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(ResponsiveHelper.responsivePadding(context), 12, ResponsiveHelper.responsivePadding(context), 20),
        itemCount: 5,
        itemBuilder: (context, index) => _buildShimmerCard(),
      );
    }

    if (state.error != null) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.responsivePadding(context)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                      decoration: BoxDecoration(
                        color: AppTheme.error.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.cloud_off_rounded, size: 48, color: AppTheme.error),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Something went wrong',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Could not load your sales. Pull down to retry.',
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => ref.read(sellerSalesProvider.notifier).fetchSales(),
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF16A34A),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.responsivePadding(context), vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                    padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.receipt_long_rounded, size: 52, color: Colors.grey.shade400),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No Sales Found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _searchController.text.isEmpty
                        ? 'You haven\'t sold any products yet.'
                        : 'No results match your search.',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(ResponsiveHelper.responsivePadding(context), 12, ResponsiveHelper.responsivePadding(context), 20),
      itemCount: state.sales.length,
      itemBuilder: (context, index) {
        final sale = state.sales[index];
        return SellerSaleCard(sale: sale);
      },
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: ResponsiveHelper.isSmallPhone(context) ? 160 : 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shimmerBox(width: 130, height: 18),
                _shimmerBox(width: 70, height: 18),
              ],
            ),
            const SizedBox(height: 6),
            _shimmerBox(width: 90, height: 14),
            const SizedBox(height: 16),
            _shimmerBox(width: double.infinity, height: 1),
            const SizedBox(height: 16),
            _shimmerBox(width: 110, height: 14),
            const SizedBox(height: 6),
            _shimmerBox(width: 80, height: 12),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shimmerBox(width: 140, height: 12),
                _shimmerBox(width: 80, height: 24, radius: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerBox({required double width, required double height, double radius = 4}) {
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
