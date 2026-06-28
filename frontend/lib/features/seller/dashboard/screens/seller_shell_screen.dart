import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../shared/widgets/logout_dialog_helper.dart';

final sellerScaffoldKey = GlobalKey<ScaffoldState>();

class SellerShellScreen extends ConsumerWidget {
  final Widget child;

  const SellerShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final String location = GoRouterState.of(context).uri.toString();

    // Determine active bottom nav index
    int currentIndex = 0;
    if (location.startsWith('/seller/dashboard')) {
      currentIndex = 0;
    } else if (location.startsWith('/seller/inventory')) {
      currentIndex = 1;
    } else if (location.startsWith('/seller/create-bill')) {
      currentIndex = 2;
    } else if (location.startsWith('/seller/received-shipments')) {
      currentIndex = 3;
    }

    return Scaffold(
      key: sellerScaffoldKey,
      drawer: _SellerDrawer(currentLocation: location, ref: ref),
      body: child,
      bottomNavigationBar: !isDesktop
          ? BottomNavigationBar(
              currentIndex: currentIndex.clamp(0, 3),
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFFECEEF0),
              selectedItemColor: const Color(0xFF16A34A),
              unselectedItemColor: const Color(0xFF586377),
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              onTap: (index) {
                if (index == 0) {
                  context.go('/seller/dashboard');
                } else if (index == 1) {
                  context.go('/seller/inventory');
                } else if (index == 2) {
                  context.go('/seller/create-bill');
                } else if (index == 3) {
                  context.go('/seller/received-shipments');
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined),
                  activeIcon: Icon(Icons.dashboard_rounded),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2_outlined),
                  activeIcon: Icon(Icons.inventory_2_rounded),
                  label: 'Stock',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_outlined),
                  activeIcon: Icon(Icons.receipt_long_rounded),
                  label: 'Create Bill',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_shipping_outlined),
                  activeIcon: Icon(Icons.local_shipping_rounded),
                  label: 'Shipments',
                ),
              ],
            )
          : null,
    );
  }
}

class _SellerDrawer extends StatelessWidget {
  final String currentLocation;
  final WidgetRef ref;

  const _SellerDrawer({
    required this.currentLocation,
    required this.ref,
  });

  bool _isActive(String route) => currentLocation.startsWith(route);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF7F9FB),
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(ResponsiveHelper.isSmallPhone(context) ? 16 : 24, ResponsiveHelper.isSmallPhone(context) ? 16 : 24, ResponsiveHelper.isSmallPhone(context) ? 16 : 24, ResponsiveHelper.isSmallPhone(context) ? 16 : 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF16A34A), Color(0xFF006B2C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.storefront_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'BatteryPro',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Seller Portal',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Menu Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                children: [
                  _DrawerItem(
                    icon: Icons.dashboard_rounded,
                    label: 'Dashboard',
                    isActive: _isActive('/seller/dashboard'),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.go('/seller/dashboard');
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.inventory_2_rounded,
                    label: 'Current Stock',
                    isActive: _isActive('/seller/inventory'),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.go('/seller/inventory');
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.receipt_long_rounded,
                    label: 'Create Bill',
                    isActive: _isActive('/seller/create-bill'),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.go('/seller/create-bill');
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.history_rounded,
                    label: 'Sales History',
                    isActive: _isActive('/seller/sales-history'),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.go('/seller/sales-history');
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.local_shipping_rounded,
                    label: 'Received Shipments',
                    isActive: _isActive('/seller/received-shipments'),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.go('/seller/received-shipments');
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.assignment_return_rounded,
                    label: 'Return Product',
                    isActive: _isActive('/seller/return-product'),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.go('/seller/return-product');
                    },
                  ),
                  const Divider(height: 32, color: Color(0xFFE0E4E8)),
                  _DrawerItem(
                    icon: Icons.logout_rounded,
                    label: 'Logout',
                    isActive: false,
                    iconColor: const Color(0xFFBA1A1A),
                    labelColor: const Color(0xFFBA1A1A),
                    onTap: () {
                      Navigator.of(context).pop();
                      showLogoutConfirmationDialog(context, ref);
                    },
                  ),
                ],
              ),
            ),

            // Footer
            Padding(
              padding: EdgeInsets.all(ResponsiveHelper.responsiveHorizontalMargin(context)),
              child: Text(
                'BatteryPro v1.0',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF16A34A);
    final defaultIconColor = iconColor ?? (isActive ? activeColor : const Color(0xFF3E4A3D));
    final defaultLabelColor = labelColor ?? (isActive ? activeColor : const Color(0xFF191C1E));

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? activeColor.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(
          icon,
          color: defaultIconColor,
          size: 22,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: defaultLabelColor,
          ),
        ),
        trailing: isActive
            ? Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
