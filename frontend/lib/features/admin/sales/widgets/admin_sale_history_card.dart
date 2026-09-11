import 'package:flutter/material.dart';
import '../../../../shared/utils/app_formatters.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../models/admin_sale_history.dart';

class AdminSaleHistoryCard extends StatelessWidget {
  final AdminSaleHistory sale;
  final VoidCallback? onPay;
  final VoidCallback? onOpen;

  const AdminSaleHistoryCard({
    super.key,
    required this.sale,
    this.onPay,
    this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = formatAppDateTime(sale.soldAt);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: ResponsiveHelper.responsiveHorizontalMargin(context),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDF2F7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onOpen,
          child: Padding(
        padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header: Product & Price ────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${sale.productName} -- ${sale.productModel}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${sale.sellPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006B2C),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSaleTypeBadge(sale.saleType, sale.rentStatus),
                        const SizedBox(width: 6),
                        _buildPaymentBadge(sale),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            sale.billNumber,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ── Info Grid Box ─────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Column(
                children: [
                  // Row 1: Customer & Shop
                  Row(
                    children: [
                      Expanded(
                        child: _MetaItem(
                          icon: Icons.person_outline_rounded,
                          label: 'Customer',
                          value: sale.customerName ?? 'Walk-in Customer',
                          subValue: sale.customerPhone,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _MetaItem(
                          icon: Icons.storefront_outlined,
                          label: 'Shop / Seller',
                          value: sale.shopName,
                          subValue: '@${sale.userName}',
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(height: 1, thickness: 1, color: Color(0xFFE2E8F0)),
                  ),
                  // Row 2: Serial & Qty
                  Row(
                    children: [
                      Expanded(
                        child: _MetaItem(
                          icon: sale.hasUnitSerial
                              ? Icons.qr_code_rounded
                              : Icons.directions_car_outlined,
                          label: sale.hasUnitSerial ? 'Serial Number' : 'Vehicle',
                          value: sale.hasUnitSerial
                              ? sale.serialNumber
                              : (sale.vehicleNumber ?? sale.place ?? '—'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _MetaItem(
                          icon: Icons.receipt_long_outlined,
                          label: 'Bill',
                          value: sale.billNumber,
                        ),
                      ),
                    ],
                  ),
                  if (sale.scrapSerial != null && sale.scrapSerial!.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(height: 1, thickness: 1, color: Color(0xFFE2E8F0)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _MetaItem(
                            icon: Icons.recycling_rounded,
                            label: 'Scrap Trade-in Serial',
                            value: sale.scrapSerial!,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (sale.place != null && sale.place!.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(height: 1, thickness: 1, color: Color(0xFFE2E8F0)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _MetaItem(
                            icon: Icons.location_on_outlined,
                            label: 'Service Location / Site',
                            value: sale.place!,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (sale.rentStatus != null) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(height: 1, thickness: 1, color: Color(0xFFE2E8F0)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _MetaItem(
                            icon: Icons.assignment_return_outlined,
                            label: 'Rental Status',
                            value: (sale.rentStatus ?? '').toUpperCase() ==
                                    'RETURNED'
                                ? 'Returned'
                                : 'Rented',
                          ),
                        ),
                        if (sale.deposit != null) ...[
                          const SizedBox(width: 8),
                          Expanded(
                            child: _MetaItem(
                              icon: Icons.account_balance_wallet_outlined,
                              label: 'Deposit Paid',
                              value: '₹${sale.deposit!.toStringAsFixed(0)}',
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Footer: Date & Shipment Status ─────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.access_time_rounded, size: 13, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 4),
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                if (sale.shipment != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFDCFCE7)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.local_shipping_outlined, size: 12, color: Color(0xFF16A34A)),
                        const SizedBox(width: 4),
                        Text(
                          sale.shipment!.shipmentNumber,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF16A34A),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      sale.saleType == 'SERVICE'
                          ? 'Service Bill'
                          : sale.saleType == 'RENT' &&
                                  (sale.rentStatus ?? '').toUpperCase() ==
                                      'RETURNED'
                              ? 'Return vs RENT-${sale.id}'
                              : sale.saleType == 'RENT'
                                  ? 'Rent Bill'
                                  : 'Direct Sale',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ),
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

  Widget _buildSaleTypeBadge(String saleType, String? rentStatus) {
    final (label, bg, fg) = switch (saleType.toUpperCase()) {
      'SERVICE' => ('SERVICE BILL', const Color(0xFFF3E8FF), const Color(0xFF7E22CE)),
      'RENT' => (rentStatus ?? '').toUpperCase() == 'RETURNED'
          ? ('RENT RETURN', const Color(0xFFE0E7FF), const Color(0xFF3730A3))
          : ('BATTERY RENT', const Color(0xFFE0F2FE), const Color(0xFF0369A1)),
      'SCRAP' => ('SCRAP', const Color(0xFFFFF7ED), const Color(0xFFC2410C)),
      'MECHANIC' => ('MECHANIC', const Color(0xFFEFF6FF), const Color(0xFF1D4ED8)),
      _ => ('NORMAL', const Color(0xFFF0FDF4), const Color(0xFF15803D)),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: fg.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: fg,
        ),
      ),
    );
  }

  Widget _buildPaymentBadge(AdminSaleHistory sale) {
    final credit = sale.hasCreditDue;
    final bg = credit ? const Color(0xFFFFF7ED) : const Color(0xFFF1F5F9);
    final fg = credit ? const Color(0xFFC2410C) : const Color(0xFF475569);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: fg.withValues(alpha: 0.2)),
      ),
      child: Text(
        sale.paymentLabel,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: fg),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? subValue;

  const _MetaItem({
    required this.icon,
    required this.label,
    required this.value,
    this.subValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: const Color(0xFF64748B)),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 1),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (subValue != null && subValue!.isNotEmpty)
                Text(
                  subValue!,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

