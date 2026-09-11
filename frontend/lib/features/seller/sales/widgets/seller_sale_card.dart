import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/utils/app_formatters.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../models/seller_sale.dart';

class SellerSaleCard extends StatelessWidget {
  final SellerSale sale;
  final String detailsPathPrefix;
  final VoidCallback? onPay;

  const SellerSaleCard({
    super.key,
    required this.sale,
    this.detailsPathPrefix = '/seller/sales',
    this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = formatAppDateTime(sale.soldAt);
    final type = sale.saleType.toUpperCase();

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
          onTap: () => context.push(
            '$detailsPathPrefix/${sale.id}',
            extra: sale,
          ),
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
                            '${sale.productName} -- ${sale.productModel}',
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
                            sale.billNumber,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
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
                              Expanded(child: _InfoItem(
                                icon: sale.hasUnitSerial ? Icons.tag_rounded : Icons.directions_car_outlined,
                                label: sale.hasUnitSerial ? 'Serial No' : 'Vehicle',
                                value: sale.hasUnitSerial ? sale.serialNumber : (sale.serialNumber == 'N/A' ? '—' : sale.serialNumber),
                              )),
                              const SizedBox(width: 8),
                              Expanded(child: _InfoItem(icon: Icons.inventory_2_outlined, label: 'Quantity', value: sale.quantity.toString())),
                            ],
                          ),
                        ],
                      );
                    }
                    return Row(
                      children: [
                        Expanded(child: _InfoItem(
                          icon: sale.hasUnitSerial ? Icons.tag_rounded : Icons.directions_car_outlined,
                          label: sale.hasUnitSerial ? 'Serial No' : 'Vehicle',
                          value: sale.hasUnitSerial ? sale.serialNumber : (sale.serialNumber == 'N/A' ? '—' : sale.serialNumber),
                        )),
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
                    _SaleTypeBadge(
                      saleType: type,
                      rentReturned: sale.rentStatus?.toUpperCase() == 'RETURNED',
                    ),
                    const SizedBox(width: 6),
                    _PaymentBadge(label: sale.paymentLabel, unpaid: sale.hasCreditDue),
                  ],
                ),
                if (onPay != null) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton(
                      onPressed: onPay,
                      child: const Text('Collect payment'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SaleTypeBadge extends StatelessWidget {
  final String saleType;
  final bool rentReturned;
  const _SaleTypeBadge({required this.saleType, this.rentReturned = false});

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (saleType) {
      'SERVICE' => ('SERVICE BILL', const Color(0xFFF3E8FF), const Color(0xFF7E22CE)),
      'RENT' => rentReturned
          ? ('RENT RETURN', const Color(0xFFE0E7FF), const Color(0xFF3730A3))
          : ('BATTERY RENT', const Color(0xFFE0F2FE), const Color(0xFF0369A1)),
      'SCRAP' => ('SCRAP', const Color(0xFFFFF7ED), const Color(0xFFC2410C)),
      'MECHANIC' => ('MECHANIC', const Color(0xFFEFF6FF), const Color(0xFF1D4ED8)),
      _ => ('NORMAL', const Color(0xFFF0FDF4), const Color(0xFF15803D)),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fg.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: fg),
      ),
    );
  }
}

class _PaymentBadge extends StatelessWidget {
  final String label;
  final bool unpaid;
  const _PaymentBadge({required this.label, required this.unpaid});

  @override
  Widget build(BuildContext context) {
    final bg = unpaid ? const Color(0xFFFFF7ED) : const Color(0xFFF1F5F9);
    final fg = unpaid ? const Color(0xFFC2410C) : const Color(0xFF475569);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fg.withValues(alpha: 0.2)),
      ),
      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: fg)),
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
