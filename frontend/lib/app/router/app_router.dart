import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/admin/dashboard/screens/admin_dashboard_screen.dart';
import '../../features/admin/inventory/screens/add_stock_screen.dart';
import '../../features/admin/shipments/screens/shipment_list_screen.dart';
import '../../features/admin/shipments/screens/create_shipment_screen.dart';
import '../../features/seller/dashboard/screens/seller_dashboard_screen.dart';
import '../../features/seller/dashboard/screens/create_bill_screen.dart';
import '../../features/seller/dashboard/screens/shipment_details_screen.dart';
import '../../features/shared/inventory/screens/current_inventory_screen.dart';
import '../../features/admin/sellers/screens/sellers_list_screen.dart';
import '../../features/admin/sellers/screens/seller_details_screen.dart';
import '../../shared/providers/auth_provider.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoggingIn = state.uri.toString() == '/login';
      final isSplash = state.uri.toString() == '/splash';
      
      if (!authState.isAuthenticated) {
        if (isSplash || isLoggingIn || state.uri.toString() == '/register') return null;
        return '/login';
      }

      if ((isLoggingIn || isSplash || state.uri.toString() == '/register') && authState.isAuthenticated) {
        return authState.role == UserRole.admin ? '/admin/dashboard' : '/seller/dashboard';
      }

      if (authState.isAuthenticated) {
        final path = state.uri.toString();
        if (path.startsWith('/admin') && authState.role != UserRole.admin) {
          return '/seller/dashboard';
        }
        if (path.startsWith('/seller') && authState.role != UserRole.seller) {
          return '/admin/dashboard';
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(isAdminFlow: false),
      ),
      GoRoute(
        path: '/admin/dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: '/admin/add-seller',
        builder: (context, state) => const RegisterScreen(isAdminFlow: true),
      ),
      GoRoute(
        path: '/admin/add-stock',
        builder: (context, state) => const AddStockScreen(),
      ),
      GoRoute(
        path: '/admin/shipments',
        builder: (context, state) => const ShipmentListScreen(),
      ),
      GoRoute(
        path: '/admin/shipments/create',
        builder: (context, state) => const CreateShipmentScreen(),
      ),
      GoRoute(
        path: '/admin/sellers',
        builder: (context, state) => const SellersListScreen(),
      ),
      GoRoute(
        path: '/admin/sellers/:id',
        builder: (context, state) {
          final idStr = state.pathParameters['id']!;
          return SellerDetailsScreen(sellerId: int.parse(idStr));
        },
      ),
      GoRoute(
        path: '/seller/dashboard',
        builder: (context, state) => const SellerDashboardScreen(),
      ),
      GoRoute(
        path: '/seller/create-bill',
        builder: (context, state) => const CreateBillScreen(),
      ),
      GoRoute(
        path: '/seller/shipments/:shipmentId',
        builder: (context, state) {
          final shipmentIdStr = state.pathParameters['shipmentId']!;
          return ShipmentDetailsScreen(shipmentId: int.parse(shipmentIdStr));
        },
      ),
      GoRoute(
        path: '/shared/inventory',
        builder: (context, state) => const CurrentInventoryScreen(),
      ),
    ],
  );
});

