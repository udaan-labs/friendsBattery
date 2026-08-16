import 'package:flutter/material.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

/// Name / code / address for a shop or warehouse.
class LocationHeaderCard extends StatelessWidget {
  const LocationHeaderCard({
    super.key,
    this.staffLocation,
    this.cached,
  });

  final SellerDetailLocation? staffLocation;
  final LocationItem? cached;

  @override
  Widget build(BuildContext context) {
    final isShop = cached?.type == LocationItemTypeEnum.SHOP ||
        staffLocation?.type == 'SHOP';
    final name = cached?.name ??
        staffLocation?.name ??
        (isShop ? 'Shop' : 'Warehouse');
    final code = cached?.code ?? staffLocation?.code;
    final address = cached?.address;
    final phone = cached?.phone;
    final hasGps = cached?.latitude != null && cached?.longitude != null;
    final radius = cached?.allowedRadius ?? 100;
    final accent = isShop ? const Color(0xFF006B2C) : const Color(0xFF2563EB);

    final lines = <String>[
      if (code != null && code.isNotEmpty) code,
      if (address != null && address.isNotEmpty) address,
      if (phone != null && phone.isNotEmpty) phone,
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: accent.withValues(alpha: 0.12),
            child: Icon(
              isShop ? Icons.storefront_rounded : Icons.warehouse_rounded,
              color: accent,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                if (lines.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    lines.join(' · '),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  hasGps ? 'GPS set · ${radius}m radius' : 'GPS not set',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: hasGps
                        ? const Color(0xFF006B2C)
                        : const Color(0xFFB45309),
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
