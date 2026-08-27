import 'package:flutter/material.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:intl/intl.dart';
import '../../../../theme/app_theme.dart';

class ProductDetailsScreen extends StatelessWidget {
  final VerifyProductPayload productData;

  const ProductDetailsScreen({super.key, required this.productData});

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final unit = productData.productUnit;
    final product = productData.product;
    final warranty = unit?.warrantyExpiry;
    final isExpired = warranty != null && warranty.isBefore(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: AppTheme.background,
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
                  _buildRow('Model', product?.model),
                  _buildRow('Name', product?.name),
                  _buildRow('Group', product?.group),
                  _buildRow('Subgroup', product?.subgroup),
                  _buildRow('Serial Number', unit?.serialNumber),
                  _buildRow('Status', unit?.status, isStatus: true),
                  _buildRow('QR Code', unit?.qrCode),
                  _buildRow(
                    'Warranty Expiry',
                    _formatDate(warranty),
                    highlight: warranty != null,
                    isExpired: isExpired,
                  ),
                ],
              ),
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
                Icon(icon, color: AppTheme.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
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

  Widget _buildRow(
    String label,
    dynamic value, {
    bool isStatus = false,
    bool highlight = false,
    bool isExpired = false,
  }) {
    String displayValue = value?.toString() ?? 'N/A';
    Color? valueColor = AppTheme.textSecondary;
    FontWeight valueWeight = FontWeight.normal;

    if (isStatus) {
      valueColor = displayValue == 'SOLD' ? AppTheme.success : AppTheme.primary;
      valueWeight = FontWeight.bold;
    } else if (highlight) {
      valueColor = isExpired ? AppTheme.error : AppTheme.success;
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
            style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w500),
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
}
