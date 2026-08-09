import 'package:flutter/material.dart';
import 'package:frontend/shared/common.dart';
import '../models/admin_sale_history.dart';

class AdminSaleHistoryCard extends StatelessWidget {
  final AdminSaleHistory sale;

  const AdminSaleHistoryCard({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    final formattedDate = formatAppDateTime(sale.soldAt);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: ResponsiveHelper.responsiveHorizontalMargin(context)),
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
              padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
                            padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveHelper.isSmallPhone(context) ? 6 : 8, vertical: 3),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveHelper.isSmallPhone(context) ? 6 : 8, vertical: 3),
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

    final arrivalStr = shipment!.arrivalDate != null
        ? formatAppDate(shipment!.arrivalDate!)
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
        ShipmentStatusChip(
          status: shipment!.status,
          showIcon: false,
          fontSize: 11,
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.cardPadding(context) * 0.75),
      child: const Divider(height: 1, color: Color(0xFFEEF0F2)),
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
          padding: EdgeInsets.all(ResponsiveHelper.isSmallPhone(context) ? 4 : 6),
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
