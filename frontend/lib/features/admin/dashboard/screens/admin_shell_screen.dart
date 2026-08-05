import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/responsive_helper.dart';

class AdminShellScreen extends StatelessWidget {
  final Widget child;

  const AdminShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    
    // Determine the current index based on the route
    int currentIndex = 0;
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/admin/dashboard')) {
      currentIndex = 0;
    } else if (location.startsWith('/admin/sellers') ||
        location.startsWith('/admin/add-seller') ||
        location.startsWith('/admin/shops') ||
        location.startsWith('/admin/warehouses') ||
        location.startsWith('/admin/add-employee')) {
      currentIndex = 1;
    } else if (location.startsWith('/admin/inventory') || location.startsWith('/admin/add-stock')) {
      currentIndex = 2;
    } else if (location.startsWith('/admin/shipments') || location.startsWith('/admin/sales')) {
      currentIndex = 3;
    }

    return PopScope(
      canPop: currentIndex == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && currentIndex != 0) {
          context.go('/admin/dashboard');
        }
      },
      child: Scaffold(
        body: child,
        bottomNavigationBar: !isDesktop
          ? BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                if (index == 0) {
                  context.go('/admin/dashboard');
                } else if (index == 1) {
                  context.go('/admin/sellers');
                } else if (index == 2) {
                  context.push('/admin/inventory');
                } else if (index == 3) {
                  context.go('/admin/shipments');
                }
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFFECEEF0),
              selectedItemColor: const Color(0xFF006B2C),
              unselectedItemColor: const Color(0xFF586377),
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_outlined),
                  activeIcon: Icon(Icons.grid_view_rounded),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline_rounded),
                  activeIcon: Icon(Icons.people_alt_rounded),
                  label: 'Sellers',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2_outlined),
                  activeIcon: Icon(Icons.inventory_2_rounded),
                  label: 'Stock',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_shipping_outlined),
                  activeIcon: Icon(Icons.local_shipping_rounded),
                  label: 'Shipments',
                ),
              ],
            )
          : null,
      ),
    );
  }
}
