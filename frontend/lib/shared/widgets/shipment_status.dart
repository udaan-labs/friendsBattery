import 'package:flutter/material.dart';
import 'responsive_helper.dart';

// ── Style ───────────────────────────────────────────────────────────────────

/// Shared shipment status colors / icons (admin, seller, employee).
class ShipmentStatusStyle {
  const ShipmentStatusStyle._({
    required this.foreground,
    required this.background,
    required this.icon,
  });

  final Color foreground;
  final Color background;
  final IconData icon;

  static ShipmentStatusStyle of(String status) {
    switch (status.toUpperCase()) {
      case 'ACCEPTED':
      case 'RECEIVED':
        return const ShipmentStatusStyle._(
          foreground: Color(0xFF00873A),
          background: Color(0xFFE8F5E9),
          icon: Icons.check_circle_rounded,
        );
      case 'PENDING':
        return const ShipmentStatusStyle._(
          foreground: Color(0xFFC05600),
          background: Color(0xFFFFF3E0),
          icon: Icons.schedule_rounded,
        );
      case 'REJECTED':
        return const ShipmentStatusStyle._(
          foreground: Color(0xFFBA1A1A),
          background: Color(0xFFFFEBEE),
          icon: Icons.cancel_rounded,
        );
      default:
        return const ShipmentStatusStyle._(
          foreground: Color(0xFF586377),
          background: Color(0xFFECEEF0),
          icon: Icons.info_rounded,
        );
    }
  }
}

// ── Compact chip (lists / cards) ────────────────────────────────────────────

class ShipmentStatusChip extends StatelessWidget {
  const ShipmentStatusChip({
    super.key,
    required this.status,
    this.showIcon = true,
    this.fontSize = 12,
    this.iconSize = 13,
  });

  final String status;
  final bool showIcon;
  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final style = ShipmentStatusStyle.of(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(style.icon, size: iconSize, color: style.foreground),
            const SizedBox(width: 4),
          ],
          Text(
            status.toUpperCase(),
            style: TextStyle(
              color: style.foreground,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Icon tile (list leading) ────────────────────────────────────────────────

class ShipmentStatusIconBox extends StatelessWidget {
  const ShipmentStatusIconBox({
    super.key,
    required this.status,
    this.size = 48,
    this.iconSize = 26,
  });

  final String status;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final style = ShipmentStatusStyle.of(status);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(style.icon, color: style.foreground, size: iconSize),
    );
  }
}

// ── Full banner (detail screens) ────────────────────────────────────────────

class ShipmentStatusBanner extends StatelessWidget {
  const ShipmentStatusBanner({
    super.key,
    required this.status,
    this.iconSize = 24,
    this.titleSize = 18,
  });

  final String status;
  final double iconSize;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    final style = ShipmentStatusStyle.of(status);
    final isSmall = ResponsiveHelper.isSmallPhone(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isSmall ? 12 : 16,
        horizontal: isSmall ? 16 : 20,
      ),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: style.foreground.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(style.icon, color: style.foreground, size: iconSize),
          SizedBox(width: iconSize > 24 ? 14 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Shipment Status',
                  style: TextStyle(fontSize: 12, color: Color(0xFF586377)),
                ),
                const SizedBox(height: 2),
                Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: titleSize,
                    color: style.foreground,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
