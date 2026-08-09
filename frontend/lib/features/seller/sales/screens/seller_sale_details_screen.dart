import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/utils/app_formatters.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../providers/seller_sales_provider.dart';
import '../models/seller_sale.dart';

class SellerSaleDetailsScreen extends ConsumerWidget {
  final int saleId;

  const SellerSaleDetailsScreen({super.key, required this.saleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saleAsyncValue = ref.watch(sellerSaleDetailsProvider(saleId));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text(
          'Sale Details',
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
              context.go('/seller/sales-history');
            }
          },
        ),
      ),
      body: SafeArea(
        child: saleAsyncValue.when(
          data: (sale) => _buildSaleDetails(context, sale),
          loading: () => const Center(
            child: CircularProgressIndicator(color: Color(0xFF006B2C)),
          ),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Failed to load sale details',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => ref.refresh(sellerSaleDetailsProvider(saleId)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006B2C),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaleDetails(BuildContext context, SellerSale sale) {
    final formattedDate = formatAppDateTime(sale.soldAt);

    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryHeader(context, sale, formattedDate),
              const SizedBox(height: 16),
              _buildCustomerInfo(context, sale),
              const SizedBox(height: 16),
              _buildProductInfo(context, sale),
              const SizedBox(height: 16),
              _buildSaleInfo(context, sale, formattedDate),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryHeader(BuildContext context, SellerSale sale, String formattedDate) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
      decoration: BoxDecoration(
        color: const Color(0xFF16A34A).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF16A34A).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transaction Amount',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF16A34A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF16A34A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Completed',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '₹${sale.sellPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF191C1E),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            formattedDate,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF586377),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(BuildContext context, SellerSale sale) {
    return _buildSectionCard(
      context: context,
      title: 'Customer Information',
      icon: Icons.person_outline,
      children: [
        _buildInfoRow('Name', sale.customerName ?? 'Unknown Customer'),
        if (sale.customerPhone != null && sale.customerPhone!.isNotEmpty) ...[
          const Divider(height: 24, color: Color(0xFFF1F5F9)),
          _buildInfoRow('Phone', sale.customerPhone!),
        ],
      ],
    );
  }

  Widget _buildProductInfo(BuildContext context, SellerSale sale) {
    return _buildSectionCard(
      context: context,
      title: 'Product Information',
      icon: Icons.battery_charging_full_outlined,
      children: [
        _buildInfoRow('Brand', sale.productName),
        const Divider(height: 24, color: Color(0xFFF1F5F9)),
        _buildInfoRow('Model', sale.productModel),
        const Divider(height: 24, color: Color(0xFFF1F5F9)),
        _buildInfoRow('Serial Number', sale.serialNumber),
        const Divider(height: 24, color: Color(0xFFF1F5F9)),
        _buildInfoRow('Quantity', sale.quantity.toString()),
      ],
    );
  }

  Widget _buildSaleInfo(BuildContext context, SellerSale sale, String formattedDate) {
    return _buildSectionCard(
      context: context,
      title: 'Transaction Details',
      icon: Icons.receipt_long_outlined,
      children: [
        _buildInfoRow('Sale ID', '#${sale.id}'),
        const Divider(height: 24, color: Color(0xFFF1F5F9)),
        _buildInfoRow('Date', formattedDate),
        const Divider(height: 24, color: Color(0xFFF1F5F9)),
        _buildInfoRow('Total Price', '₹${sale.sellPrice.toStringAsFixed(2)}'),
      ],
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF006B2C)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191C1E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF586377),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF191C1E),
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
