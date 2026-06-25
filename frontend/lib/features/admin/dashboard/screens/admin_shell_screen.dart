import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminShellScreen extends StatelessWidget {
  final Widget child;

  const AdminShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1024;
    
    // Determine the current index based on the route
    int currentIndex = 0;
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/admin/dashboard')) {
      currentIndex = 0;
    } else if (location.startsWith('/admin/sellers') || location.startsWith('/admin/add-seller')) {
      currentIndex = 1;
    } else if (location.startsWith('/admin/inventory') || location.startsWith('/admin/add-stock')) {
      currentIndex = 2;
    } else if (location.startsWith('/admin/shipments')) {
      currentIndex = 3;
    }

    return Scaffold(
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
    );
  }
}
