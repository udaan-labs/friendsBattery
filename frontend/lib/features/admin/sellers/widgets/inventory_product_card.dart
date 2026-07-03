import 'package:flutter/material.dart';
import '../../../../shared/widgets/responsive_helper.dart';

class InventoryProductCard extends StatelessWidget {
  final Map<String, dynamic> inventoryItem;
  final VoidCallback onTap;

  const InventoryProductCard({
    super.key,
    required this.inventoryItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final quantity = inventoryItem['quantity'] as int? ?? 0;
    
    // Status Logic
    String statusText;
    Color statusColor;
    final isLowStock = inventoryItem['is_low_stock'] == true;
    
    if (quantity <= 0) {
      statusText = 'Out of Stock';
      statusColor = Colors.red;
    } else if (isLowStock) {
      statusText = 'Low Stock';
      statusColor = Colors.orange;
    } else {
      statusText = 'In Stock';
      statusColor = Colors.green;
    }

    final minPrice = inventoryItem['min_price']?.toString() ?? '0';
    final offerPrice = inventoryItem['offer_price']?.toString();

    return Container(
      margin: EdgeInsets.only(bottom: 12, left: ResponsiveHelper.responsiveHorizontalMargin(context), right: ResponsiveHelper.responsiveHorizontalMargin(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      inventoryItem['category']?.toString() ?? 'Category',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    _buildBadge(statusText, statusColor, context),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${inventoryItem['brand'] ?? ''} ${inventoryItem['model'] ?? ''}'.trim(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 360) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: _buildInfoColumn('Quantity', quantity.toString(), Icons.inventory_2_outlined)),
                              const SizedBox(width: 8),
                              Expanded(child: _buildInfoColumn('Min Price', '₹$minPrice', Icons.price_change_outlined)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(child: _buildInfoColumn('Offer Price', offerPrice != null ? '₹$offerPrice' : '—', Icons.local_offer_outlined)),
                              const Spacer(),
                              const Icon(Icons.chevron_right_rounded, color: Colors.grey),
                            ],
                          ),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoColumn('Quantity', quantity.toString(), Icons.inventory_2_outlined),
                        _buildInfoColumn('Min Price', '₹$minPrice', Icons.price_change_outlined),
                        _buildInfoColumn('Offer Price', offerPrice != null ? '₹$offerPrice' : '—', Icons.local_offer_outlined),
                        const Icon(Icons.chevron_right_rounded, color: Colors.grey),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isSmallPhone(context) ? 6 : 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: Colors.grey.shade600),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
