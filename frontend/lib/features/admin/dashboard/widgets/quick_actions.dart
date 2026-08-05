import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/responsive_helper.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmall = ResponsiveHelper.isSmallPhone(context);
    final titleSize = isSmall ? 16.0 : 18.0;

    final actions = [
      _ActionItemData(
        title: 'Add Stock',
        subtitle: 'Add new inventory items',
        icon: Icons.add_box_outlined,
        route: '/admin/add-stock',
      ),
      _ActionItemData(
        title: 'Assign Stock',
        subtitle: 'Transfer stock to seller',
        icon: Icons.move_to_inbox_outlined,
        route: '/admin/shipments/create',
      ),
      _ActionItemData(
        title: 'Add Seller',
        subtitle: 'Create new seller account',
        icon: Icons.person_add_alt_1_outlined,
        route: '/admin/add-seller',
      ),
      _ActionItemData(
        title: 'Shops',
        subtitle: 'List & create shop locations',
        icon: Icons.storefront_outlined,
        route: '/admin/shops',
      ),
      _ActionItemData(
        title: 'Warehouses',
        subtitle: 'List & create warehouses',
        icon: Icons.warehouse_outlined,
        route: '/admin/warehouses',
      ),
      _ActionItemData(
        title: 'View Sales',
        subtitle: 'Browse all sales transactions',
        icon: Icons.point_of_sale_outlined,
        route: '/admin/sales',
      ),
      _ActionItemData(
        title: 'Shipments',
        subtitle: 'Track stock transfers',
        icon: Icons.local_shipping_outlined,
        route: '/admin/shipments',
      ),
    ];

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.responsiveHorizontalMargin(context)),
            child: Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF191C1E),
              ),
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.responsiveHorizontalMargin(context)),
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.5,
                    children: actions.map((a) => _ActionItem(
                      title: a.title,
                      subtitle: a.subtitle,
                      icon: a.icon,
                      isSmall: isSmall,
                      onTap: () => context.push(a.route),
                    )).toList(),
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.symmetric(horizontal: ResponsiveHelper.responsiveHorizontalMargin(context)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFECEEF0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    for (var i = 0; i < actions.length; i++)
                      Column(
                        children: [
                          _ActionItem(
                            title: actions[i].title,
                            subtitle: actions[i].subtitle,
                            icon: actions[i].icon,
                            isSmall: isSmall,
                            onTap: () => context.push(actions[i].route),
                          ),
                          if (i < actions.length - 1)
                            const Divider(height: 1, color: Color(0xFFECEEF0)),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActionItemData {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  const _ActionItemData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });
}



class _ActionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSmall;

  const _ActionItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = isSmall ? 18.0 : 20.0;
    final titleSize = isSmall ? 13.0 : 14.0;
    final subtitleSize = isSmall ? 10.0 : 11.0;
    final iconContainerSize = isSmall ? 36.0 : 40.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isSmall ? 12 : 16, vertical: isSmall ? 10 : 12),
        child: Row(
          children: [
            Container(
              width: iconContainerSize,
              height: iconContainerSize,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: const Color(0xFF006B2C),
                size: iconSize,
              ),
            ),
            SizedBox(width: isSmall ? 12 : 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF191C1E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: subtitleSize,
                      color: const Color(0xFF586377),
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
