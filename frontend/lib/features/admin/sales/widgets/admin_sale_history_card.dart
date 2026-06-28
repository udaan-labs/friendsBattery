import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/admin_sale_history.dart';

class AdminSaleHistoryCard extends StatelessWidget {
  final AdminSaleHistory sale;

  const AdminSaleHistoryCard({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd MMM yyyy, hh:mm a');
    final formattedDate = dateFormatter.format(sale.soldAt);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top accent strip ──────────────────────────────────────
            Container(
              height: 4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF16A34A), Color(0xFF4ADE80)],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top Section: Product Name | Price + Date ──────────
                  Row(
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
                            ),
                            const SizedBox(height: 2),
                            Text(
                              sale.productModel,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF586377),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 12,
                                  color: Color(0xFF9BA8B6),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF9BA8B6),
                                  ),
                                ),
                              ],
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
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFF16A34A).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Sale #${sale.id}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF16A34A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const _Divider(),

                  // ── Customer Section ──────────────────────────────────
                  _SectionRow(
                    icon: Icons.person_outline_rounded,
                    iconColor: const Color(0xFF3B82F6),
                    iconBgColor: const Color(0xFFEFF6FF),
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
                        if (sale.customerPhone != null &&
                            sale.customerPhone!.isNotEmpty)
                          Text(
                            sale.customerPhone!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF586377),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Seller Section ────────────────────────────────────
                  _SectionRow(
                    icon: Icons.store_outlined,
                    iconColor: const Color(0xFF7C3AED),
                    iconBgColor: const Color(0xFFF5F3FF),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            sale.shopName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF191C1E),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7C3AED).withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '@${sale.userName}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7C3AED),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const _Divider(),

                  // ── Product Section ───────────────────────────────────
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 360) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(child: _InfoItem(icon: Icons.category_outlined, label: 'Category', value: sale.category)),
                                const SizedBox(width: 8),
                                Expanded(child: _InfoItem(icon: Icons.tag_rounded, label: 'Serial No', value: sale.serialNumber)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            _InfoItem(icon: Icons.inventory_2_outlined, label: 'Qty', value: sale.quantity.toString()),
                          ],
                        );
                      }
                      return Row(
                        children: [
                          Expanded(child: _InfoItem(icon: Icons.category_outlined, label: 'Category', value: sale.category)),
                          Expanded(child: _InfoItem(icon: Icons.tag_rounded, label: 'Serial No', value: sale.serialNumber)),
                          Expanded(child: _InfoItem(icon: Icons.inventory_2_outlined, label: 'Qty', value: sale.quantity.toString())),
                        ],
                      );
                    },
                  ),

                  const _Divider(),

                  // ── Shipment Section ──────────────────────────────────
                  _ShipmentRow(shipment: sale.shipment),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shipment row ─────────────────────────────────────────────────────────

class _ShipmentRow extends StatelessWidget {
  final AdminShipmentInfo? shipment;

  const _ShipmentRow({this.shipment});

  Color _statusColor(String status) {
    switch (status.toUpperCase()) {
      case 'ACCEPTED':
        return const Color(0xFF16A34A);
      case 'PENDING':
        return const Color(0xFFC05600);
      case 'REJECTED':
        return const Color(0xFFBA1A1A);
      default:
        return const Color(0xFF586377);
    }
  }

  Color _statusBg(String status) {
    switch (status.toUpperCase()) {
      case 'ACCEPTED':
        return const Color(0xFFDCFCE7);
      case 'PENDING':
        return const Color(0xFFFFF7ED);
      case 'REJECTED':
        return const Color(0xFFFFEBEE);
      default:
        return const Color(0xFFECEEF0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (shipment == null) {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.local_shipping_outlined,
                size: 16, color: Color(0xFF9BA8B6)),
          ),
          const SizedBox(width: 10),
          const Text(
            'No Shipment Linked',
            style: TextStyle(fontSize: 13, color: Color(0xFF9BA8B6)),
          ),
        ],
      );
    }

    final dateFormatter = DateFormat('dd MMM yyyy');
    final arrivalStr = shipment!.arrivalDate != null
        ? dateFormatter.format(shipment!.arrivalDate!)
        : '—';

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.local_shipping_outlined,
              size: 16, color: Color(0xFF16A34A)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shipment!.shipmentNumber,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1E),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (shipment!.arrivalDate != null)
                Text(
                  'Arrived $arrivalStr',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9BA8B6),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _statusBg(shipment!.status),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            shipment!.status.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: _statusColor(shipment!.status),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Helper widgets ────────────────────────────────────────────────────────

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, color: Color(0xFFEEF0F2)),
    );
  }
}

class _SectionRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final Widget child;

  const _SectionRow({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: iconColor),
        ),
        const SizedBox(width: 10),
        Expanded(child: child),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 11, color: const Color(0xFF9BA8B6)),
            const SizedBox(width: 3),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF9BA8B6),
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
