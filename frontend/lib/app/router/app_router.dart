import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/admin/dashboard/screens/admin_dashboard_screen.dart';
import '../../features/admin/dashboard/screens/admin_shell_screen.dart';
import '../../features/admin/dashboard/screens/admin_activity_history_screen.dart';
import '../../features/admin/inventory/screens/add_stock_screen.dart';
import '../../features/admin/inventory/screens/add_product_screen.dart';
import '../../features/admin/shipments/screens/shipment_list_screen.dart';
import '../../features/admin/shipments/screens/create_shipment_screen.dart';
import '../../features/admin/shipments/screens/admin_shipment_detail_screen.dart';
import '../../features/admin/sales/screens/admin_sales_screen.dart';
import '../../features/seller/dashboard/screens/seller_dashboard_screen.dart';
import '../../features/seller/dashboard/screens/seller_shell_screen.dart';
import '../../features/seller/dashboard/screens/create_bill_screen.dart';
import '../../features/seller/dashboard/screens/shipment_details_screen.dart';
import '../../features/seller/dashboard/screens/seller_received_shipments_screen.dart';
import '../../features/seller/dashboard/screens/sale_success_screen.dart';
import '../../features/seller/dashboard/models/sale_success_data.dart';
import '../../features/seller/dashboard/screens/seller_return_product_screen.dart';
import '../../features/seller/sales/screens/seller_sales_history_screen.dart';
import '../../features/seller/sales/screens/seller_sale_details_screen.dart';
import '../../features/shared/inventory/screens/current_inventory_screen.dart';
import '../../features/shared/inventory/screens/inventory_product_detail_screen.dart';
import '../../features/admin/sellers/screens/sellers_list_screen.dart';
import '../../features/admin/sellers/screens/seller_details_screen.dart';
import '../../features/shared/product_lookup/screens/verify_product_screen.dart';
import '../../shared/providers/auth_provider.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Stable [GoRouter] — auth changes notify via [refreshListenable] instead of
/// recreating the entire router (which rebuilds MaterialApp and all routes).
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.onDispose(refresh.dispose);
  ref.listen<AuthState>(authProvider, (_, __) {
    refresh.value++;
  });

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggingIn = state.uri.toString() == '/login';
      final isSplash = state.uri.toString() == '/splash';

      if (!authState.isAuthenticated) {
        if (isSplash || isLoggingIn || state.uri.toString() == '/register') return null;
        return '/login';
      }

      if ((isLoggingIn || isSplash || state.uri.toString() == '/register') && authState.isAuthenticated) {
        // Employee has no dedicated shell yet — stay on login until employee UI exists.
        if (authState.role == UserRole.admin) return '/admin/dashboard';
        if (authState.role == UserRole.seller) return '/seller/dashboard';
        return '/login';
      }

      if (authState.isAuthenticated) {
        final path = state.uri.toString();
        if (path.startsWith('/admin') && authState.role != UserRole.admin) {
          if (authState.role == UserRole.seller) return '/seller/dashboard';
          return '/login';
        }
        if (path.startsWith('/seller') && authState.role != UserRole.seller) {
          if (authState.role == UserRole.admin) return '/admin/dashboard';
          return '/login';
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

      // ── Admin shell ──────────────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => AdminShellScreen(child: child),
        routes: [
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
            path: '/admin/add-product',
            builder: (context, state) => const AddProductScreen(),
          ),
          GoRoute(
            path: '/admin/inventory',
            builder: (context, state) => const CurrentInventoryScreen(),
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
            path: '/admin/verify-product',
            builder: (context, state) => const VerifyProductScreen(),
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
            path: '/admin/sales',
            builder: (context, state) => const AdminSalesScreen(),
          ),
          GoRoute(
            path: '/admin/shipments/:id',
            builder: (context, state) {
              final idStr = state.pathParameters['id']!;
              return AdminShipmentDetailScreen(shipmentId: int.parse(idStr));
            },
          ),
          GoRoute(
            path: '/admin/activity-history',
            builder: (context, state) => const AdminActivityHistoryScreen(),
          ),
        ],
      ),

      // ── Seller shell ─────────────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => SellerShellScreen(child: child),
        routes: [
          GoRoute(
            path: '/seller/dashboard',
            builder: (context, state) => const SellerDashboardScreen(),
          ),
          GoRoute(
            path: '/seller/verify-product',
            builder: (context, state) => const VerifyProductScreen(),
          ),
          GoRoute(
            path: '/seller/inventory',
            builder: (context, state) => const CurrentInventoryScreen(),
          ),
          GoRoute(
            path: '/seller/create-bill',
            builder: (context, state) => const CreateBillScreen(),
          ),
          GoRoute(
            path: '/seller/sale-success',
            builder: (context, state) {
              final saleData = state.extra as SaleSuccessData?;
              if (saleData == null) {
                return const Scaffold(
                  body: Center(child: Text('Missing sale data')),
                );
              }
              return SaleSuccessScreen(saleData: saleData);
            },
          ),
          GoRoute(
            path: '/seller/received-shipments',
            builder: (context, state) => const SellerReceivedShipmentsScreen(),
          ),
          GoRoute(
            path: '/seller/sales-history',
            builder: (context, state) => const SellerSalesHistoryScreen(),
          ),
          GoRoute(
            path: '/seller/sales/:id',
            builder: (context, state) {
              final idStr = state.pathParameters['id']!;
              return SellerSaleDetailsScreen(saleId: int.parse(idStr));
            },
          ),
          GoRoute(
            path: '/seller/return-product',
            builder: (context, state) => const SellerReturnProductScreen(),
          ),
          GoRoute(
            path: '/seller/shipments/:shipmentId',
            builder: (context, state) {
              final shipmentIdStr = state.pathParameters['shipmentId']!;
              return ShipmentDetailsScreen(shipmentId: int.parse(shipmentIdStr));
            },
          ),
        ],
      ),

      // Legacy shared inventory route (keep for backward compat)
      GoRoute(
        path: '/shared/inventory',
        builder: (context, state) => const CurrentInventoryScreen(),
      ),
      GoRoute(
        path: '/shared/inventory/:productId',
        builder: (context, state) {
          final idStr = state.pathParameters['productId']!;
          return InventoryProductDetailScreen(productId: int.parse(idStr));
        },
      ),
    ],
  );
});

