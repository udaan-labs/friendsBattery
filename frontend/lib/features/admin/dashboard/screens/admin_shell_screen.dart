import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/widgets/responsive_helper.dart';

class AdminShellScreen extends ConsumerWidget {
  final Widget child;

  const AdminShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isSuperAdmin = ref.watch(authProvider).role == UserRole.superAdmin;

    // Determine the current index based on the route
    int currentIndex = 0;
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/admin/dashboard')) {
      currentIndex = 0;
    } else if (location.startsWith('/admin/sellers') ||
        location.startsWith('/admin/add-seller') ||
        location.startsWith('/admin/accounts') ||
        location.startsWith('/admin/shops') ||
        location.startsWith('/admin/warehouses') ||
        location.startsWith('/admin/locations') ||
        location.startsWith('/admin/add-employee')) {
      currentIndex = 1;
    } else if (isSuperAdmin &&
        (location.startsWith('/admin/add-product') ||
            location.startsWith('/admin/inventory') ||
            location.startsWith('/admin/add-stock'))) {
      // Super Admin has no owned inventory — 3rd tab is catalog / configure.
      currentIndex = 2;
    } else if (!isSuperAdmin &&
        (location.startsWith('/admin/inventory') ||
            location.startsWith('/admin/add-stock'))) {
      currentIndex = 2;
    } else if (location.startsWith('/admin/shipments') ||
        location.startsWith('/admin/sales')) {
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
                currentIndex: currentIndex.clamp(0, 3),
                onTap: (index) {
                  if (index == 0) {
                    context.go('/admin/dashboard');
                  } else if (index == 1) {
                    context.go('/admin/sellers');
                  } else if (index == 2) {
                    if (isSuperAdmin) {
                      // SA catalog: configure pricing (no personal stock screen).
                      context.push('/admin/add-product');
                    } else {
                      context.push('/admin/inventory');
                    }
                  } else if (index == 3) {
                    context.go('/admin/shipments');
                  }
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: const Color(0xFFECEEF0),
                selectedItemColor: const Color(0xFF006B2C),
                unselectedItemColor: const Color(0xFF586377),
                showUnselectedLabels: true,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                unselectedLabelStyle: const TextStyle(fontSize: 10),
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.grid_view_outlined),
                    activeIcon: Icon(Icons.grid_view_rounded),
                    label: 'Dashboard',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.people_outline_rounded),
                    activeIcon: Icon(Icons.people_alt_rounded),
                    label: 'Sellers',
                  ),
                  if (isSuperAdmin)
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.price_change_outlined),
                      activeIcon: Icon(Icons.price_change),
                      label: 'Configure',
                    )
                  else
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.inventory_2_outlined),
                      activeIcon: Icon(Icons.inventory_2_rounded),
                      label: 'Stock',
                    ),
                  const BottomNavigationBarItem(
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
