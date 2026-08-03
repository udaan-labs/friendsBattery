import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart'; // admin add-seller only
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
import '../../features/employee/dashboard/screens/employee_shell_screen.dart';
import '../../features/employee/dashboard/screens/employee_home_screen.dart';
import '../../features/employee/attendance/presentation/employee_attendance_screen.dart';
import '../../features/employee/shipments/screens/employee_shipments_screen.dart';
import '../../features/employee/shipments/screens/employee_shipment_detail_screen.dart';
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

      // Public self-register closed (admin-only via /admin/add-seller)
      if (!authState.isAuthenticated) {
        if (isSplash || isLoggingIn) return null;
        return '/login';
      }

      if ((isLoggingIn || isSplash || state.uri.path == '/register') && authState.isAuthenticated) {
        if (authState.role == UserRole.admin) return '/admin/dashboard';
        if (authState.role == UserRole.seller) return '/seller/dashboard';
        if (authState.role == UserRole.employee) return '/employee/home';
        return '/login';
      }

      if (authState.isAuthenticated) {
        final path = state.uri.path;
        // Guest / unknown role: never stay in app shell
        if (authState.role == UserRole.guest) {
          return '/login';
        }
        if (path.startsWith('/admin') && authState.role != UserRole.admin) {
          if (authState.role == UserRole.seller) return '/seller/dashboard';
          if (authState.role == UserRole.employee) return '/employee/home';
          return '/login';
        }
        if (path.startsWith('/seller') && authState.role != UserRole.seller) {
          if (authState.role == UserRole.admin) return '/admin/dashboard';
          if (authState.role == UserRole.employee) return '/employee/home';
          return '/login';
        }
        if (path.startsWith('/employee') && authState.role != UserRole.employee) {
          if (authState.role == UserRole.admin) return '/admin/dashboard';
          if (authState.role == UserRole.seller) return '/seller/dashboard';
          return '/login';
        }
        // Shared inventory deep links: any real role OK; guest already redirected
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
              final id = int.tryParse(state.pathParameters['id'] ?? '');
              if (id == null) {
                return const Scaffold(body: Center(child: Text('Invalid seller')));
              }
              return SellerDetailsScreen(sellerId: id);
            },
          ),
          GoRoute(
            path: '/admin/sales',
            builder: (context, state) => const AdminSalesScreen(),
          ),
          GoRoute(
            path: '/admin/shipments/:id',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '');
              if (id == null) {
                return const Scaffold(body: Center(child: Text('Invalid shipment')));
              }
              return AdminShipmentDetailScreen(shipmentId: id);
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
              final id = int.tryParse(state.pathParameters['id'] ?? '');
              if (id == null) {
                return const Scaffold(body: Center(child: Text('Invalid sale')));
              }
              return SellerSaleDetailsScreen(saleId: id);
            },
          ),
          GoRoute(
            path: '/seller/return-product',
            builder: (context, state) => const SellerReturnProductScreen(),
          ),
          GoRoute(
            path: '/seller/shipments/:shipmentId',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['shipmentId'] ?? '');
              if (id == null) {
                return const Scaffold(body: Center(child: Text('Invalid shipment')));
              }
              return ShipmentDetailsScreen(shipmentId: id);
            },
          ),
        ],
      ),

      // ── Employee shell ───────────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => EmployeeShellScreen(child: child),
        routes: [
          GoRoute(
            path: '/employee/home',
            builder: (context, state) => const EmployeeHomeScreen(),
          ),
          GoRoute(
            path: '/employee/inventory',
            builder: (context, state) => const CurrentInventoryScreen(),
          ),
          GoRoute(
            path: '/employee/attendance',
            builder: (context, state) => const EmployeeAttendanceScreen(),
          ),
          GoRoute(
            path: '/employee/shipments',
            builder: (context, state) => const EmployeeShipmentsScreen(),
          ),
          GoRoute(
            path: '/employee/shipments/:shipmentId',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['shipmentId'] ?? '');
              if (id == null) {
                return const Scaffold(body: Center(child: Text('Invalid shipment')));
              }
              return EmployeeShipmentDetailScreen(shipmentId: id);
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
          final id = int.tryParse(state.pathParameters['productId'] ?? '');
          if (id == null) {
            return const Scaffold(body: Center(child: Text('Invalid product')));
          }
          return InventoryProductDetailScreen(productId: id);
        },
      ),
    ],
  );
});

