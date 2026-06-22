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
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF191C1E),
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _ActionButton(
                title: 'Add Stock',
                icon: Icons.add_box,
                bgColor: const Color(0xFFD5E0F8), // secondary-container
                textColor: const Color(0xFF586377), // on-secondary-container
                onTap: () {},
              ),
              _ActionButton(
                title: 'Assign Stock',
                icon: Icons.assignment_ind,
                bgColor: const Color(0xFF00873A), // primary-container
                textColor: const Color(0xFFF7FFF2), // on-primary-container
                onTap: () {},
              ),
              _ActionButton(
                title: 'Add Seller',
                icon: Icons.person_add,
                bgColor: const Color(0xFFE6E8EA), // surface-container-high
                textColor: const Color(0xFF191C1E), // on-surface
                onTap: () {
                  context.push('/admin/add-seller');
                },
              ),
              _ActionButton(
                title: 'Shipments',
                icon: Icons.local_shipping,
                bgColor: const Color(0xFFDBE1FF), // tertiary-fixed
                textColor: const Color(0xFF003EA8), // on-tertiary-fixed-variant
                onTap: () {},
              ),
            ],
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
  final Color textColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 36,
                color: textColor,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
