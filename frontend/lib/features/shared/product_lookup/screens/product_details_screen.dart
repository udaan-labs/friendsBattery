import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:intl/intl.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductDetailsScreen({super.key, required this.productData});

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final unit = productData['productUnit'] ?? {};
    final product = productData['product'] ?? {};
    final seller = productData['seller'];
    final customer = productData['customer'];
    final sale = productData['sale'];
    final history = (productData['inventoryHistory'] as List?) ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              title: 'Product Information',
              icon: Icons.battery_charging_full,
              content: Column(
                children: [
                  _buildRow('Model', product['model']),
                  _buildRow('Name', product['name']),
                  _buildRow('Serial Number', unit['serialNumber']),
                  _buildRow('Status', unit['status'], isStatus: true),
                  _buildRow('Manufactured', _formatDate(unit['manufactureDate'])),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (sale != null) ...[
              _buildSection(
                title: 'Sale & Warranty Information',
                icon: Icons.point_of_sale,
                content: Column(
                  children: [
                    _buildRow('Sale Date', _formatDate(sale['saleDate'])),
                    _buildRow('Sale Price', '₹${sale['salePrice']}'),
                    _buildRow('Warranty Expiry', _formatDate(unit['warrantyExpiry']), 
                        highlight: true, 
                        isExpired: unit['warrantyExpiry'] != null && DateTime.parse(unit['warrantyExpiry']).isBefore(DateTime.now())),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (customer != null) ...[
              _buildSection(
                title: 'Customer Information',
                icon: Icons.person,
                content: Column(
                  children: [
                    _buildRow('Name', customer['name']),
                    _buildRow('Phone', customer['phone']),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (seller != null) ...[
              _buildSection(
                title: 'Seller Information',
                icon: Icons.store,
                content: Column(
                  children: [
                    _buildRow('Shop', seller['shopName']),
                    _buildRow('Owner', seller['name']),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            _buildSection(
              title: 'Inventory Timeline',
              icon: Icons.history,
              content: _buildTimeline(history),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required IconData icon, required Widget content}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, dynamic value, {bool isStatus = false, bool highlight = false, bool isExpired = false}) {
    String displayValue = value?.toString() ?? 'N/A';
    Color? valueColor = AppColors.textSecondary;
    FontWeight valueWeight = FontWeight.normal;

    if (isStatus) {
      valueColor = displayValue == 'SOLD' ? AppColors.success : AppColors.primary;
      valueWeight = FontWeight.bold;
    } else if (highlight) {
      valueColor = isExpired ? AppColors.error : AppColors.success;
      valueWeight = FontWeight.bold;
      if (isExpired) displayValue += ' (Expired)';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
          ),
          Flexible(
            child: Text(
              displayValue,
              style: TextStyle(color: valueColor, fontWeight: valueWeight),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(List history) {
    if (history.isEmpty) {
      return const Text('No history available', style: TextStyle(color: AppColors.textSecondary));
    }

    return Column(
      children: List.generate(history.length, (index) {
        final event = history[index];
        final isLast = index == history.length - 1;
        
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: AppColors.primary.withOpacity(0.3),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['type']?.toString().replaceAll('_', ' ') ?? 'UNKNOWN',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_formatDate(event['date'])} - by ${event['performedBy']}',
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  if (!isLast) const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
