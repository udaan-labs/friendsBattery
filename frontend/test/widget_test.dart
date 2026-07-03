import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';
import 'package:frontend/app/app.dart';
import 'package:frontend/theme/app_theme.dart';
import 'package:frontend/shared/providers/auth_provider.dart';
import 'package:frontend/features/auth/screens/splash_screen.dart';
import 'package:frontend/features/auth/screens/login_screen.dart';
import 'package:frontend/features/auth/screens/register_screen.dart';
import 'package:frontend/features/admin/dashboard/screens/admin_shell_screen.dart';
import 'package:frontend/features/admin/dashboard/screens/admin_dashboard_screen.dart';
import 'package:frontend/features/admin/dashboard/providers/dashboard_controller.dart';
import 'package:frontend/features/admin/sales/screens/admin_sales_screen.dart';
import 'package:frontend/features/admin/sellers/screens/sellers_list_screen.dart';
import 'package:frontend/features/admin/sellers/screens/seller_details_screen.dart';
import 'package:frontend/features/admin/sellers/providers/sellers_provider.dart' as sl;
import 'package:frontend/features/admin/sellers/providers/seller_details_provider.dart';
import 'package:frontend/features/admin/shipments/screens/shipment_list_screen.dart';
import 'package:frontend/features/admin/shipments/screens/admin_shipment_detail_screen.dart';
import 'package:frontend/features/admin/shipments/providers/shipment_provider.dart';
import 'package:frontend/features/admin/shipments/repository/shipment_repository.dart';
import 'package:frontend/features/admin/inventory/screens/add_stock_screen.dart';
import 'package:frontend/features/shared/inventory/screens/current_inventory_screen.dart';
import 'package:frontend/features/shared/inventory/providers/inventory_provider.dart';
import 'package:frontend/features/shared/inventory/repository/shared_inventory_repository.dart';
import 'package:frontend/features/seller/dashboard/screens/seller_shell_screen.dart';
import 'package:frontend/features/seller/dashboard/screens/seller_dashboard_screen.dart';
import 'package:frontend/features/seller/dashboard/screens/seller_received_shipments_screen.dart';
import 'package:frontend/features/seller/dashboard/providers/seller_dashboard_providers.dart';
import 'package:frontend/features/seller/dashboard/providers/seller_dashboard_controller.dart';
import 'package:frontend/features/seller/sales/screens/seller_sales_history_screen.dart';
import 'helpers/test_helpers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// ═══════════════════════════════════════════════════════════════════════════
// MOCK NOTIFIERS (top-level for whole-file access)
// ═══════════════════════════════════════════════════════════════════════════

class _MockAuthNotifier extends AuthNotifier {
  _MockAuthNotifier() : super();

  @override
  Future<void> initSession() async {}
  @override
  void setAuthenticated(UserRole role) {
    state = state.copyWith(isAuthenticated: true, role: role);
  }
}

final _mockAuthProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return _MockAuthNotifier();
});

class _DashCtrl extends DashboardController {
  _DashCtrl(super.ref);
  @override
  Future<void> refreshAllData() async {}
}

class _SellDashCtrl extends SellerDashboardController {
  _SellDashCtrl(super.ref);
  @override
  Future<void> refreshAllData() async {}
}

// ═══════════════════════════════════════════════════════════════════════════
// BUILDER HELPERS
// ═══════════════════════════════════════════════════════════════════════════

List<Override> _base() => [authProvider.overrideWithProvider(_mockAuthProvider)];

FutureProvider<SellerDetailsData> _sellerDetailsOk(int id) =>
    FutureProvider<SellerDetailsData>((ref) async => mockSellerDetails());

FutureProvider<SellerDetailsData> _sellerDetailsErr(int id) =>
    FutureProvider<SellerDetailsData>((ref) async => throw Exception('Not found'));

