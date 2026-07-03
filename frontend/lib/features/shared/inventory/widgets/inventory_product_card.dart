import 'package:flutter/material.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../repository/shared_inventory_repository.dart';

class InventoryProductCard extends StatelessWidget {
  final SharedInventoryItemModel item;
  final int index;
  final VoidCallback? onTap;

  const InventoryProductCard({
    super.key,
    required this.item,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: ResponsiveHelper.responsiveHorizontalMargin(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap ?? () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Index Badge
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Middle Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.productModel,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF191C1E),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.productName,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          _buildSmallChip(
                            icon: Icons.inventory_2_outlined,
                            label: '${item.quantity} Units',
                            color: item.quantity == 0
                                ? Colors.red
                                : (item.quantity <= item.minStock
                                    ? Colors.orange
                                    : Colors.green),
                            bgColor: item.quantity == 0
                                ? Colors.red.shade50
                                : (item.quantity <= item.minStock
                                    ? Colors.orange.shade50
                                    : Colors.green.shade50),
                          ),
                          _buildSmallChip(
                            icon: Icons.currency_rupee_outlined,
                            label: 'Min: ₹${item.minPrice.toStringAsFixed(0)}',
                            color: Colors.blue.shade700,
                            bgColor: Colors.blue.shade50,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Status Badge
                const SizedBox(width: 12),
                _buildStatusDot(item.quantity, item.minStock),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallChip({
    required IconData icon,
    required String label,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDot(int quantity, int minStock) {
    Color color = quantity == 0
        ? Colors.red
        : (quantity <= minStock ? Colors.orange : Colors.green);
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
