import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class SellerQuickActions extends StatelessWidget {
  const SellerQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF191C1E),
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final double ratio = constraints.maxWidth < 360 ? 1.0 : 1.25;
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: ratio,
                children: [
                  _ActionButton(
                    title: 'Create Bill',
                    icon: Icons.receipt_long,
                    bgColor: Colors.white,
                    iconBgColor: const Color(0xFFD5E0F8),
                    iconColor: const Color(0xFF16A34A),
                    onTap: () {
                      context.push('/seller/create-bill');
                    },
                  ),
                  _ActionButton(
                    title: 'Service Bill',
                    icon: Icons.build_circle_outlined,
                    bgColor: Colors.white,
                    iconBgColor: const Color(0xFFD5E0F8),
                    iconColor: const Color(0xFF16A34A),
                    onTap: () {
                      context.push('/seller/service-bill');
                    },
                  ),
                  _ActionButton(
                    title: 'Battery Rent',
                    icon: Icons.battery_charging_full,
                    bgColor: Colors.white,
                    iconBgColor: const Color(0xFFD5E0F8),
                    iconColor: const Color(0xFF16A34A),
                    onTap: () {
                      context.push('/seller/battery-rent');
                    },
                  ),
                  _ActionButton(
                    title: 'Return Product',
                    icon: Icons.assignment_return_rounded,
                    bgColor: Colors.white,
                    iconBgColor: const Color(0xFFD5E0F8),
                    iconColor: const Color(0xFF16A34A),
                    onTap: () {
                      context.push('/seller/return-product');
                    },
                  ),
                  _ActionButton(
                    title: 'Sales History',
                    icon: Icons.bar_chart,
                    bgColor: Colors.white,
                    iconBgColor: const Color(0xFFD5E0F8),
                    iconColor: const Color(0xFF16A34A),
                    onTap: () {
                      context.push('/seller/sales-history');
                    },
                  ),
                  _ActionButton(
                    title: 'Stock Details',
                    icon: Icons.inventory_2,
                    bgColor: Colors.white,
                    iconBgColor: const Color(0xFFD5E0F8),
                    iconColor: const Color(0xFF16A34A),
                    onTap: () {
                      context.push('/seller/inventory');
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxHeight < 115;
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: isSmall ? 8.0 : 16.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(isSmall ? 8.0 : 12.0),
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        size: isSmall ? 22 : 28,
                        color: iconColor,
                      ),
                    ),
                    SizedBox(height: isSmall ? 6 : 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isSmall ? 12 : 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF191C1E),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
