import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF191C1E),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFECEEF0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _ActionItem(
                  title: 'Add Stock',
                  subtitle: 'Add new inventory items',
                  icon: Icons.add_box_outlined,
                  onTap: () {
                    context.push('/admin/add-stock');
                  },
                ),
                const Divider(height: 1, color: Color(0xFFECEEF0)),
                _ActionItem(
                  title: 'Assign Stock',
                  subtitle: 'Transfer stock to seller',
                  icon: Icons.move_to_inbox_outlined,
                  onTap: () {
                    // Navigate if needed
                  },
                ),
                const Divider(height: 1, color: Color(0xFFECEEF0)),
                _ActionItem(
                  title: 'Add Seller',
                  subtitle: 'Create new seller account',
                  icon: Icons.person_add_alt_1_outlined,
                  onTap: () {
                    context.push('/admin/add-seller');
                  },
                ),
                const Divider(height: 1, color: Color(0xFFECEEF0)),
                _ActionItem(
                  title: 'Shipments',
                  subtitle: 'Track stock transfers',
                  icon: Icons.local_shipping_outlined,
                  onTap: () {
                    context.push('/admin/shipments');
                  },
                ),
                const Divider(height: 1, color: Color(0xFFECEEF0)),
                _ActionItem(
                  title: 'Reports',
                  subtitle: 'View sales & inventory reports',
                  icon: Icons.analytics_outlined,
                  onTap: () {
                    // Navigate if needed
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9), // light green
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: const Color(0xFF006B2C), // dark green icon
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF586377),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF586377),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
