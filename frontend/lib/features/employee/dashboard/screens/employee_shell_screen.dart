import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/logout_dialog_helper.dart';
import '../../../../shared/widgets/responsive_helper.dart';
import '../../../../theme/app_theme.dart';

final employeeScaffoldKey = GlobalKey<ScaffoldState>();

/// Minimal employee shell: home + shop stock + logout.
class EmployeeShellScreen extends ConsumerWidget {
  final Widget child;

  const EmployeeShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String location = GoRouterState.of(context).uri.toString();

    int currentIndex = 0;
    if (location.startsWith('/employee/inventory')) {
      currentIndex = 1;
    }

    return PopScope(
      canPop: currentIndex == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && currentIndex != 0) {
          context.go('/employee/home');
        }
      },
      child: Scaffold(
        key: employeeScaffoldKey,
        drawer: _EmployeeDrawer(currentLocation: location, ref: ref),
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex.clamp(0, 1),
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFECEEF0),
          selectedItemColor: AppTheme.primary,
          unselectedItemColor: const Color(0xFF586377),
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          onTap: (index) {
            if (index == 0) {
              context.go('/employee/home');
            } else if (index == 1) {
              context.go('/employee/inventory');
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2_rounded),
              label: 'Stock',
            ),
          ],
        ),
      ),
    );
  }
}

class _EmployeeDrawer extends StatelessWidget {
  final String currentLocation;
  final WidgetRef ref;

  const _EmployeeDrawer({
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
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                ResponsiveHelper.isSmallPhone(context) ? 16 : 24,
                ResponsiveHelper.isSmallPhone(context) ? 16 : 24,
                ResponsiveHelper.isSmallPhone(context) ? 16 : 24,
                ResponsiveHelper.isSmallPhone(context) ? 16 : 20,
              ),
              decoration: const BoxDecoration(
                color: AppTheme.primary,
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
                      Icons.badge_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Friends Battery',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Employee',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.home_rounded,
                      color: _isActive('/employee/home') ? AppTheme.primary : const Color(0xFF3E4A3D),
                    ),
                    title: Text(
                      'Home',
                      style: TextStyle(
                        fontWeight: _isActive('/employee/home') ? FontWeight.bold : FontWeight.w500,
                        color: _isActive('/employee/home') ? AppTheme.primary : const Color(0xFF3E4A3D),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.go('/employee/home');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.inventory_2_rounded,
                      color: _isActive('/employee/inventory') ? AppTheme.primary : const Color(0xFF3E4A3D),
                    ),
                    title: Text(
                      'Shop stock',
                      style: TextStyle(
                        fontWeight: _isActive('/employee/inventory') ? FontWeight.bold : FontWeight.w500,
                        color: _isActive('/employee/inventory') ? AppTheme.primary : const Color(0xFF3E4A3D),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.go('/employee/inventory');
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Color(0xFFDC2626)),
              title: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFDC2626)),
              ),
              onTap: () {
                Navigator.of(context).pop();
                showLogoutConfirmationDialog(context, ref);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
