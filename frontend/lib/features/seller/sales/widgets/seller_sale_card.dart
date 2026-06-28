import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../models/seller_sale.dart';

class SellerSaleCard extends StatelessWidget {
  final SellerSale sale;

  const SellerSaleCard({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(sale.soldAt);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: ResponsiveHelper.responsiveHorizontalMargin(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            // Optional: Navigate to detail screen if implemented later
          },
          child: Padding(
            padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sale.productName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF191C1E),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            sale.productModel,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF586377),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '₹${sale.sellPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF16A34A),
                      ),
                    ),
                  ],
                ),
                
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.cardPadding(context) * 0.75),
                  child: const Divider(height: 1, color: Color(0xFFE0E4E8)),
                ),

                // Customer Information
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.person_outline, size: 18, color: Color(0xFF586377)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sale.customerName ?? 'Unknown Customer',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF191C1E),
                            ),
                          ),
                          if (sale.customerPhone != null && sale.customerPhone!.isNotEmpty)
                            Text(
                              sale.customerPhone!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF586377),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Product Information Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 360) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: _InfoItem(icon: Icons.tag_rounded, label: 'Serial No', value: sale.serialNumber)),
                              const SizedBox(width: 8),
                              Expanded(child: _InfoItem(icon: Icons.inventory_2_outlined, label: 'Quantity', value: sale.quantity.toString())),
                            ],
                          ),
                        ],
                      );
                    }
                    return Row(
                      children: [
                        Expanded(child: _InfoItem(icon: Icons.tag_rounded, label: 'Serial No', value: sale.serialNumber)),
                        Expanded(child: _InfoItem(icon: Icons.inventory_2_outlined, label: 'Quantity', value: sale.quantity.toString())),
                      ],
                    );
                  },
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.cardPadding(context) * 0.75),
                  child: const Divider(height: 1, color: Color(0xFFE0E4E8)),
                ),

                // Bottom Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF586377)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              formattedDate,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF586377),
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isSmallPhone(context) ? 8 : 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF16A34A).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF16A34A),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 12, color: const Color(0xFF586377)),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF586377),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF191C1E),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
