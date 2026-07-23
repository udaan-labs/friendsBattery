import 'package:flutter/material.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../repository/shipment_repository.dart';

/// Shared building blocks for admin + seller shipment detail screens.
class ShipmentSectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const ShipmentSectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF006B2C)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF191C1E),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

class ShipmentInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ShipmentInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF586377)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Color(0xFF586377)),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1E),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ShipmentRowDivider extends StatelessWidget {
  const ShipmentRowDivider({super.key});

  @override
  Widget build(BuildContext context) =>
      const Divider(height: 20, thickness: 1, color: Color(0xFFF0F0F0));
}

class ShipmentStatBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String label;
  final String value;

  const ShipmentStatBox({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: ResponsiveHelper.iconSize(context, 22),
            color: iconColor,
          ),
          SizedBox(height: ResponsiveHelper.isSmallPhone(context) ? 6 : 8),
          Text(
            value,
            style: TextStyle(
              fontSize: ResponsiveHelper.fontSize(context, 24),
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
          SizedBox(height: ResponsiveHelper.isSmallPhone(context) ? 1 : 2),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF586377)),
          ),
        ],
      ),
    );
  }
}

class ShipmentProductCard extends StatelessWidget {
  final ShipmentItemDetailModel item;
  final int index;

  const ShipmentProductCard({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final breadcrumb = [
      if (item.productGroup.isNotEmpty) item.productGroup,
      if (item.category.isNotEmpty) item.category,
      if (item.productName.isNotEmpty) item.productName,
    ].join(' • ');

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFECEEF0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF006B2C).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF006B2C),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productModel.isNotEmpty
                        ? item.productModel
                        : 'Unknown Model',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                  if (breadcrumb.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      breadcrumb,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF586377),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _Chip(
                        icon: Icons.inventory_2_outlined,
                        label:
                            '${item.quantity} unit${item.quantity != 1 ? 's' : ''}',
                        color: const Color(0xFF006B2C),
                        bg: const Color(0xFFE8F5E9),
                      ),
                      if (item.serialNumber != null &&
                          item.serialNumber!.isNotEmpty)
                        _Chip(
                          icon: Icons.qr_code_rounded,
                          label: item.serialNumber!,
                          color: const Color(0xFF1565C0),
                          bg: const Color(0xFFE3F2FD),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bg;

  const _Chip({
    required this.icon,
    required this.label,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
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
}