FutureProvider<ShipmentDetailModel> _shipDetailOk(int id) =>
    FutureProvider<ShipmentDetailModel>((ref) async => mockShipmentDetail(id: id));

FutureProvider<ShipmentDetailModel> _shipDetailErr(int id) =>
    FutureProvider<ShipmentDetailModel>((ref) async => throw Exception('Failed to load'));

FutureProvider<PaginatedInventoryResponse> _invOk() =>
    FutureProvider<PaginatedInventoryResponse>((ref) async => mockInventoryResponse());

FutureProvider<PaginatedInventoryResponse> _invEmpty() =>
    FutureProvider<PaginatedInventoryResponse>((ref) async =>
        PaginatedInventoryResponse(items: [], total: 0));

FutureProvider<PaginatedInventoryResponse> _invErr() =>
    FutureProvider<PaginatedInventoryResponse>((ref) async => throw Exception('Failed'));

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await dotenv.load(fileName: '.env.local');
  });

  // ── Auth Screen Tests ────────────────────────────────────────────────────

  group('Auth Screens', () {
    testWidgets('SplashScreen renders correctly', (tester) async {
      await tester.pumpWidget(createTestApp(
        const SplashScreen(), overrides: _base(),
      ));
      await tester.pump();
      expect(find.text('Friends Battery'), findsOneWidget);
      expect(find.byIcon(Icons.battery_charging_full), findsOneWidget);
      // Advance past the 2-second splash delay to avoid pending timer
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('LoginScreen renders form fields', (tester) async {
      await tester.pumpWidget(createTestApp(
        const LoginScreen(), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('User ID'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('LoginScreen toggles password visibility', (tester) async {
      await tester.pumpWidget(createTestApp(
        const LoginScreen(), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('RegisterScreen renders form fields', (tester) async {
      await tester.pumpWidget(createTestApp(
        const RegisterScreen(), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Create Account'), findsOneWidget);
      expect(find.text('User ID'), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Mobile Number'), findsOneWidget);
      expect(find.text('Shop Name'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('RegisterScreen shows admin flow', (tester) async {
      await tester.pumpWidget(createTestApp(
        const RegisterScreen(isAdminFlow: true), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Add Seller'), findsWidgets);
    });
  });

  // ── Admin Screens Tests ──────────────────────────────────────────────────

  group('Admin Screens', () {
    testWidgets('AdminShellScreen renders bottom nav', (tester) async {
      await tester.pumpWidget(createTestApp(
        const AdminShellScreen(child: SizedBox()), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Sellers'), findsOneWidget);
      expect(find.text('Stock'), findsOneWidget);
      expect(find.text('Shipments'), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('AdminDashboardScreen renders', (tester) async {
      await tester.pumpWidget(createTestApp(const AdminDashboardScreen(),
          overrides: [..._base(),
            dashboardControllerProvider.overrideWithProvider(
                Provider<DashboardController>((ref) => _DashCtrl(ref))),
          ]));
      await tester.pumpAndSettle();
      expect(find.text('Friends Battery'), findsOneWidget);
      expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);
      expect(find.byIcon(Icons.exit_to_app), findsOneWidget);
    });

    testWidgets('SellersListScreen shows sellers', (tester) async {
      await tester.pumpWidget(createTestApp(const SellersListScreen(),
          overrides: [..._base(),
            sl.sellersProvider.overrideWithProvider(
                FutureProvider<List<sl.SellerData>>((ref) async {
              final u = User((b) => b..id = '1'..userName = 'TestSeller'
                  ..shopName = 'Test Shop'..userNumber = '9876543210'
                  ..isVerified = true..isActive = true);
              return [sl.SellerData(seller: u, totalStock: 50, todaySales: 5, pendingShipments: 2)];
            })),
          ]));
      await tester.pumpAndSettle();
      expect(find.text('All Sellers'), findsOneWidget);
      expect(find.text('TestSeller'), findsWidgets);
    });

    testWidgets('SellersListScreen shows error state', (tester) async {
      await tester.pumpWidget(createTestApp(const SellersListScreen(),
          overrides: [..._base(),
            sl.sellersProvider.overrideWithProvider(
                FutureProvider<List<sl.SellerData>>((ref) async => throw Exception('API Error'))),
          ]));
      await tester.pumpAndSettle();
      expect(find.textContaining('API Error'), findsOneWidget);
    });

    testWidgets('SellersListScreen shows empty state', (tester) async {
      await tester.pumpWidget(createTestApp(const SellersListScreen(),
          overrides: [..._base(),
            sl.sellersProvider.overrideWithProvider(
                FutureProvider<List<sl.SellerData>>((ref) async => [])),
          ]));
      await tester.pumpAndSettle();
      expect(find.text('No sellers found.'), findsOneWidget);
    });

    testWidgets('SellerDetailsScreen renders with data', (tester) async {
      final dp = FutureProvider<SellerDetailsData>((ref) async => mockSellerDetails());
      await tester.pumpWidget(createTestApp(const SellerDetailsScreen(sellerId: 1),
          overrides: [..._base(),
            sellerDetailsProvider(1).overrideWithProvider(dp),
          ]));
      await tester.pumpAndSettle();
      expect(find.text('Seller Details'), findsOneWidget);
      expect(find.text('Test Shop'), findsOneWidget);
    });

    testWidgets('SellerDetailsScreen shows error state', (tester) async {
      final dp = FutureProvider<SellerDetailsData>((ref) async => throw Exception('Not found'));
      await tester.pumpWidget(createTestApp(const SellerDetailsScreen(sellerId: 999),
          overrides: [..._base(),
            sellerDetailsProvider(999).overrideWithProvider(dp),
          ]));
      await tester.pumpAndSettle();
      expect(find.text('Failed to load details'), findsOneWidget);
    });

    testWidgets('ShipmentListScreen shows shipments', (tester) async {
      final sp = FutureProvider<List<ShipmentSummaryModel>>((ref) async => mockShipmentSummaries());
      await tester.pumpWidget(createTestApp(const ShipmentListScreen(),
          overrides: [..._base(),
            shipmentsListProvider.overrideWithProvider(sp),
          ]));
      await tester.pumpAndSettle();
      expect(find.text('All Shipments'), findsOneWidget);
      expect(find.text('SHP-001'), findsOneWidget);
      expect(find.text('PENDING'), findsOneWidget);
    });

    testWidgets('ShipmentListScreen has FAB', (tester) async {
      await tester.pumpWidget(createTestApp(
        const ShipmentListScreen(), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('AdminShipmentDetailScreen shows details', (tester) async {
      final dp = _shipDetailOk(1);
      await tester.pumpWidget(createTestApp(const AdminShipmentDetailScreen(shipmentId: 1),
          overrides: [..._base(),
            shipmentDetailByIdProvider(1).overrideWithProvider(dp),
          ]));
      await tester.pumpAndSettle();
      expect(find.text('Shipment #1'), findsOneWidget);
    });

    testWidgets('AdminShipmentDetailScreen shows error', (tester) async {
      final dp = _shipDetailErr(999);
      await tester.pumpWidget(createTestApp(const AdminShipmentDetailScreen(shipmentId: 999),
          overrides: [..._base(),
            shipmentDetailByIdProvider(999).overrideWithProvider(dp),
          ]));
      await tester.pumpAndSettle();
      expect(find.text('Failed to load shipment'), findsOneWidget);
    });

    testWidgets('AdminSalesScreen renders', (tester) async {
      await tester.pumpWidget(createTestApp(
        const AdminSalesScreen(), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Sales History'), findsOneWidget);
    });

    testWidgets('AdminSalesScreen has search field', (tester) async {
      await tester.pumpWidget(createTestApp(
        const AdminSalesScreen(), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      expect(
        find.byWidgetPredicate((w) =>
            w is TextField && (w.decoration?.hintText?.contains('Search') ?? false)),
        findsOneWidget,
      );
    });

    testWidgets('CurrentInventoryScreen shows items', (tester) async {
      await tester.pumpWidget(createTestApp(const CurrentInventoryScreen(), overrides: [
        ..._base(),
        sharedInventoryProvider.overrideWithProvider(_invOk()),
        sharedInventoryQueryProvider.overrideWithProvider(
            StateProvider<InventoryQuery>((ref) => const InventoryQuery())),
      ]));
      await tester.pumpAndSettle();
      expect(find.text('Current Inventory'), findsOneWidget);
    });

    testWidgets('CurrentInventoryScreen shows empty state', (tester) async {
      await tester.pumpWidget(createTestApp(const CurrentInventoryScreen(), overrides: [
        ..._base(),
        sharedInventoryProvider.overrideWithProvider(_invEmpty()),
        sharedInventoryQueryProvider.overrideWithProvider(
            StateProvider<InventoryQuery>((ref) => const InventoryQuery())),
      ]));
      await tester.pumpAndSettle();
      expect(find.text('No inventory found.'), findsOneWidget);
    });

    testWidgets('CurrentInventoryScreen shows error state', (tester) async {
      await tester.pumpWidget(createTestApp(const CurrentInventoryScreen(), overrides: [
        ..._base(),
        sharedInventoryProvider.overrideWithProvider(_invErr()),
        sharedInventoryQueryProvider.overrideWithProvider(
            StateProvider<InventoryQuery>((ref) => const InventoryQuery())),
      ]));
      await tester.pumpAndSettle();
      expect(find.text('Failed to load inventory.'), findsOneWidget);
    });

    testWidgets('AddStockScreen renders', (tester) async {
      await tester.pumpWidget(createTestApp(
        const AddStockScreen(), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Add Stock'), findsOneWidget);
    });
  });

  // ── Seller Screens Tests ─────────────────────────────────────────────────

  group('Seller Screens', () {
    testWidgets('SellerShellScreen renders bottom nav', (tester) async {
      await tester.pumpWidget(createTestApp(
        const SellerShellScreen(child: SizedBox()), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Stock'), findsOneWidget);
      expect(find.text('Create Bill'), findsOneWidget);
      expect(find.text('Shipments'), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('SellerDashboardScreen renders', (tester) async {
      await tester.pumpWidget(createTestApp(const SellerDashboardScreen(), overrides: [
        ..._base(),
        sellerProfileProvider.overrideWithProvider(
            Provider<SellerProfile>((ref) => mockSellerProfile())),
        sellerKpiProvider.overrideWithProvider(
            FutureProvider<SellerKpiStats>((ref) async => mockSellerKpiStats())),
        sellerRecentInventoryProvider.overrideWithProvider(
            FutureProvider<List<RecentInventoryItem>>((ref) async => mockRecentInventoryItems())),
        sellerPendingShipmentsProvider.overrideWithProvider(
            FutureProvider<List<ApiSellerShipmentsGet200ResponseDataInner>>((ref) async => [])),
        sellerDashboardControllerProvider.overrideWithProvider(
            Provider<SellerDashboardController>((ref) => _SellDashCtrl(ref))),
      ]));
      await tester.pumpAndSettle();
      expect(find.text('Friends Battery'), findsOneWidget);
      expect(find.textContaining('Rahul'), findsOneWidget);
      expect(find.text('New Bill'), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('SellerReceivedShipmentsScreen empty', (tester) async {
      await tester.pumpWidget(createTestApp(const SellerReceivedShipmentsScreen(), overrides: [
        ..._base(),
        sellerAllShipmentsProvider.overrideWithProvider(
            FutureProvider<List<ApiSellerShipmentsGet200ResponseDataInner>>((ref) async => [])),
      ]));
      await tester.pumpAndSettle();
      expect(find.text('Received Shipments'), findsOneWidget);
      expect(find.text('No shipments yet'), findsOneWidget);
    });

    testWidgets('SellerReceivedShipmentsScreen shows data', (tester) async {
      await tester.pumpWidget(createTestApp(const SellerReceivedShipmentsScreen(), overrides: [
        ..._base(),
        sellerAllShipmentsProvider.overrideWithProvider(
            FutureProvider<List<ApiSellerShipmentsGet200ResponseDataInner>>(
                (ref) async => [mockApiShipment()])),
      ]));
      await tester.pumpAndSettle();
      expect(find.text('SHP-001'), findsOneWidget);
    });

    testWidgets('SellerSalesHistoryScreen renders', (tester) async {
      await tester.pumpWidget(createTestApp(
        const SellerSalesHistoryScreen(), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Sales History'), findsOneWidget);
    });
  });

  // ── Edge Case / Pixel Crash Tests ────────────────────────────────────────

  group('Edge Cases & Pixel Crash', () {
    testWidgets('Auth screens render at 320x480', (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 480));
      await tester.pumpWidget(createTestApp(const SplashScreen(), overrides: _base()));
      await tester.pump();
      await tester.pumpWidget(createTestApp(const LoginScreen(), overrides: _base()));
      await tester.pumpAndSettle();
      await tester.pumpWidget(createTestApp(const RegisterScreen(), overrides: _base()));
      await tester.pumpAndSettle();
      await tester.binding.setSurfaceSize(const Size(400, 800));
    });

    testWidgets('Shell screens render at 1200x1600', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 1600));
      for (final s in [
        const AdminShellScreen(child: SizedBox()),
        const SellerShellScreen(child: SizedBox()),
      ]) {
        await tester.pumpWidget(createTestApp(s, overrides: _base()));
        await tester.pumpAndSettle();
      }
      await tester.binding.setSurfaceSize(const Size(400, 800));
    });

    testWidgets('Long text does not crash login form', (tester) async {
      await tester.pumpWidget(createTestApp(const LoginScreen(), overrides: _base()));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byWidgetPredicate(
            (w) => w is TextField && w.decoration?.labelText == 'User ID'),
        'A' * 10000,
      );
      await tester.pumpAndSettle();
      expect(find.text('Login'), findsOneWidget);
    });
  });

  // ── Responsive Layout Tests ──────────────────────────────────────────────

  group('Responsive Layout', () {
    testWidgets('AdminShell hides bottom nav at 1200px', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(createTestApp(
        const AdminShellScreen(child: SizedBox()), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(BottomNavigationBar), findsNothing);
      await tester.binding.setSurfaceSize(const Size(400, 800));
    });

    testWidgets('SellerShell hides bottom nav at 1200px', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(createTestApp(
        const SellerShellScreen(child: SizedBox()), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(BottomNavigationBar), findsNothing);
      await tester.binding.setSurfaceSize(const Size(400, 800));
    });
  });

  // ── Navigation Tests ─────────────────────────────────────────────────────

  group('Navigation', () {
    testWidgets('BatteryApp starts without crashing', (tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: _base(),
        child: const BatteryApp(),
      ));
      await tester.pump();
      expect(find.text('Friends Battery'), findsOneWidget);
      // Advance past the splash delay to avoid timer pending errors
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('AdminShell bottom nav taps', (tester) async {
      await tester.pumpWidget(createTestApp(
        const AdminShellScreen(child: SizedBox()), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sellers'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dashboard'));
      await tester.pumpAndSettle();
    });

    testWidgets('SellerShell bottom nav taps', (tester) async {
      await tester.pumpWidget(createTestApp(
        const SellerShellScreen(child: SizedBox()), overrides: _base(),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Stock'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dashboard'));
      await tester.pumpAndSettle();
    });
  });
}
